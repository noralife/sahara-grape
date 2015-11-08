var SaharaCookie = {};

SaharaCookie.set = function(key, value) {
  var cookie = key + '=' + encodeURIComponent(value) + '; ';
  var expire = new Date();
  expire.setTime( expire.getTime() + 1000 * 3600 * 24 * 3);
  expire.toUTCString();
  cookie += 'expires=' + expire + ';';
  document.cookie = cookie;
}

SaharaCookie.get = function(key){
  var value       = null;
  var raw_cookies = document.cookie;
  // Return null if cookie does not set
  if(raw_cookies == '') return value;
  // Find value
  var cookies = raw_cookies.split(';');
  for(var i=0; i<cookies.length; i++){
    cookies[i] = $.trim(cookies[i]);
    var cookie = cookies[i].split('=');
    if(cookie[0] != key) continue;
    value = decodeURIComponent(cookie[1]);
  }
  return value;
}
