var SaharaAPI = {};

// URL SETTING
SaharaAPI.cms_url = 'http://sahara-cms:30301'
SaharaAPI.pms_url = 'http://sahara-pms:30302'
SaharaAPI.oms_url = 'http://sahara-oms:30303'

SaharaAPI.handle_standard_error = function(data){
  console.log(data);
  alert('connection error');
};

SaharaAPI.login = function(credential, callback, error_callback){
  $.ajax({
    type: "POST",
    url: SaharaAPI.cms_url + "/api/v1/login",
    data: credential,
    dataType: 'json'
  }).done(function(data){
    callback(data);
  }).fail(function(data){
    error_callback(data)
  });
};

SaharaAPI.logout = function(token, callback){
  $.ajax({
    type: "GET",
    headers: {"SAHARA-TOKEN": token},
    url: SaharaAPI.cms_url + "/api/v1/logout",
  }).done(function(data){
    callback(data);
  }).fail(function(data){
    SaharaAPI.handle_standard_error(data);
  });
};

SaharaAPI.list_products = function(callback){
  $.ajax({
    url: SaharaAPI.pms_url + "/api/v1/products",
    dataType: 'json',
  }).done(function(data){
    callback(data);
  }).fail(function(data){
    SaharaAPI.handle_standard_error(data);
  });
};

SaharaAPI.list_orders = function(token, callback){
  $.ajax({
    url: SaharaAPI.oms_url + "/api/v1/orders",
    dataType: 'json',
    headers: {"SAHARA-TOKEN": token},
  }).done(function(data){
    callback(data);
  }).fail(function(data){
    SaharaAPI.handle_standard_error(data);
  });
};

SaharaAPI.create_order = function(token, product_id, callback){
  $.ajax({
    type: "POST",
    headers: {"SAHARA-TOKEN": token},
    url: SaharaAPI.oms_url + "/api/v1/orders",
    data: {"product_id": product_id},
    dataType: 'json'
  }).done(function(data){
    callback(data);
  }).fail(function(data){
    SaharaAPI.handle_standard_error(data);
  });
};
