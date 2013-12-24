bind = rx.bind
rxt.importTags()
_.mixin(_.str.exports())


name = rx.cell("Unknown")

window.hello = ->
  $('body').append(
    div [
      input_val = input change: -> name.set(@val())
      div {class: 'hello'}, bind -> "Hello #{name.get()}"
    ]
  )

if window.addEventListener
  window.addEventListener('DOMContentLoaded', hello, false)
else
  window.attachEvent('onload', hello)
