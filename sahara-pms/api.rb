require 'grape'

module SaharaPms
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    helpers SaharaHelpers

    resource :products do
      desc 'list products'
      get do
        Product.all
      end

      desc 'create product'
      params do
        requires :name,     type: String, desc: 'Product name'
        requires :desc,     type: String, desc: 'Product description'
      end
      post do
        authenticate!
        admin_only!
        product = Product.new(name: params[:name],
                              desc: params[:desc])
        if product.save
          {
            status: 'success',
            message: 'Product successfully created',
            product: product
          }
        else
          error!({ status: 'error', message: print_message(product.errors) }, 500)
        end
      end

      desc 'update product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
      end
      put ':id' do
        authenticate!
        admin_only!
        set_product!
        @product.name = params[:name] unless params[:name].nil?
        @product.desc = params[:desc] unless params[:desc].nil?
        if @product.save
          {
            status: 'success',
            message: 'Product successfully updated',
            product: @product
          }
        else
          error!({ status: 'error', message: print_message(@product.errors) }, 500)
        end
      end

      desc 'delete product'
      params do
        requires :id, type: Integer, desc: 'Product ID'
      end
      delete ':id' do
        authenticate!
        admin_only!
        set_product!
        if @product.destroy
          {
            status: 'success',
            message: 'Product successfully deleted',
            product: @product
          }
        else
          error!({ status: 'error', message: print_message(@product.errors) }, 500)
        end
      end

      desc 'get product detail'
      params do
        requires :id, type: Integer
      end
      get ':id' do
        Product.find(params[:id])
      end
    end
  end
end
