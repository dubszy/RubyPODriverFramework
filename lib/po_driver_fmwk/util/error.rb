module PODF
    module Error

        class PODFError < StandardError; end

        class DriverError < PODFError; end
        class SessionError < PODFError; end
        class InstantiationError < PODFError; end
        class AbstractMethodError < PODFError; end
    end # Error
end # PODF
