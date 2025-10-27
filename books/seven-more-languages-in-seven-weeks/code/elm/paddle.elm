import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Window
import Signal

drawPaddle w h x =
  filled black (rect 80 10)
    |> moveX (toFloat x - toFloat w / 2)
    |> moveY (toFloat h * -0.45)
                    
display (w, h) x  = collage w h
       [ drawPaddle w h x ]

main = Signal.map2 display Window.dimensions Mouse.x
