bind = rx.bind
rxt.importTags()
_.mixin(_.str.exports())

window.dictionary ?= {}


class Line
  constructor: (line, @linenumber) ->
    @line = line.trim()

  lastWord: ->
    _.last(@line.split(" "))

  rhymeEnd: ->
    @lastWord().replace(/^.*?([aoeui]+[^aoeui]*(?:|ie|ige|ig|el|ers|eren|ere|eerden|eerde|heid|es|ingen|ing|er|e|en))$/, "$1")


gedicht     = rx.cell("gerrit is een baas\neen baas is een paashaas")
lines       = rx.array([])
rhyme_words = rx.array([])
currentLine = rx.cell()

gedicht.onSet.sub ([oldval, newval]) ->
  i = 1
  lines.replace _.map newval.trim().split("\n"),
      (line) -> new Line(line, i++)

word_end    = bind -> lines.at(currentLine.get()-1)?.rhymeEnd()
word_end.onSet.sub ([oldval, newval]) ->
  rhyme_words.replace(window.dictionary[newval] or [])


updateGedicht = ->
  gedicht.set(@val())
  currentLine.set(@val().substr(0, @prop("selectionStart")).split("\n").length)

$ ->
  $('body').append(
    div [
      textarea { rows: 10, keyup: _.debounce(updateGedicht, 50)},
        bind -> gedicht.get()
      table lines.map (line) ->
        tr {class: bind -> if line.linenumber == currentLine.get() then "current" else ""}, [
          td line.line
          td line.lastWord()
          td line.rhymeEnd()
        ]
      div bind -> [
        "Rijmwoorden voor: "
        " met rijmuitgang: #{word_end.get()}"
      ]
      ul rhyme_words.map (rhyme_word) ->
        li rhyme_word
    ]
  )
