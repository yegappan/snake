vim9script

if exists('g:loaded_snake')
  finish
endif
g:loaded_snake = 1

import autoload '../autoload/snake.vim' as Snake

command! SnakeGame call Snake.Start()
