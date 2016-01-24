{$, $$, SelectListView} = require 'atom-space-pen-views'
{Emitter} = require 'atom'

module.exports =
class AlloyCommandPaletteView extends SelectListView
  panel: null
  emitter: null
  constructor: () ->
    super()
    @emitter = new Emitter()

  open: (items) ->
    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)

    @setItems(items)
    @panel.show()
    @focusFilterEditor()

  viewForItem: (item) ->
    "<li>#{item.label}</li>"

  getEmptyMessage: -> "There are no commands to execute."

  confirmed: (item) ->
    @emitter.emit("OnConfirmed", item)
    @panel.hide()

  onConfirmed: (callback) ->
    @emitter.on("OnConfirmed", callback)

  cancelled: ->
    @panel.hide()

  destroy: () ->
    @panel?.destroy()
    @emitter.dispose()