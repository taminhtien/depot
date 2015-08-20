require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "cart line items should contain unique products" do
  	ruby = products(:ruby)
  	rails = products(:rails)
  	cart = carts(:cart1)

  	[ruby, rails].each do |product|
      cart.add_product(product.id, product.price).save!
    end
    
    # Gets ruby product  
    ruby_item = cart.line_items.find_by(product_id: ruby.id)
    # The quantity of ruby product must be 1
    assert_equal 1, ruby_item.quantity, "Cart line item quantity is incorrect"
	end

	test "cart line items should contain duplicate products" do
  	ruby = products(:ruby)
  	cart = carts(:cart2)

    3.times do
      cart.add_product(ruby.id, ruby.price).save!
    end
  	
    # Gets ruby product  
    ruby_item = cart.line_items.find_by(product_id: ruby.id)
    # The quantity of ruby product must be 3
    assert_equal 3, ruby_item.quantity, "Cart line item quantity is incorrect"
	end

  test "cart line items price should equal most recent price" do
    ruby = products(:ruby)
    cart = carts(:cart2)
    cart.add_product(ruby.id, ruby.price).save!   
    ruby.price = 100 
    cart.add_product(ruby.id, ruby.price).save!
    # Gets ruby product  
    ruby_item = cart.line_items.find_by(product_id: ruby.id)
    # The price of ruby product must be updated
    assert_equal 100, ruby_item.price, "Cart line item price is incorrect"
  end
end