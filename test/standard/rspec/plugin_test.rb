require "test_helper"

module Standard::Rspec
  class PluginTest < Minitest::Test
    def setup
    end

    def test_default_configuration
      subject = Plugin.new({})

      result = subject.rules(LintRoller::Context.new)

      rules_path = Pathname.new(__dir__).join("../../../config/base.yml")
      rules_value = begin
        YAML.load_file(rules_path, aliases: true)
      rescue ArgumentError
        YAML.load_file(rules_path)
      end

      assert_equal(LintRoller::Rules.new(
        type: :object,
        config_format: :rubocop,
        value: rules_value
      ), result)

      config = RuboCop::Config.new({"RSpec" => {"TargetRubyVersion" => RUBY_VERSION}}, rules_path)
      RuboCop::ConfigValidator.new(config).validate
    end
  end
end
