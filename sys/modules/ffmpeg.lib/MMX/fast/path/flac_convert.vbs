'================================================
' ��ָ��Ŀ¼��flac�ı��mp3
' ���õ�flac.exe, lame.exe��metaflac.exe
' ToDo: ��Ҫ���ӿ������image tag�Ĺ���
'================================================
'On Error Resume Next

Const gv_foldername = "."

Set gv_fso = CreateObject("Scripting.FileSystemObject")

For Each filename in gv_fso.GetFolder(gv_foldername).Files
    If Right(filename,5) = ".flac" Then
        WScript.Echo "-> Found File: " & filename.Name
        Tag1 = GetFlacTag(filename, "ARTIST")
        Tag2 = GetFlacTag(filename, "ALBUM")
        Tag3 = GetFlacTag(filename, "TRACKNUMBER")
        Tag4 = GetFlacTag(filename, "TITLE")
        Tag = Tag1 & "," & Tag2 & "," & Tag3 & "," & Tag4
        If Tag <> ",,," Then
            WScript.Echo "-> Tag found: " & Tag
        Else
            WScript.Echo "-> no Tag Found"
        End If
        WScript.Echo "-> Try to convert flac into wav: " & filename.Name
        If ExecCmd("flac -d " & filename) = "ERROR" Then
            WScript.Echo "Fatal Error Occurs, abort(-1)"
            WScript.Quit(-1)
        End If
       
        shortname = Left(filename.Name,len(filename.Name) - 5)
        lame_cmd = "lame --silent --ta '" & Tag1
        lame_cmd = lame_cmd & "' --tl '" & Tag2
        lame_cmd = lame_cmd & "' --tn '" & Tag3
        lame_cmd = lame_cmd & "' --tt '" & Tag4
        lame_cmd = lame_cmd & "' " & shortname & ".wav "
        lame_cmd = lame_cmd & shortname & ".mp3"
        WScript.Echo "-> Try to convert wav into mp3..."
       
        ExecCmd(lame_cmd)
        WScript.Echo "-> Successfully converted."
       
        ' ɾ����ʱ���ɵ�wav�ļ�
        gv_fso.DeleteFile(shortname & ".wav")
        WScript.Echo "-> temp wav file deleted."
    End If
Next

Function GetFlacTag(ByVal lv_filename, ByVal lv_tag)
    lv_cmdline = "metaflac --show-tag=" & lv_tag & " " & lv_filename
    lv_return = ExecCmd(lv_cmdline)
    If lv_return <> "ERROR" Then
        GetFlacTag = Mid(lv_return,len(lv_tag)+2)
    Else
        GetFlacTag = "ERROR"
    End If
End Function

Function ExecCmd(ByVal lv_cmdline)
    set lv_WshShell = WScript.CreateObject("Wscript.Shell")
    Set lv_ret = lv_WshShell.Exec(lv_cmdline)
    Do While lv_ret.Status = 0
        WScript.Sleep 100
    Loop
    If lv_ret.ExitCode = 0 Then
        ExecCmd = Replace(Trim(lv_ret.Stdout.ReadAll()),vbCrLf,"")
    Else
        ExecCmd = "ERROR"
    End If
End Function

'# ����

'################################################
'# ����:     Shrink
'# ˵��:       �Ѷ���Ŀո�ɾ��, �������ո�
'# ����:       lv_Str - �ַ���
'# ����:       ɾ������ո����ַ���
'################################################
Function Shrink(ByVal lv_Str)
    Set lvRegExp = New RegExp
    With lvRegExp
        .Global = True
        .Pattern = "[\s|��]+"
        Shrink = .Replace(lv_Str, "")
    End With
    Set lvRegExp = Nothing
End Function
