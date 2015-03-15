jQuery(document).ready( function ($) {

  $('#results').on('click', '.add-to-playlist', function(event){
    event.preventDefault();

    $playlistPopup = $(this).parents('.search-result-container').find('.playlists-popup');
    $playlistPopup.css('display','block');
    $playlistPopup.css("position", "absolute");
  });

  $(document).on('click', ".playlist-popup-item", function(){

    var $this = $(this);
    var playlistId = $this.data().playlistid;
    var videoTitle = $this.parent().prev('.result-icons').find('.add-to-playlist').data().title;
    var videoId = $this.closest('.search-result-container').find('.title-and-thumbnail').data().video_id;
    var duration = $this.parent().prev('.result-icons').find('.add-to-playlist').data().duration;

    $.ajax({
      type: "POST",
      url: "/tracks",
      data: {
        track: {
          playlists: playlistId,
          title: videoTitle,
          video_id: videoId,
          duration: duration
        }
      },
      success: function(data) {
        $this.css('background-color', "gray");
        $this.text('Added to playlist');
        $('.playlists-popup').fadeOut(1500);
      }
    })
  });
});
