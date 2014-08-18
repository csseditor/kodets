$("input#disable_date").click(function() {
  alert('clicked');
  if (!this.checked) {
    $("#code_lesson_date_due").val("");
  }
  $("#code_lesson_date_due").attr("disabled", !this.checked);
});
