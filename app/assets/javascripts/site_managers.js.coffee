# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', '.image_selector', ->
  $('.image_selector').css("border-width":"0px")
  $('.image_selector').removeClass("selected")
  $(this).css("border-style":"solid", "border-color":"green", "border-width":"3px")
  $(this).addClass("selected")
  q = $('.selected img').attr("src")
  $('#site_manager_img').val(q)