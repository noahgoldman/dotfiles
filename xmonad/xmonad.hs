import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W

myWorkspaces = ["1:term", "2:web", "3:skype", "4:music", "5:games", "6:pdf", "7", "8", "9"]

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Skype" --> doShift "3:skype"
    , className =? "Google-chrome" --> doShift "2:web"
    , className =? "hon-x86_64" --> doShift "5:hon"
    , className =? "music" --> doShift "4:irc"
    , manageDocks
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar $HOME/.xmobarrc"
    xmonad $ defaultConfig {
        workspaces = myWorkspaces 
        , modMask = mod4Mask
        , manageHook = myManageHook
        , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
        , terminal = "urxvt"
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
