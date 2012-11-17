class TextSuggest
    _element: null
    _shadowEl: null
    _hiddenEl: null

    _shadowValue: null

    _options: null
    _defaultOptions: {width: 200, class: 'shadow-element'}

    constructor: (el, options = {}) ->
      @_element = el
      @_options = Object.merge(@_defaultOptions, options)
      @prepare()

    prepare: ->
      self = this

      # Create elements
      @_shadowEl = new Element('span', {
        'class': @_options.class,
        'style': 'position: absolute; left: 0; width: ' + escape(@_options.width) + 'px; display: none;'
      })
      @_hiddenEl = new Element('div', {
        'class': 'shadow-hidden'
      })

      # Copy style which can changes the text width
      @_hiddenEl
        .setStyles(@_element.getStyles("line-height", "font-size", "font-family", "letter-spacing", "font-weight", "height", "padding-left"))
        .setStyle('display', 'none')

      # Add elements to the DOM
      @_element.getParent().grab(@_shadowEl)
      $$('body').grab(@_hiddenEl)

      # Events listener
      @_element.addEvents 
        'change': (e) ->
          self._preUpdate(e)
        'keydown': (e) ->
          self._preUpdate(e)
        'keyup': (e) ->
          self._preUpdate(e)
        'blur': ->
          self._shadowEl.setStyle('display', 'none')

    _preUpdate: (e) ->
      # Left arrow
      return @expend() if e and e.code == 39 and @_element.getCaretPosition() == @_element.get('value').length
      
      self = this
      setTimeout (->
        self._update()
      ), 0

    # Update shadowElement
    _update: () ->
      value = @_shadowValue
      userInput = @_element.get('value')

      reg = "/^" + value + "/gi"
      if userInput.length < 1 || !reg.match(userInput)
        @_shadowEl.setStyle('display', 'none')
        return

      # Update shadow value
      @_shadowEl
        .set('html', @_shadowValue.substr(userInput.length))
        .setStyle('display', 'block')

      # Update shadow position
      @_hiddenEl
        .set('html', userInput)
        .setStyle('display', 'inline-block')

      dimensions = @_hiddenEl.getDimensions()
      @_hiddenEl.setStyles({
          'display' : 'none',
      })
      @_shadowEl.setStyles({
          'left'    : dimensions.width,
          'width'   : @_options.width - dimensions.width
      })

    # Update value of the shadowElement to display
    suggest: (value)->
      @_shadowValue = value
      @_shadowEl.set('html', @_shadowValue)
      @_update()
      @

    clear: ->
      @_element.set('value', '') 
      @_shadowEl.set('html', '')
      @
    
    expend: ->
      @_element.set('value', @_shadowValue) 
      @_shadowEl.set('html', '')
      @

namespace "JM", (exports) ->
  exports.TextSuggest = TextSuggest
