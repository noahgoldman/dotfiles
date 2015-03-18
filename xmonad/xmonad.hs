import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W

myWorkspaces = ["1:term", "2:web", "3:term1", "4:term2", "5:music", "6:irc", "7", "8", "9"]

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Skype" --> doShift "3:skype"
    , className =? "Chromium" --> doShift "2:web"
    , className =? "Dwb" --> doShift "2:web"
    , className =? "luakit" --> doShift "2:web"
    , className =? "hon-x86_64" --> doShift "5:games"
    , className =? "music" --> doShift "6:irc"
    , className =? "Wine" --> doShift "5:games"
    , className =? "dota_linux" --> doFullFloat
    , className =? "dota_linux" --> doShift "5:games"
    , (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , manageDocks
    ]
    where role = stringProperty "WM_WINDOW_RULE"

myStartupHook = do
    setWMName "LG3D"
    spawn "urxvt"
    spawn "chromium"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar $HOME/.xmobarrc"
    xmonad $ defaultConfig {
        workspaces = myWorkspaces 
        , modMask = mod4Mask
        , handleEventHook = fullscreenEventHook
        , manageHook = myManageHook
        , startupHook = myStartupHook
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
        , terminal = "urxvt"
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        , ((0, xK_Super_L), return ())
        ]
