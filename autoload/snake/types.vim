vim9script

export type Pos = list<number>
export type Vec2 = list<number>

export enum Direction
  Left,
  Right,
  Up,
  Down
endenum

export enum GameState
  Ready,
  Running,
  Over
endenum

export interface IRenderer
  def Open(): void
  def Close(): void
  def SetText(lines: list<string>): void
  def IsOpen(): bool
endinterface
