module SaharaHelpers
  def print_message(errors)
    messages = errors.messages.each.map{ |key,value|
      key.to_s + " " + value[0]
    }
    messages.join(", ")
  end

  def authenticate!
    token = headers["Sahara-Token"]
    if token.nil? || token == ""
      error!({ status: 'error', message: 'Authentication is required' }, 400)
    end
    @customer = Customer.find_by(token: token)
    if @customer.nil?
      error!({ status: 'error', message: 'Customer is not unauthorized' }, 401)
    end
  end

  def admin_only!
    unless @customer.role == "admin"
      error!({ status: 'error', message: 'forbidden' }, 403)
    end
  end

end
