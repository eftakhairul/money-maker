require_relative 'client.rb'

class MoneyMaker
  def initialize market
    @wallet = Wallet.new
    @market = market
  end

  def buy
  end
end