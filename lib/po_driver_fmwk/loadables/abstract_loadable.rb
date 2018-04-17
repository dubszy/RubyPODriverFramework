require_relative '../util/annotation'

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

      attr_reader :session

      def initialize(session)
        @session = session
      end

    end # AbstractLoadable
  end # Loadables
end # PODF
