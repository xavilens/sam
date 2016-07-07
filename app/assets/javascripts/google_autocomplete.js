var autocomplete;
var tipoDir;
var input;
var options;

var componentForm = {
    city: 'long_name',
    state: 'long_name'
};


function initAutocomplete(){
    input = document.getElementById('autocomplete');
    options   = {
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

// [START region_fillform]
function fillInAddress() {
    // Recibe los detalles del lugar elegido en el dropdown del autocompletado

    var place = autocomplete.getPlace();

    for (var component in componentForm) {
      document.getElementById(""+component).value = '';
      // document.getElementById(component).disabled = false;
    }

    // Toma cada componente de la dirección de los detalles del lugar obtenido y rellena los correspondientes campos en el formulario
    for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];

        addressType = translateAddressType(addressType);
        if (addressType in componentForm) {
          var val = place.address_components[i][componentForm[addressType]];

          document.getElementById(addressType).value = val;
        }
    }
}

function translateAddressType(addressType){
  if(addressType == "street_number")
    return addressType;
  else if(addressType == "route")
    return "street";
  else if(addressType == "locality")
    return "city";
  else if(addressType == "administrative_area_level_1")
    return "state";
  else if(addressType == "country")
    return addressType;
}

// [END region_fillform]