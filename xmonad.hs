import System.IO (hPutStrLn)
import XMonad
import XMonad.Util.Run (spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Gaps

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad defaultConfig
        { terminal      = "urxvt"
        , workspaces    = ["1:status", "2:web", "3:term"]
        , logHook       = logHook' xmproc
        , layoutHook    = layoutHook'
        , modMask       = mod5Mask
        }

logHook' xmproc = dynamicLogWithPP xmobarPP
    { ppOutput  = hPutStrLn xmproc
    , ppCurrent = xmobarColor "#eee8d5" "".wrap "[" "]"
    , ppTitle   = xmobarColor "#586e75" "".shorten 50
    , ppSep     = " <fc=#ffccaa>:</fc> "
    }

layoutHook' = gaps [(U, 20)] $ Mirror (Tall 1 (3/100) (1/2)) ||| Full
