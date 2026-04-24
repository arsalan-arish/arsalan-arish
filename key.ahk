#Requires AutoHotkey v2.0

; 1. Map Physical Escape to CapsLock
Esc::CapsLock

; 2. Map CapsLock to Ctrl (held) or Escape (tapped)
*CapsLock::
{
    Send "{Blind}{Ctrl DownR}" ; 'DownR' is better for remapping
    ErrorLevel := !KeyWait("CapsLock", "T0.2") ; Wait 200ms
    
    if (ErrorLevel) {
        ; If we timed out (held longer than 200ms), just wait for release
        KeyWait "CapsLock"
    }
}

*CapsLock up::
{
    Send "{Blind}{Ctrl Up}"
    
    ; If the key was released quickly AND no other key was pressed
    ; A_PriorKey check ensures it doesn't send Esc if you did 'Ctrl+C'
    if (A_PriorKey = "CapsLock") {
        Send "{Esc}"
    }
}
; The '$' prefix prevents the hotkey from triggering itself
$-::Send "_{Blind}" 
$+-::Send "-{Blind}"