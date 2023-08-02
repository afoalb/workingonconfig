

" =============================================================================
" General configs

" Make sure environment is correct
if &t_Co != 256
  echomsg ""
  echomsg "err: use a 256-color terminal and set it to t_Co=256"
  echomsg ""
  finish
endif

" Clear any predefined colours or backgroun
hi clear
if exists("syntax_on")
  syntax reset
endif

set background=dark
let colors_name = "mytheme"


" =============================================================================
" Colors

"" General
hi Normal           ctermfg=252     ctermbg=234     cterm=none    " mainly strings at status bar and full bg
hi Cursor           ctermfg=None    ctermbg=214     cterm=none    " character under the cursos
hi CursorLine       ctermfg=None    ctermbg=238     cterm=none    " the screen line that the cursor is in when 'cursorline' is set
hi CursorLineNr     ctermfg=251     ctermbg=None    cterm=none    " current nbr of line where cursor is
hi LineNr           ctermfg=238     ctermbg=None    cterm=none    " all the other line numbers
hi FoldColumn       ctermfg=248     ctermbg=bg      cterm=none
hi Folded           ctermfg=255     ctermbg=60      cterm=none    " line used to closed folds
hi Pmenu            ctermfg=0       ctermbg=246     cterm=bold    " pop menu
hi PmenuSbar        ctermfg=None    ctermbg=243     cterm=bold    " pop menu scrollbar
hi PmenuSel         ctermfg=0       ctermbg=243     cterm=bold    " pop menu selected item
hi PmenuThumb       ctermfg=None    ctermbg=252     cterm=bold    " pop menu thumb of scroll bar 
hi NonText          ctermfg=248     ctermbg=None    cterm=bold    " '~' and '@' at the end of the window (characters that don't really exist)
hi SpecialKey       ctermfg=77      ctermbg=None    cterm=none    " text that's displayed differently from what is really is
hi VertSplit        ctermfg=240     ctermbg=240     cterm=none    " column that splits the windows
hi StatusLine       ctermfg=None    ctermbg=240     cterm=bold    " status bar below for selected windows
hi StatusLineNC     ctermfg=241     ctermbg=237     cterm=none    " status bar below for non-selected windows
hi TabLineSel       ctermfg=None    ctermbg=None    cterm=none    " tabs - selected one
hi TabLine          ctermfg=248     ctermbg=240     cterm=none    " tabs - non-selected ones
hi TabLineFill      ctermfg=None    ctermbg=239     cterm=none    " tabs - fill where there's no tabs
hi Visual           ctermfg=None    ctermbg=237     cterm=none    " selected text
hi IncSearch        ctermfg=234     ctermbg=252     cterm=none    " search - highlighted phrase while typing
hi Search           ctermfg=None    ctermbg=239     cterm=none    " search - phrases highlighted after search
hi WildMenu         ctermfg=0       ctermbg=184     cterm=bold    " current match in wild menu completion
hi Directory        ctermfg=182     ctermbg=None    cterm=none    " dir names in listings


"" Syntax highlighting
hi Comment          ctermfg=244     ctermbg=None    cterm=none                 
hi String           ctermfg=113     ctermbg=None    cterm=none
hi Constant         ctermfg=170     ctermbg=None    cterm=none            
hi Error            ctermfg=15      ctermbg=1       cterm=none
hi ErrorMsg         ctermfg=15      ctermbg=1       cterm=none
hi Identifier       ctermfg=182     ctermbg=None    cterm=none
hi Ignore           ctermfg=238     ctermbg=None    cterm=none
hi MatchParen       ctermfg=188     ctermbg=68      cterm=bold
hi Number           ctermfg=180     ctermbg=None    cterm=none
hi PreProc          ctermfg=150     ctermbg=None    cterm=none
hi Special          ctermfg=174     ctermbg=None    cterm=none
hi Statement        ctermfg=110     ctermbg=None    cterm=none
hi Todo             ctermfg=0       ctermbg=184     cterm=none
hi Type             ctermfg=146     ctermbg=None    cterm=none 
hi Underlined       ctermfg=39      ctermbg=None    cterm=underline 

"" Special
""" .diff
hi diffAdded        ctermfg=150     ctermbg=None    cterm=none
hi diffRemoved      ctermfg=174     ctermbg=None    cterm=none
""" vimdiff
hi diffAdd          ctermfg=bg      ctermbg=151     cterm=none
hi diffDelete       ctermfg=bg      ctermbg=246     cterm=none
hi diffChange       ctermfg=bg      ctermbg=181     cterm=none
hi diffText         ctermfg=bg      ctermbg=174     cterm=none


