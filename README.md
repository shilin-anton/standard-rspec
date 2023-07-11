# Standard::Rspec

This gem provides a [lint_roller](https://github.com/standardrb/lint_roller) plugin configuration for the [rubocop-rspec](https://github.com/rubocop/rubocop-rspec) ruleset as an extension to the Standard Ruby gem.

Add this to your Gemfile, to install:

`gem "standard-rspec"`

## Usage

In your `.standard.yml` file, you can list standard-rspec as a plugin:
```
plugins:
  - standard-rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shilin-anton/standard-rspec.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
