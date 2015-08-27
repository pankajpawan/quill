Parchment = require('parchment')
StyleAttributor = require('./attributor')


class Bold extends Parchment.Inline
  @blotName: 'bold'
  @tagName: 'STRONG'

class Italic extends Parchment.Inline
  @blotName: 'italic'
  @tagName: 'EM'

class Strike extends Parchment.Inline
  @blotName: 'strike'
  @tagName: 'S'

class Underline extends Parchment.Inline
  @blotName: 'underline'
  @tagName: 'U'

class Link extends Parchment.Inline
  @blotName: 'link'
  @tagName: 'A'

  constructor: (value) ->
    super(value)
    @domNode.href = value

  getFormat: ->
    format = super()
    format.link = this.domNode.href
    return format

class InlineCode extends Parchment.Inline
  @blotName: 'inline-code'
  @tagName: 'CODE'


# TODO: implement exclusitivity

class Script extends Parchment.Inline
  @blotName: 'script'
  @tagName: ['SUB', 'SUP']

  constructor: (value) ->
    if (typeof value == 'string')
      value = document.createElement(value)
    super(value)

  getFormat: ->
    formats = super
    formats['script'] = @domNode.tagName.toLowerCase()
    return formats


class InlineAttributor extends StyleAttributor
  add: (node, value) ->
    blot = Parchment.findBlot(node)
    return unless blot? and blot instanceof Parchment.Inline
    super(node, value)


Background = new InlineAttributor('background', 'backgroundColor')
Color = new InlineAttributor('color', 'color')
Font = new InlineAttributor('font', 'fontFamily')
Size = new InlineAttributor('size', 'fontSize')


module.exports =
  Bold        : Parchment.define(Bold)
  Italic      : Parchment.define(Italic)
  Strike      : Parchment.define(Strike)
  Underline   : Parchment.define(Underline)

  Link        : Parchment.define(Link)
  InlineCode  : Parchment.define(InlineCode)
  Script      : Parchment.define(Script)

  Background  : Parchment.define(Background)
  Color       : Parchment.define(Color)
  Font        : Parchment.define(Font)
  Size        : Parchment.define(Size)
