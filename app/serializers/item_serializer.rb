class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :merchant_id, :name
  attribute :unit_price

  def unit_price
    (object.unit_price.to_f / 100).to_s
  end
end
