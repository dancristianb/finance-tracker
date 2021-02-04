class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock].upcase)
      if @stock.present?
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def refresh_prices
    respond_to do |format|
      Stock.refresh_prices
      @user = current_user
      @tracked_stocks = @user.stocks
      format.js { render partial: 'stocks/list' }
    end
  end
end
