module OrderedCollection  
  
  # Provides has_ordered_collection which will sort a collection by an integer display
  # order column when the collection is persisted and a helper method, ordered_<collection>
  # will gives the current objects that have not been marked for destruction in order.
  module Collection
    extend ActiveSupport::Concern
    
    included do
    end
    
    module ClassMethods
      
      # Declares an instance method, ordered_<collection> which provides the collection, 
      # in order but with members of the collection that have been marked for destruction omitted.
      # Also adds a before_validation hook that enforces that the collection have no gaps in the 
      # field used for sorting.
      #
      # @param [Symbol] collection Name of the collection on which to enforce an order
      # @param [Hash] options
      # @param options [Symbol] :sort_field Alternative sort column on the model in the collection. Defaults to :display_order
      def has_ordered_collection(collection, options = {})
        sort_field = options[:sort_field] || :display_order
        
        self.send(:define_method, :"ordered_#{collection.to_s}") do
          self.send(collection).each do |member|
            member.send("#{sort_field}=", 0) if member.send(sort_field).blank?
          end
          
          self.send(collection).select {|member| !member.marked_for_destruction? }.sort_by(&sort_field)
        end
        
        before_validation do
          self.send(:"ordered_#{collection}").each_with_index {|member, index| member.send("#{sort_field}=",index)}
        end
      end
    end 
  end
end



ActiveRecord::Base.send :include, OrderedCollection::Collection