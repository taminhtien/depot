require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "cart should have unique products" do
  	ruby = products(:ruby)
  	rails = products(:rails)
  	cart = carts(:cart1)
  	cart.add_product(ruby, ruby.price)
  	cart.add_product(rails, rails.price)
  	assert_equal 2, cart.line_items.size
  	assert_equal 84.45, cart.total_price
	end

	test "cart should have duplicate products" do
  	ruby = products(:ruby)
  	cart = carts(:cart2)
  	cart.add_product(ruby, ruby.price)
  	cart.add_product(ruby, ruby.price)
  	assert_equal 1, cart.line_items.size
  	assert_equal 991, cart.total_price
	end
end