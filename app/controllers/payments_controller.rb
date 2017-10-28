class PaymentsController < ApplicationController
  def index
    @payments = current_account.payments
  end

  def new
    @payment = current_account.payments.build
  end

  def create
    @payment = current_account.payments.build(strong_params)

    if @payment.save
      render :show
    end
  end

  def show
    @payment = current_account.payments.find(params[:id])
  end

  private

  def strong_params
    params[:payment].permit( [:email,
                              :description,
                              :amount_requested])
  end
end