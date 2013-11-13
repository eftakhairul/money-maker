class Market
  def initialize
    @data = []
  end

  def add_price price
    @data.push price
  end

  def up?
    return true if @data.empty?
    last = @data[-1]
    previous = @data[-2]
    last > previous
  end

  def down?
    !up?
  end
end
