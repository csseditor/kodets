$(document).on("ready page:change", function() {
  $('ul.track-show-items li').each(function(index) {
    $('.visible-tooltip-' + index).tooltip();
  })
});

$('.complete-lesson-info').tooltip();
