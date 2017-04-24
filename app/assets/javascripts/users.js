// USERS
//// USER_SEARCH_FORM
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
});
