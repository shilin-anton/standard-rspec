require "test_helper"

module Standard::Rspec
  class PluginTest < Minitest::Test
    def setup
    end

    def test_default_configuration
      subject = Plugin.new({})

      result = subject.rules(LintRoller::Context.new)

      assert_equal(LintRoller::Rules.new(
        type: :object,
        config_format: :rubocop,
        value: YAML.load_file(Pathname.new(__dir__).join("../../../config/base.yml"), aliases: true)
      ), result)
    end

    def test_configuring_action_policy
      subject = Plugin.new(({"action_policy_enabled" => true}))

      result = subject.rules(LintRoller::Context.new)
      inherit_hash = { "action_policy" => "config/rubocop-rspec.yml" }

      assert_equal inherit_hash, result.value["inherit_gem"]
    end

    def test_configuring_action_policy_not_enabled
      subject = Plugin.new(({"action_policy_enabled" => false}))

      result = subject.rules(LintRoller::Context.new)

      assert_equal(LintRoller::Rules.new(
        type: :object,
        config_format: :rubocop,
        value: YAML.load_file(Pathname.new(__dir__).join("../../../config/base.yml"), aliases: true)
      ), result)
    end
  end
end
