module SaharaHelpers
  CMS_URL = "http://#{ENV['CMS_PORT_3001_TCP_ADDR']}:#{ENV['CMS_PORT_3001_TCP_PORT']}"
  def print_message(errors)
    messages = errors.messages.each.map do |key, value|
      key.to_s + ' ' + value[0]
    end
    messages.join(', ')
  end

  def authenticate!
    token = headers['Sahara-Token']
    if token.nil? || token == ''
      error!({ status: 'error', message: 'Authentication is required' }, 400)
    end
    uri     = URI.parse(CMS_URL + '/api/v1/auth')
    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri, 'SAHARA-TOKEN' => token)
    raw_response = http.request(request)
    @auth = JSON.parse(raw_response.body)
  end

  def admin_only!
    unless @auth['role'] == 'admin'
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
