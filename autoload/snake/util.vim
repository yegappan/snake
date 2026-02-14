vim9script

import autoload './types.vim' as Types

export def DirToVec(d: Types.Direction): Types.Vec2
  if d == Types.Direction.Left
    return [-1, 0]
  elseif d == Types.Direction.Right
    return [1, 0]
  elseif d == Types.Direction.Up
    return [0, -1]
  endif
  return [0, 1]
enddef

export def IsOpposite(a: Types.Direction, b: Types.Direction): bool
  return (a == Types.Direction.Left && b == Types.Direction.Right)
    || (a == Types.Direction.Right && b == Types.Direction.Left)
    || (a == Types.Direction.Up && b == Types.Direction.Down)
    || (a == Types.Direction.Down && b == Types.Direction.Up)
enddef

export def CenterText(text: string, width: number): string
  if text == ''
    return repeat(' ', width)
  endif
  var text_width = strdisplaywidth(text)
  if text_width >= width
    return text
  endif
  var left = float2nr((width - text_width) / 2)
  return repeat(' ', left) .. text
enddef
