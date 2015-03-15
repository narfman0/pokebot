#include "model.au3"
#include "uiView.au3"

While 1
	Update()
	UpdateUI()
	GUICtrlSetData($stateLabel, $state)
WEnd