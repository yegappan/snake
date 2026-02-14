vim9script

import autoload './types.vim' as Types
import autoload './board.vim' as BoardMod
import autoload './snake_model.vim' as SnakeMod
import autoload './renderer.vim' as RendererMod
import autoload './util.vim' as Util

export class SnakeGame
  var board: BoardMod.Board
  var snake: SnakeMod.Snake
  var renderer: Types.IRenderer
  var dir: Types.Direction
  var next_dir: Types.Direction
  var food_pos: Types.Pos
  var food_num: number
  var score: number
  var state: Types.GameState
  var timer_id: number
  var tick_ms: number

  def new(width: number, height: number, tick_ms: number)
    this.board = BoardMod.Board.new(width, height)
    this.snake = SnakeMod.Snake.new()
    this.renderer = RendererMod.PopupRenderer.new(width, height)
    this.dir = Types.Direction.Right
    this.next_dir = Types.Direction.Right
    this.food_pos = [0, 0]
    this.food_num = 0
    this.score = 0
    this.state = Types.GameState.Ready
    this.timer_id = -1
    this.tick_ms = tick_ms
  enddef

  def Start()
    if this.state == Types.GameState.Running
      return
    endif

    this.state = Types.GameState.Running
    this.score = 0
    this.food_num = 0
    srand()

    var startx = float2nr(this.board.width / 2)
    var starty = float2nr(this.board.height / 2)
    this.snake.Reset([startx, starty])

    this.dir = Types.Direction.Right
    this.next_dir = Types.Direction.Right

    this.SpawnFood()
    this.renderer.Open()
    this.Render('')

    if this.timer_id != -1
      timer_stop(this.timer_id)
    endif
    this.timer_id = timer_start(this.tick_ms, function('snake#Tick'), {repeat: -1})
  enddef

  def Stop(reason: string)
    if this.state != Types.GameState.Running
      return
    endif

    this.state = Types.GameState.Over
    if this.timer_id != -1
      timer_stop(this.timer_id)
      this.timer_id = -1
    endif

    this.Render(reason)
  enddef

  def Close()
    if this.timer_id != -1
      timer_stop(this.timer_id)
      this.timer_id = -1
    endif
    this.state = Types.GameState.Ready
    this.renderer.Close()
  enddef

  def OnTick()
    if this.state != Types.GameState.Running
      return
    endif

    this.dir = this.next_dir
    var head = this.snake.Head()
    var vec = Util.DirToVec(this.dir)
    var new_head: Types.Pos = [head[0] + vec[0], head[1] + vec[1]]

    if !this.board.InBounds(new_head)
      this.Stop('Wall collision')
      return
    endif

    if this.snake.Hits(new_head)
      this.Stop('Self collision')
      return
    endif

    var ate = (new_head[0] == this.food_pos[0] && new_head[1] == this.food_pos[1])
    this.snake.Move(new_head, ate)

    if ate
      this.score += this.food_num
      if this.food_num == 9
        this.Stop('All numbers eaten')
        return
      endif
      this.SpawnFood()
    endif

    this.Render('')
  enddef

  def SpawnFood()
    this.food_num = (this.food_num % 9) + 1

    var tries = 0
    while tries < 200
      var x = rand() % this.board.width
      var y = rand() % this.board.height
      var pos: Types.Pos = [x, y]
      if !this.snake.Hits(pos)
        this.food_pos = pos
        return
      endif
      tries += 1
    endwhile

    this.Stop('Board full')
  enddef

  def SetDir(new_dir: Types.Direction)
    if Util.IsOpposite(this.dir, new_dir)
      return
    endif
    this.next_dir = new_dir
  enddef

  def OnKey(key: string): bool
    if this.state != Types.GameState.Running
      if this.state == Types.GameState.Over && key ==# 'r'
        this.Start()
        return true
      endif
      if key ==# 'q'
        this.Close()
        return true
      endif
      return true
    endif

    if key ==# 'h' || key ==# "\<Left>"
      this.SetDir(Types.Direction.Left)
      return true
    elseif key ==# 'l' || key ==# "\<Right>"
      this.SetDir(Types.Direction.Right)
      return true
    elseif key ==# 'k' || key ==# "\<Up>"
      this.SetDir(Types.Direction.Up)
      return true
    elseif key ==# 'j' || key ==# "\<Down>"
      this.SetDir(Types.Direction.Down)
      return true
    elseif key ==# 'q'
      this.Stop('Quit')
      this.Close()
      return true
    endif

    return false
  enddef

  def Render(reason: string)
    var lines: list<string> = []

    if this.state == Types.GameState.Over
      var total_lines = this.board.height + 4
      var blank = repeat(' ', this.board.width)
      var game_row = float2nr(total_lines / 2) - 1
      var reason_row = game_row + 1

      for i in range(0, total_lines - 1)
        if i == game_row
          lines->add(Util.CenterText('Game Over', this.board.width))
        elseif i == reason_row
          lines->add(Util.CenterText(reason, this.board.width))
        else
          lines->add(blank)
        endif
      endfor

      this.renderer.SetText(lines)
      return
    endif

    var top = '┌' .. repeat('─', this.board.width) .. '┐'
    var bottom = '└' .. repeat('─', this.board.width) .. '┘'

    lines->add(' Snake  Score: ' .. this.score)
    lines->add(top)

    for y in range(0, this.board.height - 1)
      var row_chars = repeat([' '], this.board.width)

      if y == this.food_pos[1] && this.food_pos[0] >= 0 && this.food_pos[0] < this.board.width
        row_chars[this.food_pos[0]] = string(this.food_num)
      endif

      for i in range(0, len(this.snake.Body()) - 1)
        var part = this.snake.Body()[i]
        if part[1] != y
          continue
        endif
        if part[0] < 0 || part[0] >= this.board.width
          continue
        endif
        var ch = (i == 0 ? '▣' : '■')
        row_chars[part[0]] = ch
      endfor

      lines->add('│' .. join(row_chars, '') .. '│')
    endfor

    lines->add(bottom)
    var hint = ' Controls: h/j/k/l or arrows. q to quit/close'
    lines->add(hint)

    this.renderer.SetText(lines)
  enddef
endclass
