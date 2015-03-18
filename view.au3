#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "model.au3"
#Region ### START Koda GUI section ### Form=c:\users\narfman0\desktop\pokebot\pokebot.kxf
$pokebotUI = GUICreate("pokebot", 359, 71, 418, 233)
$stateDescriptionLabel = GUICtrlCreateLabel("State:", 0, 16, 32, 17)
$stateLabel = GUICtrlCreateLabel("Unknown", 96, 16, 50, 17)
$returnDescriptionLabel = GUICtrlCreateLabel("Return Directions: ", 0, 48, 92, 17)
$returnText = GUICtrlCreateEdit("", 96, 41, 209, 23, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL))
GUICtrlSetData(-1, "down 1000,left 1500,up 8000")
$returnApplyButton = GUICtrlCreateButton("Apply", 312, 40, 43, 25)
$pauseButton = GUICtrlCreateButton("Pause", 160, 8, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
    Update()
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $returnApplyButton
            $pokecenterReturn = GUICtrlRead($returnText)
        Case $pauseButton
            TogglePause()
    EndSwitch
    If $paused Then
        GUICtrlSetData($pauseButton, "Continue")
    Else
        GUICtrlSetData($pauseButton, "Pause")
    EndIf
    $clientSize = WinGetPos($hWnd)
    $botSize = WinGetPos($pokebotUI)
    GUICtrlSetData($stateLabel, $state)
    WinMove($pokebotUI, "", $clientSize[0], $clientSize[1] - $botSize[3])
WEnd
