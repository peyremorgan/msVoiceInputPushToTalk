#Requires AutoHotkey v2.0

CoordMode "Pixel", "Screen"

pttKeyIsDown := false


GetVoiceAccessPixelColor()
{
	return PixelGetColor(16, 16, "RGB")
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
		return
	}

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
		return
	}

	Send "!+b"
}