vim9script

import autoload './snake/game.vim' as GameMod

var game: GameMod.SnakeGame = null_object

export def Start()
  if game == null_object
    game = GameMod.SnakeGame.new(30, 15, 120)
  endif
  game.Start()
enddef

export def PopupFilter(_id: number, key: string): bool
  if game == null_object
    return true
  endif
  return game.OnKey(key)
enddef

export def Tick(_id: number)
  if game != null_object
    game.OnTick()
  endif
enddef
