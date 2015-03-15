jQuery(document).ready( function ($) {

  $(document).on('click', ".star-icon", function() {
      var $this = $(this)
      var starredPlaylist = $(document).find('#starred-playlists-bar').data().starredplaylist;
      var videoTitle = $this.closest("article").find('.queue-item-title').text()
      var videoId = $this.closest("article.queue-item").data().id;
      var duration = $this.closest("article.queue-item").data().duration;
      if($(this).attr("src") == "/images/star.png"){
        $.ajax({
        type: "POST",
        url: "/tracks",
        data: {
        track: {
            playlists: starredPlaylist,
            title: videoTitle,
            video_id: videoId,
            duration: duration
          }
        },
        success: function(data) {
          $this.attr("src", "/images/star-filled.png");
          $this.data('id', data.id);
          $this.attr('data-id', data.id)
          localStorage.setItem('queue-list', $('#queue').html());
        },
        error: function(data) {
        }
      });
    }
      else {
          $.ajax({
          type: "DELETE",
          url: "/tracks/"+ $this.data('id'),
          data: {},
          success: function(data) {
            $this.attr("src", "/images/star.png");
            $this.removeAttr('data-id')
            localStorage.setItem('queue-list', $('#queue').html());

          },
          error: function(data) {
          }
        });
      }
  });
});
