Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run chr(34) & "fun.exe" & Chr(34), 0
Set WshShell = Nothing