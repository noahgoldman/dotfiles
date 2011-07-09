import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO


myManageHook = composeAll
    [ className =? "Skype" --> doFloat
    , manageDocks
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar $HOME/.xmobarrc"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts $ layoutHook defaultConfig,
        terminal = "urxvt",
        logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
