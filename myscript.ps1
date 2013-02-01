# parameters 
param($hostname = "",$port = "") 
 $str="*** I'm checking " + $hostname + " on port => "  + $port + "     ***"
 echo "***********************************************"
 echo "***********************************************"
 echo "***            TELNET SEQUENCER             ***"
 echo $str
 echo "***                                         ***"
 echo "***********************************************"
 echo "***********************************************"

filter Test-TcpPort {
  
   $socket = new-object Net.Sockets.TcpClient
   $socket.Connect($_, $port)
   $stream = $socket.getStream() 
   if ($socket.Connected) {
   $status = "Open"
   $text = ""
   Start-Sleep -m 1000

    while ($stream.DataAvailable) {
    $text += [char]$stream.ReadByte() }
    $buffer= $text
    $socket.Close()

   }

 else {

     $status = "Closed / Filtered"

    }

    $socket = $null

     write-output "$_`t$port`t$status     $buffer" 
     }


 $a = $hostname
 $a | Test-TcpPort | echo >> TelnetSequencerOutput.txt 



