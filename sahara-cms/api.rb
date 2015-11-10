require 'grape'

module SaharaCms
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    helpers SaharaHelpers

    resource :login do
      desc 'login'
      params do
        requires :email,    type: String, desc: 'Your email'
        requires :password, type: String, desc: 'Login password'
      end
      post do
        customer = Customer.find_by(
          email: params[:email],
          password: params[:password]
        )
        if customer.nil?
          error!({ status: 'error', message: 'Email or Password is wrong' }, 400)
        else
          customer.token = SecureRandom.uuid
          customer.save
          {
            status: 'success',
            message: 'Customer successfully logined.',
            token: customer.token,
            customer_id: customer.id
          }
        end
      end
    end

    resource :logout do
      desc 'logout'
      get do
        authenticate!
        @customer.token = ''
        @customer.save
        { status: 'success', message: 'Customer successfully logouted.' }
      end
    end

    resource :auth do
      desc 'authorize customers'
      get do
        authenticate!
        {
          status: 'success',
          message: 'Customer successfully authorized.',
          customer_id: @customer.id,
          role: @customer.role
        }
      end
    end

    resource :customers do
      desc 'list customers'
      get do
        authenticate!
        admin_only!
        Customer.all
      end

      desc 'create customer'
      params do
        requires :name,     type: String, desc: 'Your name'
        requires :email,    type: String, desc: 'Your email'
        requires :password, type: String, desc: 'Login password'
        requires :role,     type: String, desc: 'Role'
      end
      post do
        authenticate!
        admin_only!
        customer = Customer.new(name: params[:name],
                                email: params[:email],
                                password: params[:password],
                                role: params[:role])
        if customer.save
          {
            status: 'success',
            message: 'Customer successfully created',
            customer: customer
          }
        else
          error!({ status: 'error', message: print_message(customer.errors) }, 500)
        end
      end

      desc 'update customer'
      params do
        requires :id, type: Integer, desc: 'Customer ID'
      end
      put ':id' do
        authenticate!
        @customer.name     = params[:name]     unless params[:name].nil?
        @customer.email    = params[:email]    unless params[:email].nil?
        @customer.password = params[:password] unless params[:password].nil?
        if @customer.save
          {
            status: 'success',
            message: 'Customer successfully updated',
            customer: @customer
          }
        else
          error!({ status: 'error', message: print_message(@customer.errors) }, 500)
        end
      end

      desc 'delete customer'
      params do
        requires :id, type: Integer, desc: 'Customer ID'
      end
      delete ':id' do
        authenticate!
        if @customer.destroy
          {
            status: 'success',
            message: 'Customer successfully deleted',
            customer: @customer
          }
        else
          error!({ status: 'error', message: print_message(@customer.errors) }, 500)
        end
      end

      desc 'get customer detail'
      params do
        requires :id, type: Integer
      end
      get ':id' do
        authenticate!
        @customer
      end
    end
  end
end
