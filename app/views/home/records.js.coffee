$ ->
  $('form').on 'ajax:success', (event) ->
    $('.notice').html 'AJAX Success'
  $('form').on 'ajax:error', (event) ->
    $('.notice').html 'AJAX Failed'

  $ '#history'
    .html "<%= j render partial: 'history', locals: { appointments: @appointments } %>"
    .slideDown 500

