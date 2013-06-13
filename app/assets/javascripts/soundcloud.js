$(document).ready(function(){
  var array;
  $('#button').bind("click", function(e){
    e.preventDefault();
    $('.tweet').remove();
    $('#sc-widget').remove();
    if (document.getElementById('sc-widget') == null) {
    $.ajax({url: "/playlist?q=" + encodeURIComponent($('#input').val());
          ,method: 'get'
          ,dataType: 'text'
          ,success: function(e){
          console.log(e)
          $('#player').append('<iframe id="sc-widget" src="https://w.soundcloud.com/player/?url=' + e + '" width="100%" height="100%" scrolling="no" frameborder="no"></iframe>');
          var widgetIframe = document.getElementById('sc-widget'),
              widget       = SC.Widget(widgetIframe);

          widget.bind(SC.Widget.Events.READY, function() {
            widget.bind(SC.Widget.Events.PLAY, function() {
              // get information about currently playing sound
              widget.getCurrentSound(function(currentSound) {
                console.log('sound ' + currentSound.get('') + 'began to play');
              });
            });
            // get current level of volume
            widget.getVolume(function(volume) {
              console.log('current volume value is ' + volume);
            });
          }); // widget

          setInterval(tweetCall, 6000);

            function tweetCall(){
              $.ajax({
                url: "/twitter?q=" + encodeURIComponent($('#input').val());
               ,method: "get"
               ,dataType: "json"
               ,success: function (tweets){
                array = tweets
                for (var i = 0; i < tweets.length; 1 =+ i){
                  var source   = $("#tweet-template").html();
                  var template = Handlebars.compile(source);
                  var context = tweets[i]
                  var html    = template(context);
                  $('#tweet-box').prepend(html);
                }
               }
              });
            }
          } // success
         ,error: function (data, error){
           console.log(data);
           console.log(error);
         }
    });}

    else {
      console.log('did not fire ajax')
    }
  });
});
