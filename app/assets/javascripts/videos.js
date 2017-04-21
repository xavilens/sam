// $(document).on('ready page:load', function(){
//   // Intercambia entre la introducción manual de datos y la obtención de estos a través de la api
//   $('#api_data').click(function(){
//     if($(this).is(':checked')){
//       $('#video_title').prop('disabled', true);
//       $('#video_description').prop('disabled', true);
//     }else{
//       $('#video_title').prop('disabled', false);
//       $('#video_description').prop('disabled', false);
//     }
//   });
// });

$(document).ready(function(){
  // Intercambia entre la introducción manual de datos y la obtención de estos a través de la api
  $('#api_data').click(function(){
    if($(this).is(':checked')){
      $('#video_title').prop('disabled', true);
      $('#video_description').prop('disabled', true);
    }else{
      $('#video_title').prop('disabled', false);
      $('#video_description').prop('disabled', false);
    }
  });
});
