$(document).ready ->
  $('#wallet_val').hide()
  #$('#wallet_amount_custom').prop("checked", true) ->
  #  $('#wallet_val').slideToggle(200)
  #return
  $('#wallet_amount_custom').change ->
    $('#wallet_val').toggle(this.checked)
  return
return

