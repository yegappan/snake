vim9script
# Snake Game Plugin for Vim9
# Classic arcade game - guide a growing snake to eat numbered prey
# Requires: Vim 9.0+

if exists('g:loaded_snake')
  finish
endif
g:loaded_snake = 1

import autoload '../autoload/snake.vim' as Snake

# Command to start the game
command! SnakeGame call Snake.Start()
