// Runs code that user submits to pass a lesson
$('#default-run-code-buttom').on('click', function() {
  var $that = $(this);

  var ajax_data = {
    user_id: $that.attr('data-user-id'),
    lesson_id: $that.attr('data-lesson-id'),
    lesson_type: $that.attr('data-item-type'),
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
    var result = JSON.parse(data);

    console.log(result);

    if ($('#console').length > 0) {
      jqconsole.Write(result.stdout, 'jqconsole-output');

      if (result.stderr) {
        jqconsole.Write(result.stderr);
      }

      if (result.pass && result.stderr == "") {
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

// Runs user code at teachers request, does not create progress
$('#default-run-code-sandbox-buttom').on('click', function() {
  var $that = $(this);

  var ajax_data = {
    user_code: editor.getValue(),
    lesson_id: $that.attr('data-lesson-id')
  }

  // Make AJAX call to evaluation code
  $.ajax({
    type: "POST",
    url: $that.attr('data-submit-url'),
    data: ajax_data
  }).done(function(data) {
    var result = JSON.parse(data);

    console.log(result);

    if ($('#console').length > 0) {
      jqconsole.Write(result.stdout, 'jqconsole-output');

      if (result.stderr) {
        jqconsole.Write(result.stderr);
      }

      if (result.pass && result.stderr == "") {
        jqconsole.Write("This code passes the test.\n", 'jqconsole-success');
      } else {
        jqconsole.Write("This code does not pass the test.\n", 'jqconsole-error');
      }
    } else {
      console.log(result.stdout);
    }
  }).fail(function(xhr, error, status) {
    if ($('#console').length > 0) {
      jqconsole.Write("Error 500: Internal Server Error", "jqconsole-error");
      console.log(xhr.responseText);
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
