class PaymentsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:stripe_callback]
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

  def stripe_callback
    payment_guid = params[:guid]

    @payment = Payment.find_by(guid: payment_guid)

    return unless @payment.present?

    customer = ::Stripe::Customer.create({
                                             :email => params[:stripeEmail],
                                             :source  => params[:stripeToken]
                                         },
                                         {:api_key => current_account.stripe_sk}
    )

    customer_reference = customer.id
    # Charge the user's card:
    charge = ::Stripe::Charge.create({
                                         :amount => @payment.amount_in_pence,
                                         :currency => 'GBP',
                                         :description => @payment.description,
                                         :customer => customer_reference},
                                     {:api_key => current_account.stripe_sk} #, :idempotency_key => payment.guid}
    )


    @payment.external_id = charge.id
    @payment.amount_requested = @payment.amount
    @payment.status_message = charge.outcome.seller_message
    
    if charge.paid
      fee_info = get_charge_costs(charge)
      @payment.amount_received = fee_info[:received]
      @payment.amount_fees = fee_info[:fees]
      @payment.status = 'paid'
      @payment.paid_at = Time.now
    else
      @payment.amount_received = 0.0
      @payment.amount_fees = 0.0
      @payment.status = 'failed'
      @payment.updated_at = Time.now
    end

    @payment.save

    render :show
  end



  private

  def get_charge_costs(charge)
    begin
      balance_transaction = ::Stripe::BalanceTransaction.retrieve(charge.balance_transaction,
                                                                  {:api_key => current_account.stripe_sk})
      {fees: balance_transaction.fee / 100.0,
       amount: balance_transaction.amount / 100.0,
       received: balance_transaction.net / 100.0}
    rescue Exception
      {fees: 0.00,
       amount: charge.amount / 100.0,
       received: charge.amount / 100.0}
    end
  end


  def strong_params
    params[:payment].permit( [:email,
                              :description,
                              :amount])
  end
end