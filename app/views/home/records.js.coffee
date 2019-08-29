$ ->
  $ '#notice'
    .on 'ajax:success', (event) -> @.html 'AJAX Successful'
  $ '#notice'
    .on 'ajax:error', (event) -> @.html 'AJAX Failed'

  $ '.new_content'
    .html "<%= j render partial: 'facilities' %>"
  $ '.new_content'
    .slideDown('slow')
