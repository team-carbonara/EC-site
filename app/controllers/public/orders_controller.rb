class Public::OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
  @cart_products = current_customer.cart_products.all
  total = [] #空の配列を用意
   @cart_products.each do |cart_product|
    total << cart_product.product.add_tax_price * cart_product.quantity
   end
  @total = total.to_a.sum
  @order = Order.new
  end

  def create
    # @order_product = OrderProduct.new(order_params)
    # if @order_product.save
    #   redirect_to public_cart_products_path, notice: 'カートに商品を追加しました'
    # else
    #   redirect_to public_products_path, notice: 'カートに商品を追加するのに失敗しました'
    # end
    cart_products = current_customer.cart_products.all
  # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
    @order = current_customer.orders.new(orders_params)
  # 渡ってきた値を @order に入れます

    if @order.save
  # ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
      cart_products.each do |cart|
  # 取り出したカートアイテムの数繰り返します
  # order_item にも一緒にデータを保存する必要があるのでここで保存します
        order_product = OrderProduct.new
        order_product.product_id = cart.product_id
        order_product.order_id = @order.id
        order_product.quantity = cart.quantity
  # 購入が完了したらカート情報は削除するのでこちらに保存します
        order_product.price = cart.product.price
  # カート情報を削除するので item との紐付けが切れる前に保存します
        order_product.save
      end
      redirect_to thanks_orders_path
      cart_products.destroy_all
  # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    else
      @order = Order.new(orders_params)
      render :new
    end
  end

  def check
  @postage = 800
  @cart_products = current_customer.cart_products.all
  total = [] #空の配列を用意
   @cart_products.each do |cart_product|
    total << cart_product.product.add_tax_price * cart_product.quantity
   end
  @total = total.to_a.sum

    if params[:order][:payment_method] == Order.payment_methods.key(0)
      @payment_method = Order.payment_methods.key(0)
    elsif params[:order][:payment_method] == Order.payment_methods.key(1)
      @payment_method = Order.payment_methods.key(1)
    end

   @order = Order.new(order_params)
  # new 画面から渡ってきたデータを @order に入れます
    if params[:order][:address_number] == "1"
  # view で定義している address_number が"1"だったときにこの処理を実行します
  # form_with で @order で送っているので、order に紐付いた address_number となります。以下同様です
  # この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
      @order.name = current_customer.first_name # @order の各カラムに必要なものを入れます
      @order.address = current_customer.address

    elsif params[:order][:address_number] == "2"
  # view で定義している address_number が"2"だったときにこの処理を実行します
      if Delivery.exists?(params[:order][:registered])
  # registered は viwe で定義しています
        @order.name = Delivery.find(params[:order][:registered]).name
        @order.address = Delivery.find(params[:order][:registered]).address
        @order.post_code = Delivery.find(params[:order][:registered]).post_code
      else

        render :new
  # 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
      end

    elsif params[:order][:address_number] == "3"
  # view で定義している address_number が"3"だったときにこの処理を実行します
      address_new = current_customer.deliveries.new(address_params)
      @order.name = address_new.name
      if address_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
      else
        render :new
  # ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
      end
    else
      redirect_to 遷移したいページ # ありえないですが、万が一当てはまらないデータが渡ってきた場合の処理です
    end

  end

  def thanks
  end

  private
  def order_params
  params.require(:order).permit(:name,:post_code, :address, :total_price)
  end

  def address_params
    params.require(:order).permit(:name,:post_code, :address)
  end
  def orders_params
    params.require(:order).permit(:customer_id,:post_code, :address, :name, :payment_method, :postage, :total_price, :status )
  end
end
