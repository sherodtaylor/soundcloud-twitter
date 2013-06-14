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
      var tweetIds = [];
      if (document.getElementById('sc-widget') == null) {
      setInterval(tweetCall, 10000);
      function tweetCall(){
        if ( tweetIds.length === 0 ){
          console.log("this is the regular")
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

                      tweetIds.push(tweets[i]['id']);

                  $('#tweet-box').prepend(html);
                }
            }
          });
        }
        else if ( tweetIds.length > 0 ) {
          console.log("i'm in here now")
          $.ajax({
            url: "/twitter?q=" + encodeURIComponent($('#input').val()) + "&last_id=" + _.last(tweetIds, 1 )
           ,method: "get"
           ,dataType: "json"
           ,success: function (tweets){
              for (var i = 0; i < tweets.length; 1 =+ i){
                  var source = $("#tweet-template").html()
                     ,template = Handlebars.compile(source)
                     ,context = tweets[i]
                     ,html = template(context);

                      tweetIds.push(tweets[i]['id']);

                  $('#tweet-box').prepend(html);
                }
            }
          });
        }
      };

      var loader;

      $.ajax({url: "/playlist?q=" + encodeURIComponent($('#input').val())
            ,method: 'get'
            ,dataType: 'text'
            ,beforeSend: function(){
              loader = new ajaxLoader($('html'), {classOveride: 'ajax_loader', bgColor: '#000', opacity: '0.3'});

            }
            ,complete: function (){
              loader.remove();
            }
            ,success: function(e){
            console.log("I'm Appending Now")
            $('#player').append('<iframe id="sc-widget" src="https://w.soundcloud.com/player/?url=' + e + '" width="100%" height="300" scrolling="no" frameborder="no"></iframe>');
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

