vim9script

import autoload './types.vim' as Types

export class PopupRenderer implements Types.IRenderer
  var popup_id: number
  var width: number
  var height: number

  def new(width: number, height: number)
    this.width = width
    this.height = height
    this.popup_id = 0
  enddef

  def Open()
    if this.popup_id != 0
      popup_close(this.popup_id)
    endif

    var maxw = this.width + 2
    var maxh = this.height + 4
    this.popup_id = popup_create([''], {
      pos: 'center',
      minwidth: maxw,
      minheight: maxh,
      maxwidth: maxw,
      maxheight: maxh,
      border: [],
      padding: [0, 1, 0, 1],
      highlight: 'Normal',
      borderhighlight: ['Title'],
      filter: function('snake#PopupFilter'),
    })
  enddef

  def Close()
    if this.popup_id != 0
      popup_close(this.popup_id)
      this.popup_id = 0
    endif
  enddef

  def SetText(lines: list<string>)
    if this.popup_id != 0
      popup_settext(this.popup_id, lines)
    endif
  enddef

  def IsOpen(): bool
    return this.popup_id != 0
  enddef
endclass
