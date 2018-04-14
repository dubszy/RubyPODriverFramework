module PODF
    module WebDriver
        class ByType
            include Enumerable

            def each
                yield :class
                yield :css
                yield :id
                yield :link_text
                yield :name
                yield :partial_link_text
                yield :tag_name
                yield :xpath
            end
        end # ByType
    end # WebDriver
end # PODF
