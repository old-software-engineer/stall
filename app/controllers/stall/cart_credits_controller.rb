module Stall
  class CartCreditsController < Stall::ApplicationController
    before_action :load_cart

    def update
      credit_usage_service.call
      render 'stall/carts/show'
    end

    def destroy
      credit_usage_service.clean_credit_note_adjustments!
      render 'stall/carts/show'
    end

    private

    def load_cart
      @cart = ProductList.find_by_token(params[:cart_id]) || current_cart
    end

    def credit_usage_service
      @credit_usage_service ||=Stall.config.service_for(:credit_usage).new(
        @cart, amount: params[:amount]
      )
    end
  end
end
