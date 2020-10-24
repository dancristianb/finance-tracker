class User < ApplicationRecord
  MAX_STOCK_COUNT = 10

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name

    "anonymous"
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.find_by(ticker: ticker_symbol)
    return false if stock.nil?

    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < MAX_STOCK_COUNT
  end
end
