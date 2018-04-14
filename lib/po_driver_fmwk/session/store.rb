module PODF
    module Session
        #
        # Wrapper for Immutable::Hash. Intended to be inherited by projects
        # which make use of this framework so that application-specific data
        # storage objects can be stored in one place.
        #
        # Each instance of Session contains an instance of Store to store data
        # as the test runs.
        #
        class Store
            attr_reader :store

            def new
                @store = Immutable::Hash.new
            end
        end # Store
    end # Session
end # PODF
