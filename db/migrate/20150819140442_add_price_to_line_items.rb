class AddPriceToLineItems < ActiveRecord::Migration
  def up
  	# Adds column price
    add_column :line_items, :price, :decimal

    # Updates line item's price based on its product price
    LineItem.find(:all).each do |line_item|
    	line_item.update_attribute :price, line_item.product.price
    end
  end

  def down
  	remove_column :line_items, :price
  end
end
