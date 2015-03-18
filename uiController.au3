#include "model.au3"
#include "uiView.au3"

While 1
	Update()
	UpdateUI()
	$clientSize = WinGetPos($hWnd)
	$botSize = WinGetPos($pokebotUI)
	GUICtrlSetData($stateLabel, $state)
	WinMove($pokebotUI, "", $clientSize[0], $clientSize[1] - $botSize[3])
WEnd