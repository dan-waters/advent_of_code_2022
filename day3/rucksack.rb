class Rucksack
  def initialize(str)
    @item_count = str.length
    @compartment_1, @compartment_2 = [str[0, @item_count/2], str[@item_count/2..-1]].map(&:chars)
  end

  def items
    @items ||= @compartment_1 + @compartment_2
  end

  def shared_items
    @shared_items ||= (@compartment_1 & @compartment_2).uniq
  end

  def shared_item
    raise if shared_items.count != 1
    shared_items.first
  end

  def to_s
    "Rucksack #<Total Items: #{@item_count}, Compartment 1: #{@compartment_1.join}, Compartment 2: #{@compartment_2.join}>"
  end
end
