#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         narfman0

 Script Function:
   Pokemon desmume grind bot. Black 2 targeted, but should work with any gen5.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
HotKeySet("{PAUSE}", "TogglePause")

global $paused
global $cgearColor = 0x189494
global $fightColor = 0xff2118
global $moveColor = 0x4a5252
global $inputWait = 1000
global $hWnd = WinGetHandle("[CLASS:DeSmuME]")

While True
   WinActivate($hWnd)
   If ColorInWindow($hWnd, $cgearColor) Then
      ; in cgear, keep moving
      Send("{z down}")
      Send("{left down}")
	  Sleep($inputWait)
      Send("{left up}")
      Send("{right down}")
      Sleep($inputWait)
      Send("{right up}")
      Send("{z up}")
   EndIf
   If ColorInWindow($hWnd, $fightColor) or ColorInWindow($hWnd, $moveColor) Then
      ; in fight, spam a
      Send("x")
   EndIf
WEnd

Func ColorInWindow($hWnd, $color)
   local $hWndPos = WinGetPos($hWnd)
   $coord = PixelSearch($hWndPos[0], $hWndPos[1], $hWndPos[0] + $hWndPos[2], $hWndPos[1] + $hWndPos[3], $color, 4, 4, $hWnd)
   return not @error
EndFunc

Func TogglePause()
   $paused = NOT $paused
   While $paused
      sleep(100)
   WEnd
EndFunc