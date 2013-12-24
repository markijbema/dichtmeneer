bind = rx.bind
rxt.importTags()
_.mixin(_.str.exports())


gedicht = rx.cell("gerrit is een baas")
last_word = bind -> _.last(gedicht.get().trim().split(" "))
rhyme_words = rx.array(['haas', 'gaas', 'sinterklaas'])

window.hello = ->
  $('body').append(
    div [
      textarea { keyup: -> gedicht.set(@val())},
        bind -> gedicht.get()
      div bind -> "Rijmwoorden voor: #{last_word.get()}"
      ul rhyme_words.map (rhyme_word) ->
        li rhyme_word
    ]
  )

if window.addEventListener
  window.addEventListener('DOMContentLoaded', hello, false)
else
  window.attachEvent('onload', hello)
