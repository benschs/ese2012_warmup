require 'test/unit'
require '../Trading/item'
require '../Trading/user'

class UserTest < Test::Unit::TestCase

  def test_making_user
    user = Trading::User.named("Benjamin")
    assert_equal(user.name, "Benjamin")
    assert_equal(user.credit, 100)
    assert_equal(user.items.length, 0)
  end

  def test_adding_items
    user = Trading::User.named("Benjamin")
    item = Trading::Item.make("chair", 10)

    assert_equal(user.items.length, 0)

    user.add_item(item)

    assert_equal(user.items.length, 1)
    assert_equal(user.items[0], item)
  end

  def test_buying_items
    user1 = Trading::User.named("Benjamin")
    item1 = Trading::Item.make("chair", 10)
    user2 = Trading::User.named("Jack")
    item2 = Trading::Item.make("Table", 99)

    user1.add_item(item1)
    user1.add_item(item2)

    assert_equal(user1.items.length, 2)
    assert_equal(user1.credit, 100)
    assert_equal(user2.items.length, 0)
    assert_equal(user2.credit, 100)

    assert(user2.buy_item(item1) == false)

    item1.active = true
    user2.buy_item(item1)

    assert_equal(user1.credit, 110)
    assert_equal(user2.credit, 90)
    assert_equal(user1.items.length, 1)
    assert_equal(user2.items.length, 1)

    assert(user2.buy_item(item2) == false)
  end

  def test_list_items
    user = Trading::User.named("Benjamin")
    item1 = Trading::Item.make("chair", 10)
    item2 = Trading::Item.make("Table", 99)
    item3 = Trading::Item.make("glass", 50)
    user.add_item(item1)
    user.add_item(item2)
    user.add_item(item3)
    item1.active = true
    item2.active = false
    item3.active = true
    assert_equal(user.name, "Benjamin")
    assert_equal(user.items.length, 3)
    list = "chair, 10\nglass, 50\n"
    assert_equal(user.list_items, list)
  end

end


