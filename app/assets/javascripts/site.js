// SITE

/////////////// FORMS
// Cuenta los caracteres introducidos y devuelve los restantes hasta el máximo permitido
// ref: http://stackoverflow.com/questions/5371089/count-characters-in-textarea
function countChar(val) {
  var maxlen = 2500
  var len = val.value.length;
  if (len > maxlen) {
    val.value = val.value.substring(0, maxlen);
  } else {
    $('#charNum').text((maxlen - len) + " caracteres restantes");
  }
};

/////////////// TOOLTIP
$(document).ready(function() {
  $("[data-toggle='tooltip']").tooltip();
  $('[data-toggle="tooltip"]').tooltip();
});
