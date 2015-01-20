$('.label.label-hidden').tooltip();

$(document).ready(function() {
  $("input:checkbox").change(function() {
    if (!this.checked) {
      $("#code_lesson_date_due").val('');
    }
    $("#code_lesson_date_due").attr("disabled", !this.checked);
  });
});
