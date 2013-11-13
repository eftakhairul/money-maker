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

    last = 0 if last.nil?
    previous = 0 if previous.nil?
    
    last > previous
  end

  def last
    @data.last
  end

  def down?
    !up?
  end
end
