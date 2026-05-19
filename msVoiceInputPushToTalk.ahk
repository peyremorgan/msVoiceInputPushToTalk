#Requires AutoHotkey v2.0

CoordMode "Pixel", "Screen"

pttKeyIsDown := false


GetVoiceAccessPixelColor()
{
	return PixelGetColor(16, 16, "RGB")
}

IsColorClose(color, targetColor, tolerance := 25)
{
	; Redmean perceptual distance in sRGB.
	r1 := (color >> 16) & 0xFF
	g1 := (color >> 8) & 0xFF
	b1 := color & 0xFF
	r2 := (targetColor >> 16) & 0xFF
	g2 := (targetColor >> 8) & 0xFF
	b2 := targetColor & 0xFF
	rMean := (r1 + r2) / 2
	dR := r1 - r2
	dG := g1 - g2
	dB := b1 - b2
	distance := Sqrt((2 + rMean / 256) * dR * dR + 4 * dG * dG + (2 + (255 - rMean) / 256) * dB * dB)
	return distance <= tolerance
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
	if IsColorClose(color, 0x005FBA)
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
	if IsColorClose(color, 0xF2FAFD)
	{
		DebugVoiceAccessState("F9 up", color, "already-muted")
		return
	}

	DebugVoiceAccessState("F9 up", color, "send-toggle")

	Send "!+b"
}