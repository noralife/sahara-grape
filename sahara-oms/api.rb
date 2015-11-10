require 'grape'

module SaharaOms
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    helpers SaharaHelpers

    resource :orders do
      desc 'list orders'
      get do
        authenticate!
        Order.where(customer_id: @auth['customer_id'])
      end

      desc 'create order'
      params do
        requires :product_id, type: String, desc: 'Order product id'
      end
      post do
        authenticate!
        order = Order.new(customer_id: @auth['customer_id'],
                          product_id:  params[:product_id])
        order.status = params[:status] unless params[:status].nil?
        if order.save
          {
            status: 'success',
            message: 'Order successfully created',
            order: order
          }
        else
          error!({ status: 'error', message: print_message(order.errors) }, 500)
        end
      end

      desc 'update order'
      params do
        requires :id, type: Integer, desc: 'Order ID'
      end
      put ':id' do
        authenticate!
        set_order!
        @order.customer_id = @auth['customer_id']
        @order.product_id  = params[:product_id] unless params[:product_id].nil?
        @order.status = params[:status] unless params[:status].nil?
        if @order.save
          {
            status: 'success',
            message: 'Order successfully updated',
            order: @order
          }
        else
          error!({ status: 'error', message: print_message(@order.errors) }, 500)
  end
      end

      desc 'delete order'
      params do
        requires :id, type: Integer, desc: 'Order ID'
      end
      delete ':id' do
        authenticate!
        set_order!
        if @order.destroy
          {
            status: 'success',
            message: 'Order successfully deleted',
            order: @order
          }
        else
          error!({ status: 'error', message: print_message(@order.errors) }, 500)
        end
      end

      desc 'get order detail'
      params do
        requires :id, type: Integer
      end
      get ':id' do
        authenticate!
        set_order!
        @order
      end
    end
  end
end
