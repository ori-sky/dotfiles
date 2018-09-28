import System.IO (hPutStrLn)
import qualified Data.Map as M
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import XMonad.Layout.Gaps
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane
import XMonad.Layout.NoBorders
import XMonad.Actions.Submap
import XMonad.Actions.Eval
import XMonad.Prompt.Man
import XMonad.Prompt.Eval

main = do
    xmproc <- spawnPipe "xmobar"
    spawnPipe "compton --config ~/dev/dotfiles/compton.conf --backend glx --vsync opengl-swc --glx-no-stencil --paint-on-overlay -c"
    --compton --config ~/dev/dotfiles/compton.conf --backend glx --vsync opengl-mswc --glx-use-copysubbuffermesa
    spawnPipe "xscreensaver"
    xmonad $ defaultConfig
        { terminal      = "urxvtcd"
        , workspaces    = myWorkspaces
        , logHook       = myLogger xmproc
        , layoutHook    = myLayout
        , modMask       = mod5Mask
        , keys          = myKeys
        } `additionalKeysP` myAdditionalKeys

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

--myLayout = gaps [(U, 16)] $ Mirror (Tall 1 (3/100) (1/2)) ||| Full

myLayout = gaps [(U, 16)] $ windowNavigation $ subTabbed $ boringWindows $
    Mirror (Tall 1 (3/100) (1/2)) ||| noBorders Full

myKeys conf@(XConfig {XMonad.modMask = modMask}) = flip M.union (k conf) $ M.fromList
    [ ((modMask,               xK_Right), sendMessage $ Go R)
    , ((modMask,               xK_Left ), sendMessage $ Go L)
    , ((modMask,               xK_Up   ), sendMessage $ Go U)
    , ((modMask,               xK_Down ), sendMessage $ Go D)
    , ((modMask .|. shiftMask, xK_Right), sendMessage $ Swap R)
    , ((modMask .|. shiftMask, xK_Left ), sendMessage $ Swap L)
    , ((modMask .|. shiftMask, xK_Up   ), sendMessage $ Swap U)
    , ((modMask .|. shiftMask, xK_Down ), sendMessage $ Swap D)
    , ((modMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
    , ((modMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))
    , ((modMask .|. controlMask, xK_j), onGroup W.focusDown')
    , ((modMask .|. controlMask, xK_k), onGroup W.focusUp')
    , ((modMask, xK_j), focusDown)
    , ((modMask, xK_k), focusUp)
    , ((modMask, xK_s), asks config >>= submap . defaultSublMap)
    , ((modMask, xK_F1), manPrompt def)
    , ((modMask, xK_x), evalPrompt defaultEvalConfig def)
    ]
  where XConfig {XMonad.keys = k} = defaultConfig

myAdditionalKeys = [(otherModMasks ++ "M-" ++ [key], action tag)
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
