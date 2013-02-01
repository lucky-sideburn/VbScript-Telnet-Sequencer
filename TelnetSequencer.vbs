'declaring varables...
Dim  myobj,myfile,mystring,host,port,finalstring
'object for file I/O 
Set  myobj = CreateObject("Scripting.FileSystemObject")
Dim mypath
'absolute path for TelnetSequencer
mypath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".")

'***************************************
'TelnetSequencerOutput.txt is there ?
IF (myobj.FileExists("TelnetSequencerOutput.txt")) then
myobj.DeleteFile("TelnetSequencerOutput.txt")
end if
'****************************************

'***************************************
'Exit if the server-list does not exist
IF (NOT(myobj.FileExists("serverlist.txt"))) then
wscript.echo "File serverlist.txt NOT FOUND!"
WScript.Quit 
end if
'****************************************

Set  myfile   = myobj.OpenTextFile("serverlist.txt", 1)
finalstring = "**** Telnet Sequencer ****" & vbCrLf & vbCrLf
set wshShell = CreateObject("WScript.Shell")

'****************************************
'the loop finish ant end of the file
Do Until myfile.AtEndOfStream
     mystring = myfile.Readline()
    
'parsing HOSTNAME;PORT.. ritorna un array
     vector = split(mystring, ";")
     wshShell.run "powershell.exe  -command  "& mypath &"\myscript.ps1 " & vector(0) & "  " & vector(1)  ,3,true
     Loop
'******************************************

finalstring = finalstring & vbCrLf & "**********************"
WScript.echo "*** Telnet Sequencer ***" & vbCrLf & " Execution complete. You can find the results in TelnetSequencerOutput.txt "  & vbCrLf & "   ************  "
WScript.Quit 










