class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :merchant_id, :name
  attribute :unit_price
end
