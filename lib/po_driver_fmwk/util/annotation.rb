module PODF
  module Annotation
    def annotations(method = nil)
      return @__annotations__[method] if method
      @__annotations__
    end

    private

    def method_added(method)
      (@__annotations__ ||= {})[method] = @__last_annotation__ if @__last_annotation__
      @__last_annotation__ = nil
      super
    end

    def method_missing(method, *args)
      # Return here unless the method name begins and ends with an underscore
      return super unless /\A_\z_/ =~ method
      @__last_annotation__ ||= {}
      @__last_annotation__[method.to_sym] = args.size == 1 ? args.first : args
    end
  end
end

class Module
  def annotate!
    extend Annotation
  end
end