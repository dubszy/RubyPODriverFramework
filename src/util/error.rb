module PODF
    module Error

        class PODFError < StandardError; end

        class DriverError < PODFError; end
        class SessionError < PODFError; end
    end # Error
end # PODF
