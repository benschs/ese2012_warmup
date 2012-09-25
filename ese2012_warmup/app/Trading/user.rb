module Trading

  class User

    attr_accessor :name, :credit, :items

    def self.named (name)
      user = self.new
      user.name = name
      user
    end

    def initialize
      self.credit = 100
      self.items = Array.new
    end

    def add_item (item)
      items.push(item)
      item.owner = self
    end

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

    def list_items
      items.each { |item| if item.active
                           activeItems = activeItems + item.name + ", " +item.price + "\n"
                         end
      }
      activeItems
    end

  end

end

