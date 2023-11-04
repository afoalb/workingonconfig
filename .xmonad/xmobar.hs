
Config { font = "xft:Inconsolata:size=11"
	, borderColor = "black"
	, border = TopB
    , bgColor = "#2B2E37"
    , fgColor = "#555e70"
	, lowerOnStart = True
    , position = TopSize L 100 40

	-- color active something: aac0f0

	-- Define commands here and use them in the template variable below
    , commands = [ Run Date "<fc=#929aad>%a%_d %b %H:%M</fc>" "date" 10
                
                 , Run Com           "sh" ["/home/rio/.xmonad/volume.sh"] "volume" 10

                 , Run Cpu           [ "--Low", "10"
                                     , "--High","90"
                                     , "--normal","#929aad"
                                     , "--high","red"
                                     ] 10 

                 , Run Memory        [ "--template" ,"Mem: <usedratio>%"
                                     , "--Low"      , "10"
                                     , "--High"     , "80"
                                     , "--normal"   , "#929aad"
                                     , "--high"     , "red"
                                     ] 10

                 , Run DynNetwork    [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                                     , "--Low"      , "5000"        -- units: kB/s
                                     , "--High"     , "5000000"     -- units: kB/s
                                     , "--normal"   , "#929aad"
                                     , "--high"     , "red"
                                     ] 10

                 , Run Battery       [ "--template" , "Batt: <acstatus>"
                                     , "--Low"      , "20"        -- unit: %
                                     , "-l"         , "red"
                                     , "--" -- battery specific options
                                         -- discharging status
                                         , "-o"	, "<fc=#929aad><left>%</fc> "  -- <timeleft> if time is needed
                                         -- AC "on" status
                                         , "-O"	, "<fc=green><left>%</fc>"
                                         -- charged status
                                         , "-i"	, "<fc=#aac0f0><left>%</fc>"
                                      ] 50

                 , Run StdinReader
                 ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = "  %StdinReader% } { %dynnetwork%   %memory%   %cpu%   %volume%   %battery%   %date%   "
 }

