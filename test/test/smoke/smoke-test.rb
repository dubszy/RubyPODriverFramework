require "test/unit"
require 'rubygems'
require 'bundler/setup'
require_relative '../../../src/session/session'

class SmokeTest < Test::Unit::TestCase

    def setup
        @driver_env = PODF::Session::DriverEnvironment.new(:chrome, nil)
        @session = PODF::Session::Session.new "https://www.google.com", @driver_env
        @session.driver_env.go_to_url "https://www.google.com"
    end

    def teardown
        @session.close
    end

    def test_smoke
        sleep(10)
    end

end
