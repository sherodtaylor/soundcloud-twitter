$(document).ready(function(){
  $('#button').bind("click", function(e){
    e.preventDefault();
    $('iframe').remove();
    $('#player').empty();
    if ( document.getElementById("sc-widget") == null ){
      theCall();
    }
  });

  $('#input').bind('click', function(e){
    if (event.keyCode == 13) {
      return false;
      $('iframe').remove();
      $('#player').empty();
      if ( document.getElementById("sc-widget") == null ){
        theCall();
      }
    };
  });

  function theCall(){
      if (document.getElementById('sc-widget') == null) {

      setInterval(tweetCall, 10000);
      function tweetCall(){
      $.ajax({
        url: "/twitter?q=" + encodeURIComponent($('#input').val())
       ,method: "get"
       ,dataType: "json"
       ,success: function (tweets){
          for (var i = 0; i < tweets.length; 1 =+ i){
              var source = $("#tweet-template").html()
                 ,template = Handlebars.compile(source)
                 ,context = tweets[i]
                 ,html = template(context);

              $('#tweet-box').prepend(html);
            }
        }
      });
      };

      $.ajax({url: "/playlist?q=" + encodeURIComponent($('#input').val())
            ,method: 'get'
            ,dataType: 'text'
            ,success: function(e){
            console.log("I'm Appending Now")
            $('#player').append('<iframe id="sc-widget" src="https://w.soundcloud.com/player/?url=' + e + '" width="100%" height="100%" scrolling="no" frameborder="no"></iframe>');
            var widgetIframe = document.getElementById('sc-widget'),
                widget       = SC.Widget(widgetIframe);
              }
           ,error: function (data, error){
             console.log(data);
             console.log(error);
           }});
      }
      else {
        return false
        console.log('did not fire ajax')
      }
}});

