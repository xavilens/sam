/*======================================
===    GOOGLE PLACES AUTOCOMPLETE    ===
===        update: 02/08/2016        ===
======================================*/

var autocomplete;
var componentForm;
var resource;

function initAutocomplete(tipoDir, resourceParam){
  resource = resourceParam;

  // Obtenemos los parámetros para la función Autocomplete
  var input = document.getElementById('autocomplete');
  var options   = {
      componentRestrictions: {
          country: 'es'
      }
  }

  if(tipoDir == 'cities'){
    options   = {
        types: ["("+tipoDir+")"],
        componentRestrictions: {
            country: 'es'
        }
    }
  }

  // Creamos el objeto de autocomplete y restringimos la búsqueda a ciudades.
  // Utilizando el tipo geocode podemos obtener la dirección exacta que queramos.
  autocomplete = new google.maps.places.Autocomplete(input, options);

  // Cuando el usuario elige una ciudad o dirección del dropdown se rellenará
  // automáticamente el formulario
  autocomplete.addListener( 'place_changed', fillInAddress );
}

function fillInAddress() {
    // Recibe los detalles del lugar elegido en el dropdown del autocompletado
    var place = autocomplete.getPlace();

    var campo;
    for (var component in componentForm) {

      if (component != 'street_number'){
        campo = resource+"_"+component;

        document.getElementById(campo).value = '';
      }
    }
    // Toma cada componente de la dirección de los detalles del lugar obtenido
    // y rellena los correspondientes campos en el formulario
    for (var i = 1; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];

      addressType = translateAddressType(addressType);
      campo = resource+"_"+addressType;

      if (addressType in componentForm) {
        var val = place.address_components[i][componentForm[addressType]];

        if(addressType == 'street'){

          var number_street = ''
          if(place.address_components[0][componentForm[addressType]] != null && place.address_components[0][componentForm[addressType]]!= ''){
            number_street = place.address_components[0][componentForm[addressType]];
          }

          if(number_street != '' && number_street != null)
            val += ", "+number_street;
        }

        document.getElementById(campo).value = val;
      }
    }
}

// Traduce de los tipos de dirección de Google Places a los utilizados en la aplicación
function translateAddressType(addressType){
  if(addressType == "route")
    return "street";
  else if(addressType == "locality")
    return "city";
  else if(addressType == "administrative_area_level_1")
    return "state";
  else
    return addressType;
}
