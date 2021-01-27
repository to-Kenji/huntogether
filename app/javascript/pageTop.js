document.addEventListener("turbolinks:load", function() {
  jQuery(function() {
    var pagetop = $('#page-top');
    pagetop.hide();
    $(window).on('scroll', function () {
      if ($(this).scrollTop() > 100) {
        pagetop.fadeIn();
      } else {
        pagetop.fadeOut();
      }
    });
    pagetop.on('click', function () {
      $('body, html').animate({
        scrollTop: 0
      }, 500);
      return false;
    }); 
  });
});