// /*======================================
// ===    GOOGLE PLACES AUTOCOMPLETE    ===
// ===        update: 02/08/2016        ===
// ======================================*/
//
// var autocomplete;
// // Component define los campos a rellenar en BDD
// var components = null;
// var resource;
//
// // Función que controla el comportamiento del autocompletado de Google Places
// function initAutocomplete(tipoDir, resourceParam){
//   resource = resourceParam;
//
//   // Obtenemos los parámetros para la función Autocomplete
//   var input = document.getElementById('autocomplete');
//   // Options define las opciones de búsqueda de Google Places
//   var options = null;
//
//   // Definimos Components y Options diferentes para ciudades y para direcciones completas
//   if(tipoDir == 'cities'){
//     options = {
//       types: ["("+tipoDir+")"],
//       componentRestrictions: {
//         country: 'es'
//       }
//     }
//     components = {'city':'city', 'municipality':'municipality', 'province':'province', 'region':'region', 'country':'country'};
//   }else{
//     options = {
//       componentRestrictions: {
//         country: 'es'
//       }
//     }
//     components = {'street':'street', 'city':'city', 'postal_code':'postal_code', 'municipality':'municipality', 'province':'province', 'region':'region', 'country':'country'};
//   }
//
//   // Creamos el objeto de autocomplete y restringimos la búsqueda a ciudades.
//   // Utilizando el tipo geocode podemos obtener la dirección exacta que queramos.
//   autocomplete = new google.maps.places.Autocomplete(input, options);
//
//   // Cuando el usuario elige una ciudad o dirección del dropdown se rellenará
//   // automáticamente el formulario
//   autocomplete.addListener( 'place_changed', fillInAddress);
// }
//
// // Función que rellena los campos de la dirección necesarios
// function fillInAddress () {
//   // Recibe los detalles del lugar elegido en el dropdown del autocompletado
//   var place = autocomplete.getPlace();
//
//   // Vaciamos los campos
//   blankFields(resource, components);
//
//   // Rellenamos el campo GAddress con la dirección formateada de Google Place
//   setFieldValueById(resource+"_address_attributes_"+"gaddress", place.formatted_address);
//
//   // Rellenamos cada campo de los que tenemos en el formulario
//   var street_number_index = null;
//
//   for (var i = 0; i < place.address_components.length; i++) {
//     var addressType = getAddressType(place, i);
//     var addressTypeAux = translateAddressType(addressType);
//
//     if(addressTypeAux in components){
//       var fieldId = resource + "_address_attributes_" + addressTypeAux;
//       var val = getAddressValue(place, i);
//       setFieldValueById(fieldId, val)
//     }else if(addressTypeAux == 'street_number'){
//       street_number_index = i;
//     }
//   }
//
//   // Si el municipio no ha sido rellenado lo rellenamos con el valor de la ciudad
//   if($("#"+resource+"_address_attributes_municipality").val() == ""){
//     var text = $("#"+resource+"_address_attributes_city").val();
//     $("#"+resource+"_address_attributes_municipality").val(text);
//   }
//
//   // Si disponemos del numero de la calle lo añadiremos
//   if(street_number_index >= 0){
//     var street_numer = getAddressValue(place, street_number_index);
//     var street = $("#"+resource+"_address_attributes_street").val();
//     $("#"+resource+"_address_attributes_street").val(street+" "+street_numer);
//   }
// }
//
// // Función que vacía los campos de la dirección
// function blankFields(resource, components){
//   for (var component in components){
//     var fieldId = resource + '_address_attributes_' + component;
//     setFieldValueById(fieldId, '');
//   }
// }
//
// // Función que setea el valor del campo, seleccionando el campo por su id
// function setFieldValueById(fieldId, value){
//   document.getElementById(fieldId).value = value;
// }
//
// // Función que devuelve el tipo de dirección del objeto 'place' en el índice 'index'
// function getAddressType(place, index){
//   return place.address_components[index].types[0];
// }
//
// // Función que devuelve el valor del objeto 'place' en el índice 'index'
// function getAddressValue(place, index){
//   return place.address_components[index].long_name;
// }
//
// // Traduce de los tipos de dirección de Google Places a los utilizados en la aplicación
// function translateAddressType(addressType){
//   if(addressType == "route")
//     return "street"; // Calle
//   else if(addressType == "locality")
//     return "city"; // Ciudad
//   else if(addressType == "administrative_area_level_1")
//     return "region"; // Comunidad Autónoma
//   else if(addressType == "administrative_area_level_2")
//     return "province"; // Provincia
//   else if(addressType == "administrative_area_level_3")
//     return addressType; // Area metropolitana
//   else if(addressType == "administrative_area_level_4")
//     return "municipality"; // Municipio
//   else
//     return addressType;
// }
