class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:pay, :submit_payment]

  def new
    @order = Order.new
  end

  def create
    order = current_user.orders.new(order_params)
    order.price = 10

    if order.save
      # 轉去刷卡頁面
      redirect_to pay_order_path(id: order.serial), notice: "訂單建立成功，準備刷卡"
    else
      redirect_to plans_path, notice: "系統正在忙碌中，請稍候再試"
    end
  end

  def pay
    @token = gateway.client_token.generate
  end

  def submit_payment
    result = gateway.transaction.sale(
      amount: @order.price,
      payment_method_nonce: params[:nonce]
    )

    if result.success?
      @order.pay!
      redirect_to "/", notice: "交易成功"
    else
      @order.fail!
      redirect_to "/", notice: "交易失敗"
    end
  end

  private

  def find_order
    @order = Order.find_by!(serial: params[:id])
  end

  def order_params
    params.require(:order).permit(:note)
  end

  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: '',
      public_key: '',
      private_key: '',
    )
  end
end
