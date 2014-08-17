$(function () {
  var jqconsole = $('#console').jqconsole('', '');
  var startPrompt = function () {
    // Start the prompt with history enabled.
    jqconsole.Prompt(true, function (input) {
      // Output input with the class jqconsole-output.
      jqconsole.Write(input + '\n', 'jqconsole-output');
      startPrompt();
    });
  };
  startPrompt();
});
