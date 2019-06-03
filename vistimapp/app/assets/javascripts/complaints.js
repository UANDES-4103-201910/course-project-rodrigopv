   $('.comment_username').click(function(e) {
       console.log("clicked");
       $('#comment_content').val( $('#comment_content').val() + $(this)[0].innerText + " " );
       $('#comment_content').focus();
       console.log($(this));
       e.stopPropagation();
   });
