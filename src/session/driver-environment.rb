require "selenium-webdriver"
require 'driver-factory'

module PODF
    module Session
        #
        # Creates an abstraction layer between WebDriver and the test framework.
        #
        class DriverEnvironment
            def new(browser, proxy)
                @driver = DriverFactory.get(browser, proxy)
            end

            def get_driver
                @driver
            end

            def refresh
                get_driver.navigate.refresh
            end

            def back
                get_driver.navigate.back
            end

            def forward
                get_driver.navigate.forward
            end

            def go_to_url(url)
                get_driver.get(url)
            end
        end
    end
end
