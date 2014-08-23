$(function() {
  var jqconsole = $('#console').jqconsole('', '');
  var startPrompt = function () {
    // Start the prompt with history enabled.
    jqconsole.Prompt(true, function (input) {

      // Output input with the class jqconsole-output.
      jqconsole.Write(input + '\n', 'jqconsole-output');

      // Scrolls to bottom when content goes of page
      $(".jqconsole").animate({
        scrollTop: $(".jqconsole").height()
      }, 1000);

      startPrompt();
    });
  };
  startPrompt();
});

$('a#javascript-run-code').on('click', function(e) {
  e.preventDefault();
  evaluateJavascript(editor.getSession().getValue());
});

function evaluateJavascript(code) {
  var console = {
    log: function (item) {
      jqconsole.Write(item + '\n');
    },
    warn: function (item) {
      jqconsole.Write(item + '\n', 'jqconsole-warning');
    },
    info: function (item) {
      jqconsole.Write(item + '\n', 'jqconsole-info');
    },
    error: function (item) {
      jqconsole.Write(item + '\n', 'jqconsole-error');
    }
  };

  eval(code);
}
