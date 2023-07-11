require "yaml"

module Standard
  module Rspec
    class Plugin < LintRoller::Plugin
      def initialize(config)
        @config = config
      end

      def about
        LintRoller::About.new(
          name: "standard-rspec",
          version: VERSION,
          homepage: "https://github.com/shilin-anton/standard-rspec",
          description: "Configuration for rubocop-rspec rules"
        )
      end

      def supported?(context)
        true
      end

      def rules(context)
        trick_rubocop_into_thinking_we_required_rubocop_rspec!

        LintRoller::Rules.new(
          type: :object,
          config_format: :rubocop,
          value: rules_with_config_applied
        )
      end

      private

      def rules_with_config_applied
        YAML.load_file(Pathname.new(__dir__).join("../../../config/base.yml"), aliases: true).tap do |rules|
          if @config["action_policy_enabled"]
            rules["inherit_gem"] = { "action_policy" => "config/rubocop-rspec.yml" }
          end
        end
      end

      # This is not fantastic.
      #
      # When you `require "rubocop-rspec"`, it will not only load the cops,
      # but it will also monkey-patch RuboCop's default_configuration, which is
      # something that can't be undone for the lifetime of the process.
      #
      # See: https://github.com/rubocop/rubocop-rspec/blob/master/lib/rubocop-rspec.rb#L41
      #
      # As an alternative, standard-rspec loads the cops directly, and then
      # simply tells the RuboCop config loader that it's been loaded. This is
      # taking advantage of a private API of an `attr_reader` that probably wasn't
      # meant to be mutated externally, but it's better than the `Inject` monkey
      # patching that rubocop-rspec does (and many other RuboCop plugins do)
      def trick_rubocop_into_thinking_we_required_rubocop_rspec!
        without_warnings do
          require_relative "load_rubocop_rspec_without_the_monkey_patch"
        end
        RuboCop::ConfigLoader.default_configuration.loaded_features.add("rubocop-rspec")
      end

      # This is also not fantastic, but because loading RuboCop before loading
      # ActiveSupport will result in RuboCop redefining a number of ActiveSupport
      # methods like String#blank?, we need to suppress the warnings that are
      # emitted when we load the cops.
      def without_warnings(&blk)
        original_verbose = $VERBOSE
        $VERBOSE = nil
        yield
      ensure
        $VERBOSE = original_verbose
      end
    end
  end
end
