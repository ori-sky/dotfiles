import System.IO (hPutStrLn)
import XMonad
import XMonad.Util.Run (spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Gaps

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad defaultConfig
        { terminal      = "urxvtcd"
        , workspaces    = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        , logHook       = logHook' xmproc
        , layoutHook    = layoutHook'
        , modMask       = mod5Mask
        }

logHook' xmproc = dynamicLogWithPP xmobarPP
    { ppOutput  = hPutStrLn xmproc
    , ppCurrent = xmobarColor "#eee8d5" "" . wrap "[" "]"
    , ppTitle   = xmobarColor "#586e75" "" . shorten 60
    , ppSep     = " <fc=#ffccaa>:</fc> "
    , ppOrder   = \(ws:_:xs) -> ws : xs
    }

layoutHook' = gaps [(U, 16)] $ Mirror (Tall 1 (3/100) (1/2)) ||| Full
