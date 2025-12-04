A_HotkeyInterval := 100
; vi like key
; Ctrl key move Cursor Control Keys
^h::
{
	Send "{LEFT}"
}

^j::
{
	Send "{DOWN}"
}

^k::
{
	Send "{UP}"
}

^l::
{
	Send "{Right}"
}

; Ctrl plus shift key is select move Cursor
+^h::
{
	Send "+{LEFT}"
}

+^j::
{
	Send "+{DOWN}"
}

+^k::
{
	Send "+{UP}"
}

+^l::
{
	Send "+{Right}"
}

;HHK US KeyMap
;HHK input jis key
*"::
{
	send "@"
}

*&::
{
	send "{^}"
}

*'::
{
	send "&"
}

*(::
{
	send "*"
}

*)::
{
	send "("
}

*+0::
{
	send ")"
}

*=::
{
	send "{_}"
}

*^::
{
	send "="
}

*~::
{
	send "{+}"
}

*@::
{
	send "["
}

*`::
{
	send "{{}"
}

*[::
{
	send "]"
}

*{::
{
	send "{}}"
}

*]::
{
	send "\"
}

*}::
{
	send "|"
}

*+::
{
	send ":"
}

*vkBA::
{
	send "'"
}

VKF4::
{
	send "{``}"
}

+VKF4::
{
	send "{~}"
}

+*::
{
	send '{"}'
}

;HHK US KeyMap
;HHK Winkey Bind
*LWin::
{
	Send "{vk1Dsc07B}"
}

*RWin::
{
	
	Send "{vk1Csc079}"
}






