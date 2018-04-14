module PODF
  module Annotation
    def annotations(method = nil)
      return @__annotations__[method] if method
      @__annotations__
    end

    private

    def method_added(method)
      # Return here unless the method begins and ends with an underscore
      return super unless /\A_\z_/ =~ method
      # Add the annotation to @__annotations__, creating a new hash if @__annotations__ is nil
      (@__annotations__ ||= {})[method] = @__annotation__[method.to_sym] = args.size == 1 ? args.first : args
      super
    end
  end
end
