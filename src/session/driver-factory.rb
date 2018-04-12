module PODF
    module Session
        #
        # Java-style factory for generating pre-designed WebDriver instances.
        # Currently only supports Chrome and Firefox.
        #
        class DriverFactory
            def initialize(driver_path)
                @driver_path = driver_path
            end

            def get(browser, proxy_server)
                proxy = proxy_server.strip unless proxy_server.nil?

                case browser
                when :chrome
                    options = Selenium::WebDriver::Chrome::Options.new
                    options.add_argument('--ignore-certificate-errors')
                    options.add_argument('--new-window')
                    unless proxy.nil? || proxy.empty?
                        options.add_argument('--proxy-server=#{proxy}')
                    end
                    options.add_preference('download.prompt_for_download', false)
                    options.add_preference('profile.content_settings.pattern_pairs.*.multiple-automatic-downloads', 1)
                    options.add_preference('safebrowsing.enabled', false)

                    Selenium::WebDriver::Chrome.driver_path = @driver_path
                    Selenium::WebDriver.for :chrome, options: options
                when :firefox, :ff
                    profile = Selenium::WebDriver::Firefox::Profile.new
                    unless proxy.nil? || proxy.empty?
                        profile.proxy = Selenium::WebDriver::Proxy.new(http: proxy)
                    end
                    options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
                    Selenium::WebDriver.for :firefox, options: options
                else
                    Selenium::WebDriver.for(browser)
                end
            end
        end
    end
end
