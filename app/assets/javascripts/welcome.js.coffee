# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.search').focus()
  $('.edit').hide()

  this.request_google = () ->
    query = 'http://google.com/#q='
    query += $('.search').val()
    window.open(query)

  this.enableEdit = () ->
    $('.edit').toggle()
