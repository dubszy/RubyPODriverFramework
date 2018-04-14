require 'rubygems'
require 'bundler/setup'
require 'test/unit'
require "po_driver_fmwk"

class SmokeTest < Test::Unit::TestCase

    def setup
        @driver_env = PODF::Session::DriverEnvironment.new(:chrome, nil)
        @session = PODF::Session::Session.new "https://www.google.com", @driver_env
    end

    def teardown
        @session.close
    end

    def test_smoke
        @session.driver_env.go_to_url "https://www.google.com"
        sleep(10)
    end

end
