var jqconsole = $('#console').jqconsole('', '');

var startPrompt = function () {
  jqconsole.Prompt(true, function (input) {
    jqconsole.Write(input + '\n', 'jqconsole-output');
    // Scrolls to bottom when content goes of page
    $(".jqconsole").animate({
      scrollTop: $(".jqconsole").height()
    }, 1000);
    startPrompt();
  });
};
startPrompt();

$('#default-run-code-buttom').on('click', function() {
  var $that = $(this);

  var ajax_data = {
    user_id: $that.attr('data-user-id'),
    lesson_id: $that.attr('data-lesson-id'),
    item_type: $that.attr('data-item-type'),
    track_id: $that.attr('data-track-id'),
    organisation_id: $that.attr('data-organisation-id'),
    user_code: editor.getValue()
  }

  // Make AJAX call to evaluation code
  $.ajax({
    type: "POST",
    url: $that.attr('data-submit-url'),
    data: ajax_data
  }).done(function(data) {
    // When AJAX is a success

    var result = JSON.parse(data);

    if ($('#console').length > 0) {
      jqconsole.Write(result.stdout, 'jqconsole-output');

      if (result.stderr) {
        jqconsole.Write(result.stderr);
      }

      if (result.pass == "true\n" && result.stderr == "") {
        jqconsole.Write("Well done, you passed the lessson!\n", 'jqconsole-success');
        $('#success_bar').slideDown(500);
      } else {
        jqconsole.Write("Oops, thats not correct.\n", 'jqconsole-error');
      }
    } else {
      console.log(result.stdout);
    }
  }).fail(function(xhr, error, status) {
    if ($('#console').length > 0) {
      jqconsole.Write("Error 500: Internal Server Error", "jqconsole-error");
    }
  });
});

$('#javascript-run-code-buttom').on('click', function(e) {
  e.preventDefault();

  evaluateJavascript(editor.getSession().getValue());
});

function evaluateJavascript(code) {
  var console = {
    log: function (item) {
      jqconsole.Write(item + '\n', 'jqconsole-output');
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
