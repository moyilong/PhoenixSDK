Set objWMIServices = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 
Set objWbemObjectSet = objWMIServices.ExecQuery(_ 
"SELECT * FROM Win32_Process WHERE " &_ 
"ExecutablePath='" & Replace(WScript.FullName,"\","\\") & "' and " & _ 
"CommandLine LIKE '%" & WScript.ScriptName & "%'") 
for each objWbemObject in objWbemObjectSet 
cmdline = objWbemObject.CommandLine 
next 
if WScript.Arguments.Count then 
file = WScript.Arguments(0) 
if file="/?" then 
call ShowHelp() 
WScript.Quit 
end if 
Set RegEx = new RegExp 
RegEx.IgnoreCase = true 
RegEx.Global = true 
RegEx.Pattern = "\\|\/|\||\(|\)|\[|\]|\{|\}|\^|\$|\.|\*|\?|\+" 
temp1 = RegEx.Replace(WScript.ScriptName, "\$&") 
temp2 = RegEx.Replace(file, "\$&") 
RegEx.Global = false 
RegEx.Pattern = "^.*?" & temp1 & "[""\s]*" & temp2 & """?\s*" 
args = RegEx.Replace(cmdline, "") 
'WScript.Echo file, args 
else 
file = "sys\init.bat" 
'args = "/k cd /d """ & CreateObject("WScript.Shell").CurrentDirectory & Chr(34) 
end if 
'核心代码 
Set sh = CreateObject("Shell.Application") 
call sh.ShellExecute( file, args, , "runas" ) 
function ShowHelp() 
dim HelpStr 
HelpStr = "以管理员身份运行程序。" & vbCrLf _ 
& vbCrLf _ 
& WScript.ScriptName & " [program] [parameters]..." & vbCrLf _ 
& vbCrLf _ 
& "sys\kernel\bootable\bootloader.bat" & vbCrLf _ 
& "sys" & vbCrLf _ 
& vbCrLf 
WScript.Echo HelpStr 
end function 
