/*======================================
===    GOOGLE PLACES AUTOCOMPLETE    ===
===        update: 09/07/2016        ===
======================================*/

var autocomplete;
var componentForm;
var resource;

function initAutocomplete(tipoDir, resourceParam){
  resource = resourceParam;

  // Obtenemos los parámetros para la función Autocomplete
  var input = document.getElementById('autocomplete');
  var options   = {
      types: ["("+tipoDir+")"],
      componentRestrictions: {
          country: 'es'
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

    for (var component in componentForm) {
      alert(resource+"_"+component);
      document.getElementById(resource+"_"+component).value = '';
      // document.getElementById(component).disabled = false;
    }
    // Toma cada componente de la dirección de los detalles del lugar obtenido
    // y rellena los correspondientes campos en el formulario
    for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];

        if (addressType in componentForm) {
          var val = place.address_components[i][componentForm[addressType]];

          document.getElementById(resource+"_"+addressType).value = val;
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
