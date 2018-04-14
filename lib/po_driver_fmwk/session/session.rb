require_relative 'driver-environment'
require_relative 'store'
require_relative '../util/error'

module PODF
    module Session
        class Session
            attr_reader :closed, :store

            def initialize(host, driver_env)
                @host = host
                @driver_env = driver_env
                @closed = false
                @store = Store.new
            end

            def host
                begin
                    raise Error::SessionError, 'The session has already been closed' if closed
                    raise Error::SessionError, 'The host for this session is nil' if host.nil?
                    @host
                end
            end

            def switch_host=(new_host)
                begin
                    raise Error::SessionError, 'The session has already been closed' if closed
                    raise Error::SessionError, 'The host for this session is nil' if host.nil?
                    raise Error::SessionError, 'new_host cannot be nil or empty' if new_host.nil? || new_host.empty?
                    @host = new_host
                end
            end

            def driver_env
                begin
                    raise Error::SessionError, 'The session has already been closed' if closed
                    raise Error::SessionError, 'The driver environment for this session is nil' if @driver_env.nil?
                    @driver_env
                end
            end

            def close
                driver_env.close
                @closed = true
                # TODO: if driver_env.browser_open? take screenshot, add to report
                @driver_env = nil
            end
        end
    end
end
