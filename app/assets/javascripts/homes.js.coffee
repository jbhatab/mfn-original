#Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  $('.dropdown-menu').hover \
    (-> $(this).parent('li').addClass('active')), \
    (-> $(this).parent('li').removeClass('active'))