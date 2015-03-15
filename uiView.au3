#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\users\narfman0\desktop\pokebot\pokebot.kxf
$pokebotUI = GUICreate("pokebot", 167, 101, 402, 246)
$stateDescriptionLabel = GUICtrlCreateLabel("State:", 0, 0, 32, 17)
$stateLabel = GUICtrlCreateLabel("Unknown", 32, 0, 130, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func UpdateUI()
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
EndFunc
