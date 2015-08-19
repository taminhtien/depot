class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id, product_price)
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			# Updates line item price when product price changes
			current_item.update_attributes(quantity: current_item.quantity + 1, price: product_price)
		else
			current_item = line_items.build(product_id: product_id, price: product_price)
		end
		current_item
	end

	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
end
