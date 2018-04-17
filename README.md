# Page Object Driver Framework
Ruby wrapper framework for Selenium WebDriver using the Page Object Model.

## Installation

### Installing for use with your application
1. Add the following line to your application's Gemfile:
```ruby
gem 'po_driver_fmwk'
```

2. Execute the following command in a terminal:
```
bundle
```

Or install it manually with:
```
gem install po_driver_fmwk
```

### Installing for development
Please refer to Development - Installation, documented below.

## Usage
### Creating a Test
To create a test which uses this framework, add the following line to the top of the test file:
```
require "po_driver_fmwk"
```

In this example, `:chrome` should be replaced with the browser to test against, and `https://www.example.com` should be
replaced with the root URL to test against.
To make use of the framework, add the following lines to the `setup` method of your test suite:
```ruby
@driver_env = PODF::Session::DriverEnvironment.new(:chrome, nil)
@session = PODF::Session::Session.new "https://www.example.com", @driver_env
```
This will create a new DriverEnvironment and Session to work with.

In your `teardown` method, simply put in the following line for cleanup:
```ruby
@session.close
```

An example test can be found in test/test/smoke/smoke_test.rb

For specific documentation on the use of these classes, refer to the READMEs in lib/po_driver_fmwk/*/README.md

## Development

### Prerequisites
To develop for this framework, [Ruby](https://www.ruby-lang.org/) and [Bundler](https://bundler.io/) must be installed.
To check if Ruby and Bundler are installed on your machine, run the following commands in a terminal:
```
which ruby
which bundler
```
To install Ruby on your machine, refer to the documentation [here](https://www.ruby-lang.org/en/downloads/).
To install Bundler on your machine, run the following command in a terminal:
```
gem install bundler
```

### Setup
Once Ruby and Bundler are installed, and you have this repo checked out, install the Ruby gems for this project. The
gems can be installed either globally or locally.

To install the gems globally, run the following command in a terminal:
```
bundle install
```

To install the gems locally, run the following command in a terminal:
```
bundle install --path vendor/bundle
```
In the above example, the path "vendor/bundle" can be replaced with any path of your choosing, but this path is ignored
in .gitignore and is known to work.

### More Documentation
Specific documentation on the classes in this framework can be found in the READMEs in lib/po_driver_fmwk/*/README.md

### Installation
To install this gem on your local machine, run the following command in a terminal:
```
bundle exec rake install
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dubszy/RubyPODriverFramework
