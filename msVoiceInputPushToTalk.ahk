#Requires AutoHotkey v2.0

pttKeyIsDown := false

F9::
{
	global pttKeyIsDown
	if pttKeyIsDown
		return

	pttKeyIsDown := true
	Send "!+b"
}

F9 up::
{
	global pttKeyIsDown
	if !pttKeyIsDown
		return

	pttKeyIsDown := false
	Send "!+b"
}