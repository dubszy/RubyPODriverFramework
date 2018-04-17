require_relative 'abstract_loadable'

module PODF
  module Loadables
    class AbstractPage
      extend AbstractLoadable
      __abstract__

      def initialize(session)
        super session
      end
    end
  end
end