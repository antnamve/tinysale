class AddPriceToProducts < ActiveRecord::Migration[7.2]
  def change
    add_monetize :products, :price
  end
end
