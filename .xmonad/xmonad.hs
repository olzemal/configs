import XMonad

main = xmonad $ def
    { borderWidth        = 2
    , terminal           = "alacritty"
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00" }

