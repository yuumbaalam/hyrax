module Hyrax
  module WorkBehavior
    extend ActiveSupport::Concern
    include Hydra::Works::WorkBehavior
    include HumanReadableType
    include Noid
    include Permissions
    include Serializers
    include Hydra::WithDepositor
    include Solrizer::Common
    include HasRepresentative
    include WithFileSets
    include Naming
    include RequiredMetadata
    include InAdminSet
    include Hydra::AccessControls::Embargoable
    include GlobalID::Identification
    include NestedWorks
    include Suppressible
    include ProxyDeposit
    include Works::Trophies
    include Works::Metadata
    include Works::Featured
    include WithEvents

    included do
      property :owner, predicate: RDF::URI.new('http://opaquenamespace.org/ns/hydra/owner'), multiple: false
      class_attribute :human_readable_short_description, :indexer
      self.indexer = WorkIndexer
    end

    module ClassMethods
      # This governs which partial to draw when you render this type of object
      def _to_partial_path #:nodoc:
        @_to_partial_path ||= begin
          element = ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.demodulize(name))
          collection = ActiveSupport::Inflector.tableize(name)
          "hyrax/#{collection}/#{element}".freeze
        end
      end
    end
  end
end
