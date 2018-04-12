require 'driver-environment'
require 'store'
require '../util/error'

module PODF
    module Session
        class Session
            attr_reader :closed, :store

            def new(host, driver_env)
                @host = host
                @driver_env = driver_env
                @closed = false
                @store = Store.new
            end

            def host
                begin
                    raise SessionError, 'The session has already been closed' if closed
                    raise SessionError, 'The host for this session is nil' if host.nil?
                    @host
                end
            end

            def switch_host=(new_host)
                begin
                    raise SessionError, 'The session has already been closed' if closed
                    raise SessionError, 'The host for this session is nil' if host.nil?
                    raise SessionError, 'new_host cannot be nil or empty' if new_host.nil? || new_host.empty?
                    @host = new_host
                end
            end

            def driver_env
                begin
                    raise SessionError, 'The session has already been closed' if closed
                    raise SessionError, 'The driver environment for this session is nil' if @driver_env.nil?
                    @driver_env
                end
            end

            def close
                @closed = true
                # TODO: if driver_env.browser_open? take screenshot, add to report
                driver_env.close
                @driver_env = nil
            end
        end
    end
end
