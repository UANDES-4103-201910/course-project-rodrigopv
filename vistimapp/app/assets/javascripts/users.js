$.fn.editable.defaults.mode = 'popup';
$.fn.editable.defaults.ajaxOptions = {type: "PUT"};

   $('.comment_username').click(function(e) {
       console.log("clicked");
       $('#comment_content').val( $('#comment_content').val() + $(this).innerHTML );
       console.log($(this).innerHTML);
       e.stopPropagation();
   });


$(document).ready(function() {
   console.log("users.js: document.ready");
   var loggedUserId = $('body').data('logged-user-id');
   var profileId = $('body').data('profile-id');


   if(loggedUserId == profileId) {
      $('#suggestUpload').show();
      $('.bio').editable();
      $('#bio-img').click(function() {
         $("#fileupload").click();
      });
      $('#fileupload').fileupload({
        dataType: 'json',
        method: 'PUT',
        formData: {pk: loggedUserId },
        beforeSend: function ( xhr ) {
           console.log("starting file upload..");
            $('#bio-img').attr('src', '');
            $('#bio-img').attr('data-src', "holder.js/250x250?text=Uploading\nImage..&theme=sky");
            Holder.run({domain: "holder.js", images: "#bio-img"});
        },
         done: function (e, data) {
            $('#bio-img').attr('src', data.result.avatar_url);
         }
       });
       console.log("hooked editable fields");



   }




});
