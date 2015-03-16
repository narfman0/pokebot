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
global $moveLeft
global $cgearColor = 0x189494
global $fightColor = 0xff2118
global $moveColor = 0x4a5252
global $inputWait = 1000
global $hWnd = WinGetHandle("[CLASS:DeSmuME]")
global $moveIdx = 0
global $state = 'Not Started'

Func Update()
	If $paused Then
	    $state = 'Paused'
		Return
	EndIf
    WinActivate($hWnd)
	$clientSize = GetWindowSize($hWnd)
    $xTarget = 0
    $yTarget = 0
    $target = _ImageSearchArea("attackTarget.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xTarget, $yTarget, 10)
    $xFight = 0
    $yFight = 0
    $fight = _ImageSearchArea("fight.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xFight, $yFight, 30)
    $xFaint = 0
    $yFaint = 0
    $faint = _ImageSearchArea("faint.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xFaint, $yFaint, 70)
    $xShift = 0
    $yShift = 0
    $shift = _ImageSearchArea("shift.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xShift, $yShift, 30)
    $xFightPokeball = 0
    $yFightPokeball = 0
    $fightPokeball = _ImageSearchArea("fightPokeball.bmp", 1, $clientSize[0], $clientSize[1], $clientSize[2], $clientSize[3], $xFightPokeball, $yFightPokeball, 30)
    If $faint Then
	    HandleFaint($xFaint, $yFaint)
		$state = 'Faint'
    ElseIf $target Then
		; when the target ui is up, either buff ally or atk enemy (autoselected)
		Send("x")
		$state = 'Attacking target'
	    HandleMouseClick($xTarget, $yTarget)
    ElseIf $shift Then
		Send("x")
		$state = 'Shifting'
    ElseIf $fight Then
		Send("x")
		$state = 'Fighting'
	    HandleMouseClick($xFight, $yFight)
    ElseIf ColorInWindow($hWnd, $cgearColor) Then
        SearchMobs()
		$state = 'Searching for mobs'
    ElseIf $fightPokeball Then
        AttackMobs()
	Else
		Send("x") ; don't know, continue... e.g. gained xp, found random stuff, leveled up, etc
		$state = 'Unknown'
    EndIf
EndFunc

Func GetWindowSize($hWnd)
	$clientSize = WinGetPos($hWnd)
	Local $arr[4] = [$clientSize[0], $clientSize[1], $clientSize[0] + $clientSize[2], $clientSize[1] + $clientSize[3]]
	return $arr
EndFunc

Func HandleMouseClick($x, $y)
	MouseMove($x, $y, 0)
	Sleep(10)
	MouseClick("left")
	Sleep(100)
	MouseMove(0, 0, 0)
	Sleep(10)
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
	If $moveLeft Then
        Send("{left down}")
        Sleep($inputWait)
        Send("{left up}")
	Else
        Send("{right down}")
        Sleep($inputWait)
        Send("{right up}")
    EndIf
    Send("{z up}")
	$moveLeft = Not $moveLeft
EndFunc

Func AttackMobs()
    ; in fight, spam a
    $state = 'Selecting move ' & $moveIdx
	Sleep(200)
    If $moveIdx = 0 Then
        Send("{up}")
    ElseIf $moveIdx = 1 Then
        Send("{right}")
    ElseIf $moveIdx = 2 Then
        Send("{down}")
    ElseIf $moveIdx = 3 Then
        Send("{left}")
    EndIf
	Sleep(500)
    Send("x")
	Sleep(200)
	$moveIdx = Mod($moveIdx + 1, 4)
EndFunc

Func ColorInWindow($hWnd, $color)
    local $hWndPos = WinGetPos($hWnd)
    $coord = PixelSearch($hWndPos[0], $hWndPos[1], $hWndPos[0] + $hWndPos[2], $hWndPos[1] + $hWndPos[3], $color, 4, 4, $hWnd)
    return not @error
EndFunc

Func TogglePause()
    $paused = NOT $paused
EndFunc