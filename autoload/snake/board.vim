vim9script

import autoload './types.vim' as Types

export class Board
  var width: number
  var height: number

  def new(width: number, height: number)
    this.width = width
    this.height = height
  enddef

  def InBounds(pos: Types.Pos): bool
    return pos[0] >= 0 && pos[0] < this.width && pos[1] >= 0 && pos[1] < this.height
  enddef
endclass
