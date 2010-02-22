var cursor;
var query_field;
var mode_field;
var submit_button;

function start() {
  cursor.animate({
    left: query_field.position().left + 20, 
    top:  query_field.position().top + query_field.height() - 2 , 
    }, 2000, "easeInOutQuart", 
      function() { 
        query_field.focus();
        type(query_field, query, 0)
      });
}

function mode_step() {
  cursor.animate({
    left: mode_field.position().left + mode_field.width() - 2, 
    top:  mode_field.position().top + mode_field.height() - 7 , 
    }, 1500, "easeInOutQuart", 
      function() { 
        mode_field.focus();
        setTimeout(function() {
          mode_field.val(mode);
          submit_step();
        }, 300);
      });
}


function submit_step() {
  cursor.animate({
    left: submit_button.position().left + submit_button.width() - 5, 
    top:  submit_button.position().top + submit_button.height() - 5 , 
    }, 1500, "easeOutBack", 
      function() { 
        submit_button.focus();
        setTimeout(submit_button.click(), 200);
      });
}


function type(field, string, index) {
  if (index < string.length) {
    field.val(string.substr(0, index + 1));
    setTimeout(function(){ type(field, string, index + 1); }, Math.random() * 200 + 50)
  } else {
    if(mode == 'all') {
      submit_step();
    } else {
      mode_step();
    }
  }
}

$(document).ready(function(){
  cursor = $('#cursor');
  query_field = $('#query');
  mode_field = $('#mode');
  submit_button = $('#submit');

  start();

});
