vim9script

import autoload './types.vim' as Types

export class Snake
  var body: list<Types.Pos>

  def new()
    this.body = []
  enddef

  def Reset(start: Types.Pos)
    this.body = []
    this.body->add(start)
    this.body->add([start[0] - 1, start[1]])
    this.body->add([start[0] - 2, start[1]])
  enddef

  def Head(): Types.Pos
    return this.body[0]
  enddef

  def Body(): list<Types.Pos>
    return this.body
  enddef

  def Hits(pos: Types.Pos): bool
    for part in this.body
      if part[0] == pos[0] && part[1] == pos[1]
        return true
      endif
    endfor
    return false
  enddef

  def Move(new_head: Types.Pos, grow: bool)
    this.body->insert(new_head, 0)
    if !grow
      this.body->remove(-1)
    endif
  enddef
endclass
