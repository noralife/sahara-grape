module SaharaHelpers
  CMS_URL = ENV['CMS_URL'] || 'http://localhost:9393'
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
    uri     = URI.parse(CMS_URL + '/api/v1/auth')
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, {'SAHARA-TOKEN'  => token})
    raw_response = http.request(request)
    @auth = JSON.parse(raw_response.body)
  end

  def admin_only!
    unless @auth["role"] == "admin"
      error!({ status: 'error', message: 'forbidden' }, 403)
    end
  end

  def set_product!
    @product = Product.find(params[:id])
    if @product.nil?
      error!({ status: 'error', message: 'Product is not found' }, 404)
    end
  end

end