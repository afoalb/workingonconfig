import XMonad
import System.IO
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- Layout
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders

-- Keybindings
import System.Exit
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Startup
import XMonad.Hooks.SetWMName


-------------------------------------------------------------------------------------
-- Structure:
-- First comes all configs, at the end of the document the configs are grouped
-- together in one variable and this is passed to the main function to run
-- xmonad



-------------------------------------------------------------------------------------
-- Terminal

myTerminal = "/usr/bin/xterm -u8"


-------------------------------------------------------------------------------------
-- Workspaces

-- myWorkspaces = map show [1..9]

myWorkspaces :: [[Char]]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]



-------------------------------------------------------------------------------------
-- Window rules

-- TODO: firefox not opening on window 2
myManageHook = composeAll
    [ className =? "firefox"        --> doShift "2"
    , className =? "stalonetray"    --> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)]

-------------------------------------------------------------------------------------
-- Layouts

myLayout = avoidStruts (
		-- LayoutName <X> <Y> <Z>
		-- where
		-- 		X = number of windows in the master pane
		--  	Y = percent of the screen to increment by when resizing panes
		-- 		Z = proportion of the screen occupied by master pane
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    tabbed shrinkText myTabConfig |||
    noBorders (fullscreenFull Full)
    )

-------------------------------------------------------------------------------------
-- Colors and borders

-- Color palette 
-- 0, 1, 2, ..., 5, 6, 7.
-- brigther ...  darker
cyan1 = "#b0d2ff"
cyan5 = "#343742"  -- dmenu bg
cyan6 = "#2b2e37"  -- xmobar bg
white1 = "#eeeeee"  -- xmobar selected window

grey2 = "#a5a8b0"  -- xmobar unselected window with apps
grey3 = "#7c7c7c"
grey4 = "#697180"
grey6 = "#4e5058"  -- xmobar unselected window without apps

black1 = "#37393e"
black3 = "#282a2f"
black6 = "#131315"

-- Panes
myNormalBorderColor  = grey3
myFocusedBorderColor = cyan1
myBorderWidth = 3

-- Style for tabs in the "Tabbed" layout.
myTabConfig = defaultTheme {
      fontName = "xft:Inconsolata:size=9"
    , decoHeight = 27
    , activeTextColor = white1
    , activeColor = cyan6
    , activeBorderColor = cyan6
    , inactiveTextColor = black1
    , inactiveColor = black6
    , inactiveBorderColor = black6
}


-------------------------------------------------------------------------------------
-- Key bindings
-- NOTE: Standard xmonad key bindings must remain in the file as xmonad
-- overrides all standard ones when I define my own.

myModMask = mod4Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $	

  -- terminal
  [ ((modMask, xK_Return),  -- default: mod-shift-return
     spawn $ XMonad.terminal conf)

  -- Swap the focused window and the master window.
  , ((modMask .|. shiftMask, xK_Return),  --default: mod-return
     windows W.swapMaster)

  -- Launch dmenu
  , ((modMask, xK_p),
    spawn "dmenu_run")

  -- Launch Browser
  , ((modMask, xK_b),
    spawn "firefox")

	-- Make laptop go to sleep ZzzZZ (lock it)
	, ((modMask .|. shiftMask, xK_z),
		spawn "xscreensaver-command -lock")

  -- take screenshot
  , ((modMask, xK_s),
     spawn "gnome-screenshot --interactive")

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),  -- default: mod-shift-c
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)
 
  -- Move focus to the next window.
  , ((modMask, xK_l),  -- default: mod-j
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask .|. shiftMask, xK_Tab),
     windows W.focusUp)

  -- Move focus to the previous window.
  , ((modMask, xK_h),  -- default: mod-k
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Resize by shrinking the master area.
  , ((modMask .|. shiftMask, xK_h),  -- default: mod-h
     sendMessage Shrink)

  -- Resize by expanding the master area.
  , ((modMask .|. shiftMask, xK_l),   -- default: mod-l
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask, xK_q),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-------------------------------------------------------------------------------------
-- Mouse bindings

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))
  ]


-------------------------------------------------------------------------------------
-- Startup hook
-- when xmonad starts

myStartupHook = return ()


-------------------------------------------------------------------------------------
-- Combine all configs into `myConfig`

myConfig = defaultConfig {
      terminal            = myTerminal
    , borderWidth         = myBorderWidth
    , modMask             = myModMask
    , workspaces          = myWorkspaces
    , normalBorderColor   = myNormalBorderColor
    , focusedBorderColor  = myFocusedBorderColor
    , layoutHook          = smartBorders $ myLayout  -- spacingWithEdge 5 $  -- spacing doens't go well with tabbed (still to be solved)
    ,  keys               = myKeys
    ,  focusFollowsMouse  = myFocusFollowsMouse
    ,  mouseBindings      = myMouseBindings
    ,  manageHook         = myManageHook
    ,  startupHook        = myStartupHook
}


-------------------------------------------------------------------------------------
-- Run xmonad with `defaults`

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ myConfig
        { handleEventHook = handleEventHook myConfig <+> docksEventHook -- fix xmonad overlaying xmobar
        , logHook = dynamicLogWithPP xmobarPP { ppOutput = hPutStrLn xmproc
																							, ppOrder = \(ws : _ : t : _) -> [ws, t] -- what to show after the workspace nbr
																							, ppTitle = xmobarColor grey4 "" . shorten 40
																							, ppWsSep = " " -- separation between workspace nbrs
																							, ppSep = xmobarColor grey4 "" " • " -- separation between group of workspaces and next group
																							, ppCurrent = xmobarColor white1 "" . wrap (xmobarColor white1 "" "[") (xmobarColor white1 "" "]")
																							, ppHidden = xmobarColor grey2 "" . wrap " " ""
																							, ppHiddenNoWindows = xmobarColor grey6 "" . wrap " " ""
																							}
				, manageHook = manageDocks <+> myManageHook
        , startupHook = setWMName "LG3D"
        }


