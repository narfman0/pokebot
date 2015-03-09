#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         narfman0

 Script Function:
   Pokemon desmume grind bot. Black 2 targeted, but should work with any gen5.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <ImageSearch.au3>

HotKeySet("{PAUSE}", "TogglePause")

global $paused
global $cgearColor = 0x189494
global $fightColor = 0xff2118
global $moveColor = 0x4a5252
global $inputWait = 1000
global $hWnd = WinGetHandle("[CLASS:DeSmuME]")
global $moveIdx = 0

While True
    WinActivate($hWnd)
    $xDisabled = 0
    $yDisabled = 0
    $disabled = _ImageSearch("disabled.bmp", 1, $xDisabled, $yDisabled, 60)
    $xFaint = 0
    $yFaint = 0
    $faint = _ImageSearch("faint.bmp", 1, $xFaint, $yFaint, 70)
    If $disabled = 1 Then
        ;if the disabled dialog has come up, increment our target move
        $moveIdx = $moveIdx + 1
        Sleep(2000) ;wait for disabled dialog to go away
    ElseIf $faint = 1 Then
        MouseClick("left", $xFaint, $yFaint)
        Sleep(500) ;wait for pokemon transition
        Send("x")
        Sleep(200)
        Send("x")
    ElseIf ColorInWindow($hWnd, $cgearColor) Then
        SearchMobs()
    ElseIf ColorInWindow($hWnd, $fightColor) or ColorInWindow($hWnd, $moveColor) Then
        AttackMobs()
    EndIf
WEnd

Func SearchMobs()
    ; clear disabled moves
    $moveIdx = 0
    ; in cgear, keep moving
    Send("{z down}")
    Send("{left down}")
    Sleep($inputWait)
    Send("{left up}")
    Send("{right down}")
    Sleep($inputWait)
    Send("{right up}")
    Send("{z up}")
EndFunc

Func AttackMobs()
    ; in fight, spam a
    If $moveIdx = 1 Then
        Send("{right}")
        Sleep(100)
    ElseIf $moveIdx = 2 Then
        Send("{down}")
        Sleep(100)
    ElseIf $moveIdx = 3 Then
        Send("{right}")
        Sleep(100)
        Send("{down}")
        Sleep(100)
    EndIf
    Send("x")
EndFunc

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
