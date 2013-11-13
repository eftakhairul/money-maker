require_relative "../lib/market.rb"

describe Market do
  describe "#up?" do
    it "should tell us if the stocks are going up" do
      market = Market.new
      market.up?.should be_true
    end
  end
  describe "#add_data" do
    it "should collect data" do
      market = Market.new
      market.add_price 10.00
      market.add_price 12.00
      market.add_price 13.00
      market.up?.should be_true
    end
  end
end
