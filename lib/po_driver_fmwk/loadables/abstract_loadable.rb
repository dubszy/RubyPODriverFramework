require_relative '../util/annotation'
require_relative '../util/abstract_class'

module PODF
  module Loadables
    module Loadable
      annotate!
      extend Annotation

      class Info
        @path = ''

        def path
          @path
        end

        def path=(path)
          raise ArgumentError,
                'path must be a string' unless (path.is_a?(String))
          @path = path
        end
      end # Info

      class IsLoaded

        @visible = false
        @contains_text = ''

        def visible?
          @visible
        end

        def visible=(is_visible)
          raise ArgumentError,
                'is_visible must be a boolean' unless (is_visible.is_a?(TrueClass) || is_visible.is_a?(FalseClass))
          @visible = is_visible
        end
        end

        def contains_text
          @contains_text
        end

        def contains_text=(text_to_contain)
          raise ArgumentError,
                'text_to_contain must be a string' unless text_to_contain.is_a?(String)
          @contains_text = text_to_contain
        end # IsLoaded
    end # Loadable


    class AbstractLoadable
      extend Loadable
      abstract!
      __abstract__

      attr_reader :session

      def initialize(session)
        @session = session
      end

      # TODO: consider reworking Selector to provide support for comments
      #
      # Since there is no CSS selector for comments,
      # this is a little funky.
      def comments
        session.driver_env.execute_js("$('*').contents().filter(function(){ return this.nodeType===8; })")
      end

    end # AbstractLoadable
  end # Loadables
end # PODF
