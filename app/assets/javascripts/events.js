$(document).ready(function(){
  $("input[name='event_search_form[location_type]']").change(function(){
    location_type = $(this).val();

    switch (location_type) {
      case "city":
        $("#event_search_form_city").val("");
        $(".event_search_form_city").removeClass("hidden");
        $(".event_search_form_province").addClass("hidden");
        $(".event_search_form_region").addClass("hidden");
        break;
      case "province":
        $("#event_search_form_province").val("");
        $(".event_search_form_province").removeClass("hidden");
        $(".event_search_form_city").addClass("hidden");
        $(".event_search_form_region").addClass("hidden");
        break;
      case "region":
        $("#event_search_form_region").val("");
        $(".event_search_form_region").removeClass("hidden");
        $(".event_search_form_city").addClass("hidden");
        $(".event_search_form_province").addClass("hidden");
        break;
      default:

    }
  });
});
