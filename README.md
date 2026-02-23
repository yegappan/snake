# Snake Game in Vim9script

A classic Snake game playable within Vim. Guide the snake to eat food in numerical order (1-9) while avoiding walls and yourself. Written in Vim9script to showcase modern language features.

## Features

- **Continuous Movement**: Snake moves automatically in the current direction
- **Sequential Feeding**: Eat numbers 1-9 in order to complete the level
- **Growing Snake**: Each food eaten increases snake length
- **Popup Window UI**: Game displays in a centered, bordered window
- **Scoring System**: Track your progress and high score
- **Modern Vim9script**: Demonstrates game loop, state management, and collision detection

## Requirements

- Vim 9.0 or later with Vim9script support
- **NOT compatible with Neovim** (requires Vim9-specific features)

## Installation

### Using Git

**Unix/Linux/macOS:**
```bash
git clone https://github.com/yegappan/snake.git ~/.vim/pack/downloads/opt/snake
```

**Windows (cmd.exe):**
```cmd
git clone https://github.com/yegappan/snake.git %USERPROFILE%\vimfiles\pack\downloads\opt\snake
```

### Using a ZIP file

**Unix/Linux/macOS:**
```bash
mkdir -p ~/.vim/pack/downloads/opt/
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually snake-main) to `snake` so the final path matches:

```plaintext
~/.vim/pack/downloads/opt/snake/
├── plugin/
├── autoload/
└── doc/
```

**Windows (cmd.exe):**
```cmd
if not exist "%USERPROFILE%\vimfiles\pack\downloads\opt" mkdir "%USERPROFILE%\vimfiles\pack\downloads\opt"
```
Download the ZIP file from GitHub and extract it into the directory above. Rename the extracted folder (usually snake-main) to `snake` so the final path matches:

```plaintext
%USERPROFILE%\vimfiles\pack\downloads\opt\snake\
├── plugin/
├── autoload/
└── doc/
```

### Finalizing Setup

Since the plugin is in the `opt` directory, add this to your `.vimrc` (Unix) or `_vimrc` (Windows):
```viml
packadd snake
```

Then restart Vim and run:
```viml
:helptags ALL
```

### Plugin Manager Installation

If using vim-plug, add to your config:
```viml
Plug 'path/to/snake'
```
Then run `:PlugInstall` and `:helptags ALL`.

For other plugin managers, follow their standard procedure for local plugins.

## Usage

### Starting the Game

```vim
:SnakeGame
```

### Controls

| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `←` / `→` / `↑` / `↓` | Move in matching direction |
| `q` | Quit game |
| `r` | Restart after game over |

### Game Rules

- **Objective**: Eat food numbered 1-9 in sequential order to win
- **Movement**: Snake moves continuously in the current direction
- **Eating**: Move the snake's head to the food to eat it
- **Growth**: Snake grows by one segment each time it eats
- **Collision - Walls**: Hitting the border ends the game
- **Collision - Self**: Hitting your own body ends the game
- **Win Condition**: Successfully eat all 9 food items in order

### Strategy Tips

- Plan ahead to avoid cornering yourself
- Use the edges strategically to manage your snake's length
- Remember which food number you need next
- Early moves determine later options, so think carefully

## Vim9 Language Features Demonstrated

- **Game Loop**: Real-time game execution with frame updates
- **State Management**: Snake position, direction, food location tracking
- **Collision Detection**: Multiple collision types (walls, self, food)
- **Type Checking**: Full type annotations throughout
- **Classes**: Organized game components with encapsulation
- **Popup Windows**: Modern UI using Vim's popup window API
- **Input Handling**: Responsive keyboard controls during gameplay

## License

This plugin is licensed under the MIT License. See the LICENSE file in the repository for details.

