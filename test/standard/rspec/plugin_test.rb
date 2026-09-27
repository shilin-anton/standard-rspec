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

    def test_negation_be_valid_has_a_style
      rules = Plugin.new({}).rules(LintRoller::Context.new).value
      config = RuboCop::Config.new(rules, "config/base.yml")
      cop = RuboCop::Cop::RSpecRails::NegationBeValid.new(config)
      source = RuboCop::ProcessedSource.new("expect(foo).to be_invalid", RUBY_VERSION.to_f)

      report = RuboCop::Cop::Commissioner.new([cop]).investigate(source)

      assert_empty report.errors, report.errors.map(&:message).join("\n")
      assert_equal 1, report.offenses.size
    end
  end
end
