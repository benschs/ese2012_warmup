require 'test/unit'
require '../Trading/item'
require '../Trading/user'

class ItemTest < Test::Unit::TestCase

  def test_making_item
    item = Trading::Item.make("House", 50)
    assert_equal(item.name, "House")
    assert_equal(item.price, 50)
    assert(!item.active)
    assert_equal(item.owner, nil)
  end

  def test_to_s
    item = Trading::Item.make("House", 50)
    string1 = "Name: House, price: 50, status: inactive, owner: "

    assert_equal(item.to_s, string1)

    user = Trading::User.named("Benjamin")
    user.add_item(item)
    item.active = true
    string2 =  "Name: House, price: 50, status: active, owner: Benjamin"

    assert_equal(item.to_s, string2)
  end
end




