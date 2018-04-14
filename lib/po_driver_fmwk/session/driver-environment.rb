require "selenium-webdriver"
require_relative 'driver-factory'
require_relative '../util/error'

module PODF
    module Session
        #
        # Creates an abstraction layer between WebDriver and the test framework.
        #
        class DriverEnvironment
            def initialize(browser, proxy)
                @browser = browser
                @proxy = proxy
                @closed = false
                @started = false
            end

            def driver
                begin
                    raise Error::DriverError, 'The driver environment has already been closed' if closed?
                    drv = _get_driver
                    raise Error::DriverError, 'WebDriver instance is null for this session, this session may have been closed, or there may not be any browser windows open' if drv.nil?
                    drv
                end
            end

            def refresh
                driver.navigate.refresh
            end

            def back
                driver.navigate.back
            end

            def forward
                driver.navigate.forward
            end

            def go_to_url(url)
                driver.get(url)
            end

            def execute_js(script, async, *args)
                if async
                    driver.execute_async_script :script, args: args
                else
                    driver.execute_script :script, args: args
                end
            end

            def open_browser
                begin
                    raise Error::DriverError, 'The driver environment has already been closed' if closed?
                    raise Error::DriverError, 'The driver instance is not closed, the browser window may already be open' if _get_driver.nil?
                    _get_driver unless started?
                end
            end

            def close_browser
                raise Error::DriverError, 'The driver environment has already been closed' if closed?
                driver.quit unless closed?
            end

            def browser_open?
                true unless driver.nil?
            end

            def proxy
                begin
                    raise Error::DriverError, 'The driver environment has already been closed' if closed?
                    @proxy
                end
            end

            def proxy=(proxy)
                begin
                    raise Error::DriverError, 'The driver environment has already been closed' if closed?
                    @proxy = proxy
                end
            end

            def closed?
                @closed
            end

            def close
                @closed = true
                @driver.quit unless @driver.nil?
            end

            private

            def _get_driver
                unless @started
                    if !@driver.nil? && !closed?
                        @driver.quit
                    else
                        start
                    end
                end
                @driver
            end

            def start
                @started = true
                @driver.quit unless @driver.nil?
                df = DriverFactory.new(File.absolute_path("res/drivers/chromedriver"))
                @driver = df.get(@browser, proxy)
            end
        end
    end
end
