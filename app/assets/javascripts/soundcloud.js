$(document).ready(function(){
  $('#button').bind("click", function(e){
    e.preventDefault();
    var encoded = encodeURIComponent($('#input').val());
    $.ajax({url: "/playlist?q=" + encoded
          ,method: 'get'
          ,dataType: 'text'
          ,success: function(e){
          console.log(e)
          $('#player').append('<iframe id="sc-widget" src="https://w.soundcloud.com/player/?url=' + e + '" width="100%" height="465" scrolling="no" frameborder="no"></iframe>');
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
          } // success
         ,error: function (data, error){
           console.log(data);
           console.log(error);
         }
    });
  });
});
