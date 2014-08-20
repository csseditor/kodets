if ($('#edit-track-sortable').length) {
  $('#edit-track-sortable').sortable({
    handle: '.edit-track-move-icon',
    update: function(event, ui) {
      // Upon re-order, update the 'data-order' fields of each li to contain its order...
      $("li.edit-track-sortable").each(function(n, obj) {
        obj.setAttribute("data-order", n);
      });
      // ... then get the value of each li and add it to the form field so it
      // can be updated when form is submitted.
      $("ul#edit-track-sortable li").each(function (index, obj) {
        $("#order-" + obj.getAttribute("data-id")).val(obj.getAttribute("data-order"));
      });
    }
  });

  // Disable highlight of list
  $('#edit-track-sortable').disableSelection();
};

// On load ser order for the first time
$("li.edit-track-sortable").each(function(index, obj) {
  obj.setAttribute("data-order", index);
});

// On load set values for inputs for the first time.
$("ul#edit-track-sortable li").each(function (index, obj) {
  $("#order-" + obj.getAttribute("data-id")).val(obj.getAttribute("data-order"));
});
