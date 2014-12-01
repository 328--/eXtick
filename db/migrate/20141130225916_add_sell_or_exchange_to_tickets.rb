class AddSellOrExchangeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :sell_or_exchange, :smallint
  end
end
