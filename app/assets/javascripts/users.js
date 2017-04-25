// USERS
//// USER_SEARCH_FORM
// FIXME: Crear método genérico y ¿pasar a un script?
$(document).ready(function(){
  $("input[name='user_search_form[location_type]']").change(function(){
    location_type = $(this).val();

    switch (location_type) {
      case "city":
        $("#user_search_form_city").val("");
        $(".user_search_form_city").removeClass("hidden");
        $(".user_search_form_province").addClass("hidden");
        $(".user_search_form_region").addClass("hidden");
        break;
      case "province":
        $("#user_search_form_province").val("");
        $(".user_search_form_province").removeClass("hidden");
        $(".user_search_form_city").addClass("hidden");
        $(".user_search_form_region").addClass("hidden");
        break;
      case "region":
        $("#user_search_form_region").val("");
        $(".user_search_form_region").removeClass("hidden");
        $(".user_search_form_city").addClass("hidden");
        $(".user_search_form_province").addClass("hidden");
        break;
      default:

    }
  });

  $("input[name='musician_search_form[location_type]']").change(function(){
    location_type = $(this).val();

    switch (location_type) {
      case "city":
        $("#musician_search_form_city").val("");
        $(".musician_search_form_city").removeClass("hidden");
        $(".musician_search_form_province").addClass("hidden");
        $(".musician_search_form_region").addClass("hidden");
        break;
      case "province":
        $("#musician_search_form_province").val("");
        $(".musician_search_form_province").removeClass("hidden");
        $(".musician_search_form_city").addClass("hidden");
        $(".musician_search_form_region").addClass("hidden");
        break;
      case "region":
        $("#musician_search_form_region").val("");
        $(".musician_search_form_region").removeClass("hidden");
        $(".musician_search_form_city").addClass("hidden");
        $(".musician_search_form_province").addClass("hidden");
        break;
      default:

    }
  });

  $("input[name='band_search_form[location_type]']").change(function(){
    location_type = $(this).val();

    switch (location_type) {
      case "city":
        $("#band_search_form_city").val("");
        $(".band_search_form_city").removeClass("hidden");
        $(".band_search_form_province").addClass("hidden");
        $(".band_search_form_region").addClass("hidden");
        break;
      case "province":
        $("#band_search_form_province").val("");
        $(".band_search_form_province").removeClass("hidden");
        $(".band_search_form_city").addClass("hidden");
        $(".band_search_form_region").addClass("hidden");
        break;
      case "region":
        $("#band_search_form_region").val("");
        $(".band_search_form_region").removeClass("hidden");
        $(".band_search_form_city").addClass("hidden");
        $(".band_search_form_province").addClass("hidden");
        break;
      default:

    }
  });
});
