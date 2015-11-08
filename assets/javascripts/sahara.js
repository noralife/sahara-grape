//
// sahara.js
//

var SaharaUI = {};

SaharaUI.product_box = function(id, name, desc){
  var html = '<div class="col-sm-6 col-md-4">';
  html += '<div class="thumbnail"><div class="caption">';
  html += '<h3>' + name + '</h3>';
  html += '<p>' + desc + '</p>';
  html += '<p><a href="#" class="btn btn-default buy" role="button" id="' + id + '" data-toggle="modal" data-target="#buy-modal">Buy</a></p>';
  html += '</div></div>';
  html += '</div>';
  return html;
}

SaharaUI.flash_message = function(type, message){
  return '<div class="alert alert-' + type + '" role="alert">' + message + '</div>';
}

$(function(){
  // Unset session
  SaharaCookie.set("saharasession", "");

  // Show product lineup gotten from API
  SaharaAPI.list_products(function(data){
    var result_html = "";
    for (i=0; i<data.length; i++) {
      result_html += SaharaUI.product_box(data[i]["id"], data[i]["name"], data[i]["desc"]);
    }
    $("#product-lineup").html(result_html);
    $('.buy').on('click', function(){
      var product_id = $(this).attr('id');
      $('#buy-modal-flash').empty();
      $('#buy-modal form').html('<input type="hidden" id="product_id" value="' + product_id + '" />');
    });
  });

  $('#login').on('click',function(){
    var email    = $('#email').val();
    var password = $('#password').val();
    SaharaAPI.login({"email": email, "password": password}, function(data){
      // Save token in cookie
      SaharaCookie.set('saharasession', data['token']);
      // Change menu bar
      $('#login-link').css("display", "none");
      $('#logout-link').removeAttr("style");
      $('#order-link').removeAttr("style");
      // Close modal window 
      $('#login-modal-flash').empty();
      $('#login-modal').modal('hide');
    }, function(data){
      $('#login-modal-flash').html(SaharaUI.flash_message('danger', 'Invalid email or password'));
    });
  });

  $('#logout-link').on('click',function(){
    var token = SaharaCookie.get("saharasession");
    SaharaAPI.logout(token, function(data){
      // Unset token
      SaharaCookie.set('saharasession', '');
      // Change menu bar
      $('#login-link').removeAttr("style");
      $('#logout-link').css("display","none");
      $('#order-link').css("display","none");
    });
  });

  $('#buy').on('click',function(){
    var product_id = $('#product_id').val();
    var token      = SaharaCookie.get("saharasession");
    if (token == "") {
      $('#buy-modal-flash').html(SaharaUI.flash_message('danger', 'Please login first.'));
    } else {
      SaharaAPI.create_order(token, product_id, function(data){
        $('#buy-modal-flash').html(
	  SaharaUI.flash_message('success', 'Successfully ordered. Please close this window.')
	);
      });
    }
  });

  // Show order list gotten from API
  $('#order-link').on('click',function(){
    var token = SaharaCookie.get("saharasession");
    SaharaAPI.list_orders(token, function(data){
      var html = '<thead><tr><th>order id</th><th>product id</th><th>created</th></tr></thead>\n';
      html += '<tbody>\n';
      for (var i=0; i<data.length; i++){
        var order = data[i];
        html += '<tr><td>' + order['id'] + '</td>\n';
	html += '<td>' + order['product_id'] + '</td>\n';
	html += '<td>' + order['created_at'] + '</td>\n';
      }
      html += '</tbody>'
      $('#order-list').html(html);
    });
  });

});
