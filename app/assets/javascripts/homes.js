// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(function() {

//navbar active 
  $('li.dropdown').click(function(){
    $('li.dropdown').removeClass('active');
    $(this).addClass('active');
  });     

//Carousel buttons instead of arrows
  function() {
    $('.carousel[id]').each(
      function() {
        var html = '<div class="carousel-nav" data-target="' + $(this).attr('id') + '"><ul>';
        
        for(var i = 0; i < $(this).find('.item').size(); i ++) {
          html += '<li><a';
          if(i == 0) {
            html += ' class="active"';
          }
          
          html += ' href="#">•</a></li>';
        }
        
        html += '</ul></li>';
        $(this).before(html);
        $('.carousel-control.left[href="#' + $(this).attr('id') + '"]').hide();
      }
    ).bind('slid',
      function(e) {
        var nav = $('.carousel-nav[data-target="' + $(this).attr('id') + '"] ul');
        var index = $(this).find('.item.active').index();
        var item = nav.find('li').get(index);
        
        nav.find('li a.active').removeClass('active');
        $(item).find('a').addClass('active');
        
        if(index == 0) {
          $('.carousel-control.left[href="#' + $(this).attr('id') + '"]').fadeOut();
        } else {
          $('.carousel-control.left[href="#' + $(this).attr('id') + '"]').fadeIn();
        }
        
        if(index == nav.find('li').size() - 1) {
          $('.carousel-control.right[href="#' + $(this).attr('id') + '"]').fadeOut();
        } else {
          $('.carousel-control.right[href="#' + $(this).attr('id') + '"]').fadeIn();
        }
      }
    );
    
    $('.carousel-nav a').bind('click',
      function(e) {
        var index = $(this).parent().index();
        var carousel = $('#' + $(this).closest('.carousel-nav').attr('data-target'));
        
        carousel.carousel(index);
        e.preventDefault();
      }
    );
  }

});

