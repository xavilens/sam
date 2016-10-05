/*======================================
===    GOOGLE PLACES AUTOCOMPLETE    ===
===        update: 02/08/2016        ===
======================================*/

var autocomplete;
// Component define los campos a rellenar en BDD
var components = null;
var resource;

function initAutocomplete(tipoDir, resourceParam){
  resource = resourceParam;

  // Obtenemos los parámetros para la función Autocomplete
  var input = document.getElementById('autocomplete');
  // Options define las opciones de búsqueda de Google Places
  var options = null;

  // Definimos Components y Options diferentes para ciudades y para direcciones completas
  if(tipoDir == 'cities'){
    options = {
      types: ["("+tipoDir+")"],
      componentRestrictions: {
        country: 'es'
      }
    }
    components = {'city':'city', 'municipality':'municipality', 'province':'province', 'region':'region', 'country':'country'};
  }else{
    options = {
      componentRestrictions: {
        country: 'es'
      }
    }
    components = {'street':'street', 'city':'city', 'postal_code':'postal_code', 'municipality':'municipality', 'province':'province', 'region':'region', 'country':'country'};
  }

  // Creamos el objeto de autocomplete y restringimos la búsqueda a ciudades.
  // Utilizando el tipo geocode podemos obtener la dirección exacta que queramos.
  autocomplete = new google.maps.places.Autocomplete(input, options);

  // Cuando el usuario elige una ciudad o dirección del dropdown se rellenará
  // automáticamente el formulario
  autocomplete.addListener( 'place_changed', fillInAddress);
}

function fillInAddress () {
  // Recibe los detalles del lugar elegido en el dropdown del autocompletado
  var place = autocomplete.getPlace();

  // Vaciamos los campos
  blankFields(resource, components);

  // Rellenamos el campo GAddress con la direccion formateada de Google Place
  setFieldValueById(resource+"_addresseable_gaddress", place.formatted_address);

  // Rellenamos cada campo de los que tenemos en el formulario
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = getAddressType(place, i);
    var addressTypeAux = translateAddressType(addressType);

    if(addressTypeAux in components){
      var fieldId = resource + "_addresseable_" + addressTypeAux;
      var val = getAddressValue(place, i);
      setFieldValueById(fieldId, val)
    }
  }
}

function blankFields(resource, components){
  for (var component in components){
    var fieldId = resource + '_addresseable_' + component;
    setFieldValueById(fieldId, '');
  }
}

function setFieldValueById(fieldId, value){
  document.getElementById(fieldId).value = value;
}

function getAddressType(place, index){
  return place.address_components[index].types[0];
}

function getAddressValue(place, index){
  return place.address_components[index].long_name;
}

// Traduce de los tipos de dirección de Google Places a los utilizados en la aplicación
function translateAddressType(addressType){
  if(addressType == "route")
    return "street";
  else if(addressType == "locality")
    return "city"; // Ciudad
  else if(addressType == "administrative_area_level_1")
    return "region"; // Comunidad Autónoma
  else if(addressType == "administrative_area_level_2")
    return "province"; // Provincia
  else if(addressType == "administrative_area_level_3")
    return addressType; // Area metropolitana/Distrito
  else if(addressType == "administrative_area_level_4")
    return "municipality"; // Municipio
  else
    return addressType;
}
