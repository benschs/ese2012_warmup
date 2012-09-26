module Trading

  class User

    attr_accessor :name, :credit, :items

    #constructor
    def self.named (name)
      user = self.new
      user.name = name
      user
    end

    def initialize
      self.credit = 100
      self.items = Array.new
    end

    #defines owner of item
    def add_item (item)
      items.push(item)
      item.owner = self
      item.ownerName = self.name
    end

    #swaps credit for item with the owner of the item
    def buy_item (item)
      if item.price > credit || !item.active
        false
      else
        item.owner.get_credit(item.price)
        self.lose_credit(item.price)
        item.owner.items.delete(item)
        self.add_item(item)
        item.active = false
        true
      end
    end

    def get_credit (amount)
      self.credit += amount
    end

    def lose_credit (amount)
      self.credit -= amount
    end

    #list all items for sale
    def list_items
      activeItems = ""
      items.each { |item| if item.active
                           activeItems = activeItems + "#{item.name}, #{item.price}\n"
                         end
      }
      activeItems
    end
  end
end

