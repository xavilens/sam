// Declariacion de variables
var autocomplete;
var componentForm = {
    street_number: 'short_name',
    route: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'long_name',
    country: 'long_name',
    postal_code: 'short_name'
};

// Funcion que inicializa el autocompletado
function initAutocomplete(tipoDir) {
    // Creamos variables para autocompletado
    var input = /** @type {!HTMLInputElement} */(document.getElementById('autocomplete'));
    var options;
    if (tipoDir.localeCompare('streets') == 0) {
        options = {
            componentRestrictions: {
                country: 'es'
            }
        }
    } else if (tipoDir.localeCompare('cities') == 0) {
        options = {
            types: ['(cities)'],
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

// [START region_fillform]
function fillInAddress() {
    // Recibe los detalles del lugar elegido en el dropdown del autocompletado
    var place = autocomplete.getPlace();

    for (var component in componentForm) {
        document.getElementById(component).value = '';
        // document.getElementById(component).disabled = false;
    }

    // Toma cada componente de la dirección de los detalles del lugar obtenido y rellena los correspondientes campos en el formulario
    for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];
        if (componentForm[addressType]) {
            var val = place.address_components[i][componentForm[addressType]];
            document.getElementById(addressType).value = val;
        }
    }
}
// [END region_fillform]
