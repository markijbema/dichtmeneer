bind = rx.bind
rxt.importTags()
_.mixin(_.str.exports())


window.helloText = -> 'Hello, World!'

window.hello = ->
  $('body').append(
    div {class: 'hello'}, helloText()
  )

if window.addEventListener
  window.addEventListener('DOMContentLoaded', hello, false)
else
  window.attachEvent('onload', hello)
