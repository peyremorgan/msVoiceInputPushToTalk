#Requires AutoHotkey v2.0

CoordMode "Pixel", "Screen"

pttKeyIsDown := false


GetVoiceAccessPixelColor()
{
	return PixelGetColor(16, 16, "RGB")
}

DebugVoiceAccessState(action, color, shortCircuitReason := "")
{
	message := action " | pixel(16,16)=" Format("0x{:06X}", color)
	if shortCircuitReason != ""
		message .= " | short-circuit=" shortCircuitReason

	OutputDebug message
}

F9::
{
	global pttKeyIsDown
	if pttKeyIsDown
		return

	pttKeyIsDown := true
	color := GetVoiceAccessPixelColor()
	if color = 0x005FBA
	{
		DebugVoiceAccessState("F9 down", color, "already-active-mic")
		return
	}

	DebugVoiceAccessState("F9 down", color, "send-toggle")

	Send "!+b"
}

F9 up::
{
	global pttKeyIsDown
	if !pttKeyIsDown
		return

	pttKeyIsDown := false
	color := GetVoiceAccessPixelColor()
	if color = 0xF2FAFD
	{
		DebugVoiceAccessState("F9 up", color, "already-muted")
		return
	}

	DebugVoiceAccessState("F9 up", color, "send-toggle")

	Send "!+b"
}