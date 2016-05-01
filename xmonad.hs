import System.IO (hPutStrLn)
import XMonad
import XMonad.Layout.Gaps
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W

main = do
    xmproc <- spawnPipe "xmobar"
    spawnPipe "compton -c"
    spawnPipe "xscreensaver"
    xmonad $ defaultConfig
        { terminal      = "urxvtcd"
        , workspaces    = myWorkspaces
        , logHook       = myLogger xmproc
        , layoutHook    = myLayout
        , modMask       = mod5Mask
        } `additionalKeysP` myKeys

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myLayout = gaps [(U, 16)] $ Mirror (Tall 1 (3/100) (1/2)) ||| Full

myKeys = [(otherModMasks ++ "M-" ++ [key], action tag)
          | (tag, key) <- zip myWorkspaces "123456789"
          , (otherModMasks, action) <- [ ("", windows . W.view)
                                       , ("S-", windows . W.shift)
                                       ]
         ]

myLogger xmproc = dynamicLogWithPP xmobarPP
    { ppOutput  = hPutStrLn xmproc
    , ppCurrent = xmobarColor "#eee8d5" "" . wrap "[" "]"
    , ppTitle   = xmobarColor "#586e75" "" . shorten 60
    , ppSep     = " <fc=#ffccaa>:</fc> "
    , ppOrder   = \(ws:_:xs) -> ws : xs
    }
