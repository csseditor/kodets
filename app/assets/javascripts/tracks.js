$(document).on("ready page:change", function() {
  $('.visible-tooltip').each(function(index) {
    $('.visible-tooltip-' + index).tooltip();
  })
});

if ($('#edit-track-sortable').length) {
  $('#edit-track-sortable').sortable({
    handle: '.edit-track-move-icon',
    update: function(event, ui) {
      $("li.edit-track-sortable").each(function(n, obj) {
        obj.setAttribute("data-order", n);
      });
      $("ul#edit-track-sortable li").each(function (index, obj) {
        $("#order-" + obj.getAttribute("data-id")).val(obj.getAttribute("data-order"));
      });
    }
  });

  $('#edit-track-sortable').disableSelection();
};

$("li.edit-track-sortable").each(function(index, obj) {
  obj.setAttribute("data-order", index);
});

$("ul#edit-track-sortable li").each(function (index, obj) {
  $("#order-" + obj.getAttribute("data-id")).val(obj.getAttribute("data-order"));
});

$(".update-lesson-order-form").on("ajax:success", function(e, data, status, xhr) {
  $(".update-order-form-status").html("<div class=\"alert alert-success alert-dismissable\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>Order successfully changed.</div>");
  $("form.edit_track").submit();
}).bind("ajax:error", function(e, xhr, status, error) {
  $(".update-order-form-status").html("Error changing order");
  console.log(xhr.responseText);
});
