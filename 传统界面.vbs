Set objWMIServices = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 

'���Ĵ��� 
Set sh = CreateObject("Shell.Application") 
call sh.ShellExecute( "sys\init.bat", "", , "runas" ) 
'function ShowHelp() 
'
'dim HelpStr 
'HelpStr = "�Թ���Ա������г���" & vbCrLf _ 
'& vbCrLf _ 
'& WScript.ScriptName & " [program] [parameters]..." & vbCrLf _ 
'& vbCrLf _ 
'& "sys\kernel\bootable\bootloader.bat" & vbCrLf _ 
'& "sys" & vbCrLf _ 
'& vbCrLf 
'WScript.Echo HelpStr 
'end function 
