module PODF
    module Session
        class Session
            def new(host, driver_env)
                @host = host
                @driver_env = driver_env
            end

            def manage_driver
                @driver_env
            end
        end
    end
end
