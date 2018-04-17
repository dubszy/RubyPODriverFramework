require "selenium-webdriver"
require 'by_type'

module PODF
    module WebDriver
        #
        # Creates an abstraction layer between Element and the test framework.
        # Ideally, this class removes the possibility of StaleElementReferenceErrors
        # being thrown, because a new Element instance is requested each time any
        # action is preformed on an element.
        #
        class Selector
            attr_reader :session, :locator, :by_type

            def initialize(session, locator, by_type)
                begin
                    raise ArgumentError, 'session cannot be nil' if session.nil?
                    raise ArgumentError, 'locator cannot be nil or empty' if locator.nil? || locator.empty?
                    raise ArgumentError, 'by_type cannot be nil' if by_type.nil?
                    raise ArgumentError, 'by_type must be an instance of ByType' unless by_type.is_a?(ByType)

                    @session = session
                    @locator = locator
                    @by_type = by_type
                end
            end

            #
            # Get a new instance of Selenium::WebDriver::Element represented by
            # the first element found by this instance's locator.
            #
            # @return [Selenium::WebDriver::Element] A new WebDriver Element
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            # @raise [ArgumentError] if the element cannot be found by by_type
            #
            # @see Selenium::WebDriver::Driver#find_element
            # @see Selenium::WebDriver::SearchContext#find_element
            #
            def get
                begin
                    session.driver_env.driver.find_element(by_type, locator)
                rescue Selenium::WebDriver::Error::NoSuchElementError => e
                    raise e, e.message +
                                "\nLocator Type: " + by_type.to_s +
                                "\nLocator: " + locator +
                                "\nCalled from thread: " + Thread.current.to_s +
                                "\nCurrent URL: " + session.driver_env.driver.current_url,
                            e.backtrace
                end
            end

# --- Introspection and Equality --- #

            def inspect
                format '#<%s:0x%x session=%s   locator=%s   by_type=%s>',
                        self.class, hash * 2, @session.inspect, @locator.inspect,
                        @by_type.inspect
            end

            def ==(other)
                other.is_a?(self.class) &&
                session == other.session &&
                locator == other.locator &&
                by_type == other.by_type
            end

            def hash
                @session.hash ^ @locator.hash ^ @by_type.hash
            end

# --- Element Information --- #

            # Get the value of a given attribute of the element identified by
            # this Selector. This method will return the value of the given
            # attribute, unless that attribute is not present, in which case the
            # value of the property with the same name is returned. If neither
            # value is set, nil is returned. For a more complete definition, see
            # Selenium::WebDriver::Element#attribute(name)
            #
            # @param [String] name attribute name
            # @return [String, nil] attribute value
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#attribute(name)
            #
            def attribute(name)
                get.attribute name
            end

            #
            # Get the value of a given CSS property.
            #
            # Note that shorthard CSS properties (e.g. background, font, border,
            # border-top, margin, margin-top, padding, padding-top, list-style,
            # outline, pause, cue) are not returned, in accordance with the DOM
            # CSS2 specification - you should directly access the longhand
            # properties (e.g. background-color) to access the desired values.
            #
            # @return [String] The value of the given CSS property
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#css_value(prop)
            # @see http://www.w3.org/TR/DOM-Level-2-Style/css.html#CSS-CSSStyleDeclaration
            #
            def css_value(prop)
                get.css_value prop
            end
            alias_method :style, :css_value

            #
            # Is the element idenfied by this Selector displayed?
            #
            # @return [Boolean] whether the element is displayed
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#displayed?
            #
            def displayed?
                get.displayed?
            end

            #
            # Is the element identified by this Selector enabled?
            #
            # @return [Boolean] whether the element is enabled
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#enabled?
            #
            def enabled?
                get.enabled?
            end

            #
            # Get the location of the element identified by this Selector.
            #
            # @return [Selenium::WebDriver::Point] the location of the element
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#location
            #
            def location
                get.location
            end

            #
            # Determine the location of the element identified by this Selector
            # once it has been scrolled into view.
            #
            # @return [Selenium::WebDriver::Point] the location of the element
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#location_once_scrolled_into_view
            #
            def location_once_scrolled_into_view
                get.location_once_scrolled_into_view
            end

            #
            # Get the value of a given property with the same name of the element
            # identified by this Selector. If the value is not set, nil is returned.
            #
            # @param [String] name property name
            # @return [String, nil] property value
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#property(name)
            #
            def property(name)
                get.property name
            end

            #
            # Get the dimensions and coordinates of the element identified by
            # this Selector.
            #
            # @return [Selenium::WebDriver::Rectangle] the dimensions and coordinates of the element
            #
            # @see Selenium::WebDriver::Element#rect
            #
            def rect
                get.rect
            end

            #
            # Is the element identified by this Selector selected?
            #
            # @return [Boolean] whether the element is selected
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#selected?
            #
            def selected?
                get.selected?
            end

            #
            # Get the size of the element identified by this Selector.
            #
            # @return [Selenium::WebDriver::Dimension] the size of the element
            #
            # @see Selenium::WebDriver::Element#size
            #
            def size
                get.size
            end

            #
            # Get the tag name of the element identified by this Selector.
            #
            # @return [String] The tag name of the element identified by this Selector
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#tag_name
            #
            def tag_name
                get.tag_name
            end

            #
            # Get the text content of the element identified by this Selector.
            #
            # @return [String] The text content of the element identified by this Selector
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#text
            #
            def text
                get.text
            end

# --- WebDriver Element Actions --- #

            #
            # If the element identified by this Selector is a text entry element,
            # this will clear the value. Has no effect on other elements. Text
            # entry elements are <input> and <textarea> elements.
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#clear
            #
            def clear
                get.clear
            end

            #
            # Click the element identified by this Selector.
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#clear
            #
            def click
                get.click
            end

            #
            # Submit the element identified by this Selector.
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#submit
            def submit
                get.submit
            end

            #
            # Send keystrokes to the element identified by this Selector.
            #
            # @param [String, Symbol, Array] args keystrokes to send
            #
            # Examples:
            #     selector.send_keys "foo"                    #=> value: 'foo'
            #     selector.send_keys "tet", :arrow_left, "s"  #=> value: 'test'
            #     selector.send_keys [:control, 'a'], :space  #=> value: ' '
            #
            # @raise [NoSuchElementError] if the element doesn't exist
            #
            # @see Selenium::WebDriver::Element#send_keys(*args)
            #
            def send_keys(*args)
                get.send_keys text
            end
        end # Selector
    end # WebDriver
end # PODF
