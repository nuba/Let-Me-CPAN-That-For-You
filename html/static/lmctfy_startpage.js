$(document).ready(function(){
    var query_field = $('#query');
    var mode_field = $('#mode');
    var submit_button = $('#submit');
    var tiny_button = $('#tiny');
    var lmctfy_url = $('#lmctfy_url');
    var tiny_url = $('#tiny_url');

    lmctfy_url.css({opacity : 0});
    tiny_url.css({opacity : 0});

    query_field.keypress(function(event) {
      if (event.keyCode == '13') {
         event.preventDefault();
         submit_button.click();
       }
    });

    mode_field.keypress(function(event) {
      if (event.keyCode == '13') {
         event.preventDefault();
         submit_button.click();
       }
    });

    submit_button.click(function () {
      lmctfy_url.css({opacity : 0});
      lmctfy_url.text('http://lmctfy.org/' + query_field.val() + '/' + mode_field.val());
      lmctfy_url.fadeTo('fast', 1);
      tiny_button.removeAttr("disabled");
      tiny_url.css({opacity : 0});
    });

    tiny_button.click(function () {
      var req_URL = 'http://json-tinyurl.appspot.com/?url=' + encodeURIComponent(lmctfy_url.text()) + '&callback=?';
      $.getJSON(req_URL, function(data){
        tiny_url.text(data.tinyurl);
        tiny_url.fadeTo('fast', 1);
      });
    });
});
