require_relative "../lib/money_maker.rb"

describe MoneyMaker do
  describe "#buy" do
    it "should but stock " do
      mm = MoneyMaker.new
      mm.buy.should be_true
    end
  end
end
