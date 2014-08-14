# mixes in logic to make a model understand how to fetch its relationships
# based on the item_id/item_item_type field combination
module VariadicItem
  extend ActiveSupport::Concern

  included do
    belongs_to :item_type
  end

  # get the item associated with the current polymorphic record into which this module has been mixed
  def item
    item_type.name.classify.constantize.find(item_id)
  end
end
