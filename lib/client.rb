require 'ruby-trade'
require_relative 'wallet.rb'
require_relative 'money_maker.rb'
require_relative 'market.rb'

class MyApp
  include RubyTrade::Client

  # Called by the system when we connect to the exchange server
  def self.on_connect
    @market = Market.new
    @wallet = Wallet.new
  end

  # Called whenever something happens on the exchange
  def self.on_tick level1
    puts "Cash: #{cash}"
    puts "Stock: #{stock}"
    puts "Wallet stock: #{@wallet.stock}"
    puts "Wallet cash: #{@wallet.cash}"
    puts "Bid: #{level1["bid"]}"
    puts "Ask: #{level1["ask"]}"
    puts "Last: #{level1["last"]}"


    #@wallet.cash = cash
    #@wallet.stock = stock

    @market.add_price level1["last"]

    if @market.up?
      puts "market up"
      unless @current_order
        sell_half
      end
    else
      puts "market down"
      unless @current_order
        if @wallet.stock.zero?
          puts "wall stock zero buy"
          @current_order = [buy(100, at: @market.last), {type: :buy, amount: 100, price: @market.last}]
          @wallet.cash -= 100 * @market.last
        else
          buy_half
        end
      end
    end
  end

  # Called when an order gets filled
  def self.on_fill order, amount, price
    puts "Order ID #{order.id} was filled for #{amount} shares at $%.2f" % price
    update_wallet order, amount, price
    @current_order = nil
  end

  def update_wallet order, amount, price
    if @current_order.last[:type] == :sell
      @wallet.cash += price
    else
      @wallet.stock += amount
    end
  end

  # Called when an order gets partially filled
  def self.on_partial_fill order, amount, price
    puts "Order ID #{order.id} was partially filled for #{amount} shares at $%.2f" % price

    if @current_order.last[:type] == :sell
      @wallet.cash += priceprice
      diff = @current_order.last[:amount] - amount
      @wallet.stock += diff
    else
      @wallet.stock += amount
      diff = @current_order.last[:price] - price
      @wallet.cash += diff
    end

    # Cancel the order
    @current_order.first.cancel!
  end

  def self.sell_half
    return if @wallet.stock.zero?

    amount = @wallet.stock / 2
    @current_order = [sell(amount, at: @market.last), {type: :sell, amount: amount, price: price}]
    @wallet.stock -= amount
  end

  def self.buy_half
    puts "buying half"
    return if @wallet.cash.zero? or @market.last.zero?

    price = @wallet.cash / 2
    market_price = @market.last - 0.2  

    if price > @market.last 
      amount = price / @market.last
      @current_order = [buy(amount, at: @market.last), {type: :buy, amount: amount, price: @market.last}]
      @wallet.cash -= price
    end
  end
end

# Connect to the server
MyApp.connect_to "skynet.robbritton.com", as: "Money Maker"