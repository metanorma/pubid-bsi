require 'forwardable'

module Pubid::Bsi
  module Identifier
    class Base < Pubid::Core::Identifier::Base
      attr_accessor :month, :supplement, :adopted, :expert_commentary, :tracked_changes, :national_annexes
      extend Forwardable

      # @param month [Integer] document's month
      # @param edition [String] document's edition version, e.g. "3.0", "1.0"
      def initialize(publisher: "BS", month: nil, edition: nil,
                     supplement: nil, number: nil, adopted: nil,
                     expert_commentary: false, tracked_changes: false,
                     national_annexes: nil, **opts)
        super(**opts.merge(publisher: publisher, number: number))
        @month = month if month
        @edition = edition if edition
        @supplement = supplement
        @adopted = adopted
        @expert_commentary = expert_commentary
        @tracked_changes = tracked_changes
        @national_annexes = national_annexes
      end

      class << self
        # Use Identifier#create to resolve identifier's type class
        def transform(params)
          identifier_params = params.map do |k, v|
            get_transformer_class.new.apply(k => v)
          end.inject({}, :merge)

          Identifier.create(**identifier_params)
        end

        def get_parser_class
          Parser
        end

        def get_renderer_class
          Renderer::Base
        end

        def get_transformer_class
          Transformer
        end
      end
    end
  end
end
