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
  end
end
