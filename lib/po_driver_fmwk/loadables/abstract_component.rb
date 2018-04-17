require_relative 'abstract_loadable'
require_relative '../util/error'

module PODF
  module Loadables
    class AbstractComponent
      extend AbstractLoadable
      __abstract__

      attr_reader :container

      def initialize(owner, parent, container)
        raise ArgumentError, 'owner must be a subclass of AbstractPage' unless owner.is_a?(AbstractPage)
        raise ArgumentError, 'parent must be a subclass of AbstractComponent' unless parent.nil? || parent.is_a?(AbstractComponent)
        raise ArgumentError, 'container must be a Selector' unless container.is_a?(Selector)
        raise ArgumentError, 'container locator cannot be nil or empty' if container.locator.nil? || container.locator.empty?
        @owner = owner
        @parent = parent
        @container = container
      end

      #
      # Get the page that this component exists on. Must be overridden in all subclasses.
      #
      # @raise [AbstractMethodError] if this method isn't overridden
      #
      def owner
        raise AbstractMethodError, 'AbstractComponent.owner must be overridden in a subclass'
      end

      #
      # Get the page that owns this component.
      #
      # @return [AbstractPage] the page object that was passed in on initialization
      #
      def owner_inst
        @owner
      end

      #
      # Get whether this component has a parent component. This method should be called before attempting to retrieve
      # the parent component.
      #
      # @return [true] if parent is nil
      #
      # @see AbstractComponent#parent
      # @see AbstractComponent#parent_inst
      #
      def has_parent?
        @parent.nil?
      end

      #
      # Get the component that this component exists inside of, if applicable. Must be overridden in all subclasses. If
      # a subclass does not have a parent component this method should return nil
      #
      # @raise [AbstractMethodError] if this method isn't overridden
      #
      def parent
        raise AbstractMethodError, 'AbstractComponent.parent must be overridden in a subclass'
      end

      #
      # Get the instance of the parent component. This is used for returning the actual instance. To get the parent,
      # call AbstractComponent#parent.
      #
      # @see AbstractComponent#has_parent?
      # @see AbstractComponent#parent
      def parent_inst
        @parent
      end
    end
  end
end