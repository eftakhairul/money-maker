require_relative "../lib/wallet.rb"

describe Wallet do
  describe "#cash" do
    it "should return our cash" do
      wallet = Wallet.new
      wallet.cash.should eq(10000)
    end
  end
end
