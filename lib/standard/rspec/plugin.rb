require "yaml"
require "rubocop-rspec"
require "rubocop-rspec_rails"
require "rubocop-capybara"
require "rubocop-factory_bot"

module Standard
  module Rspec
    class Plugin < LintRoller::Plugin
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
        rules_value = begin
          YAML.load_file(Pathname.new(__dir__).join("../../../config/base.yml"), aliases: true)
        rescue ArgumentError
          YAML.load_file(Pathname.new(__dir__).join("../../../config/base.yml"))
        end

        LintRoller::Rules.new(
          type: :object,
          config_format: :rubocop,
          value: rules_value
        )
      end
    end
  end
end
