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
    $xTarget = 0
    $yTarget = 0
    $target = _ImageSearch("attackTarget.bmp", 1, $xTarget, $yTarget, 30)
    $xFight = 0
    $yFight = 0
    $fight = _ImageSearch("fight.bmp", 1, $xFight, $yFight, 30)
    $xFaint = 0
    $yFaint = 0
    $faint = _ImageSearch("faint.bmp", 1, $xFaint, $yFaint, 70)
    $xShift = 0
    $yShift = 0
    $shift = _ImageSearch("shift.bmp", 1, $xShift, $yShift, 30)
    If $faint = 1 Then
	    HandleFaint($xFaint, $yFaint)
    ElseIf $target = 1 Then
		; when the target ui is up, either buff ally or atk enemy (autoselected)
		Send("x")
    ElseIf $shift = 1 Then
		Send("x")
    ElseIf $fight = 1 Then
		Send("x")
    ElseIf ColorInWindow($hWnd, $cgearColor) Then
        SearchMobs()
    ElseIf ColorInWindow($hWnd, $fightColor) or ColorInWindow($hWnd, $moveColor) Then
        AttackMobs()
    EndIf
	Sleep(300)
WEnd

Func HandleMouseClick($x, $y)
	MouseMove($x, $y, 0)
	Sleep(100)
	MouseClick("left")
	Sleep(100)
	MouseMove(0, 0, 0)
	Sleep(50)
EndFunc

Func HandleFaint($xFaint, $yFaint)
	HandleMouseClick($xFaint, $yFaint)
	Sleep(500) ;wait for pokemon transition
	Send("x")
	Sleep(200)
	Send("x")
EndFunc

Func SearchMobs()
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
    If $moveIdx = 0 Then
        Send("{up}")
        Sleep(100)
    ElseIf $moveIdx = 1 Then
        Send("{right}")
        Sleep(100)
    ElseIf $moveIdx = 2 Then
        Send("{down}")
        Sleep(100)
    ElseIf $moveIdx = 3 Then
        Send("{left}")
        Sleep(100)
    EndIf
    Send("x")
	$moveIdx = Mod($moveIdx + 1, 4)
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
