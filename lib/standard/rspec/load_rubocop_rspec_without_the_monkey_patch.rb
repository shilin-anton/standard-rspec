# GENERATED FILE - DO NOT EDIT
#
# This file should look just like: https://github.com/rubocop/rubocop-rspec/blob/master/lib/rubocop-rspec.rb
# Except without the `Inject.defaults!` monkey patching.
#
# Because there are both necessary require statements and additional patching
# of RuboCop built-in cops in this file, we need to monitor it for changes
# in rubocop-rails and keep it up to date.
#
# Last updated from rubocop-rspec v2.22.0

# frozen_string_literal: true

require "pathname"
require "yaml"

require "rubocop"
require "rubocop-capybara"
require "rubocop-factory_bot"

require_path = Pathname.new(Gem.loaded_specs["rubocop-rspec"].full_require_paths.first)
require require_path.join("rubocop/rspec")
# require_relative 'rubocop/rspec/inject'
require require_path.join("rubocop/rspec/language/node_pattern")
require require_path.join("rubocop/rspec/node")
require require_path.join("rubocop/rspec/version")
require require_path.join("rubocop/rspec/wording")

# Dependent on `RuboCop::RSpec::Language::NodePattern`.
require require_path.join("rubocop/rspec/language")

require require_path.join("rubocop/rspec/factory_bot/language")

require require_path.join("rubocop/cop/rspec/mixin/final_end_location")
require require_path.join("rubocop/cop/rspec/mixin/inside_example_group")
require require_path.join("rubocop/cop/rspec/mixin/location_help")
require require_path.join("rubocop/cop/rspec/mixin/metadata")
require require_path.join("rubocop/cop/rspec/mixin/namespace")
require require_path.join("rubocop/cop/rspec/mixin/skip_or_pending")
require require_path.join("rubocop/cop/rspec/mixin/top_level_group")
require require_path.join("rubocop/cop/rspec/mixin/variable")

# Dependent on `RuboCop::Cop::RSpec::FinalEndLocation`.
require require_path.join("rubocop/cop/rspec/mixin/comments_help")
require require_path.join("rubocop/cop/rspec/mixin/empty_line_separation")

require require_path.join("rubocop/cop/rspec/base")
require require_path.join("rubocop/rspec/align_let_brace")
require require_path.join("rubocop/rspec/concept")
require require_path.join("rubocop/rspec/corrector/move_node")
require require_path.join("rubocop/rspec/example")
require require_path.join("rubocop/rspec/example_group")
require require_path.join("rubocop/rspec/factory_bot")
require require_path.join("rubocop/rspec/hook")

# RuboCop::RSpec::Inject.defaults!

require require_path.join("rubocop/cop/rspec_cops")

# We have to register our autocorrect incompatibilities in RuboCop's cops
# as well so we do not hit infinite loops

RuboCop::Cop::Layout::ExtraSpacing.singleton_class.prepend(
  Module.new do
    def autocorrect_incompatible_with
      super.push(RuboCop::Cop::RSpec::AlignLeftLetBrace)
      .push(RuboCop::Cop::RSpec::AlignRightLetBrace)
    end
  end
)

RuboCop::Cop::Style::TrailingCommaInArguments.singleton_class.prepend(
  Module.new do
    def autocorrect_incompatible_with
      super.push(RuboCop::Cop::RSpec::Capybara::CurrentPathExpectation)
    end
  end
)

RuboCop::AST::Node.include(RuboCop::RSpec::Node)
