$(document).on("ready page:change", function() {
  $('.visible-tooltip').each(function(index) {
    $('.visible-tooltip-' + index).tooltip();
  })
});

$(".update-lesson-order-form").on("ajax:success", function(e, data, status, xhr) {
  $(".update-order-form-status").html("<div class=\"alert alert-success alert-dismissable\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>Order successfully changed.</div>");
  $("form.edit_track").submit();
}).bind("ajax:error", function(e, xhr, status, error) {
  $(".update-order-form-status").html("Error changing order");
  console.log(xhr.responseText);
});
