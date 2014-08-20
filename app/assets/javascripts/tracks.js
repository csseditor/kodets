$(document).on("ready page:change", function() {
    $('.visible-tooltip').each(function(index) {
      $('.visible-tooltip-' + index).tooltip();
    })
});