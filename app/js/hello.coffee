bind = rx.bind
rxt.importTags()
_.mixin(_.str.exports())

window.dictionary ?= {}

gedicht = rx.cell("gerrit is een baas")
last_word = bind -> _.last(gedicht.get().trim().split(" "))
word_end = bind -> last_word.get().replace(/^.*?([aoeui]+[^aoeui]*(?:|ie|ige|ig|el|ers|eren|ere|eerden|eerde|heid|es|ingen|ing|er|e|en))$/, "$1")
window.rhyme_words = rx.array([])

word_end.onSet.sub ([oldval, newval]) ->
  rhyme_words.replace(window.dictionary[newval] or [])

window.hello = ->
  $('body').append(
    div [
      textarea { rows: 10, keyup: _.debounce((-> gedicht.set(@val())), 50)},
        bind -> gedicht.get()
      div bind -> [
        "Rijmwoorden voor: "
        strong last_word.get()
        " met rijmuitgang: #{word_end.get()}"
      ]
      ul rhyme_words.map (rhyme_word) ->
        li rhyme_word
    ]
  )

if window.addEventListener
  window.addEventListener('DOMContentLoaded', hello, false)
else
  window.attachEvent('onload', hello)
