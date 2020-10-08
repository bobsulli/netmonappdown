# netmon.ps1 restart Heartland Network Manager if not running
# run this script on SRUHLNM01 as heartland.admin
$log = "C:\Users\heartland.admin\netmon.log"
$itis = Get-Date -Format "yyyy-MM-dd HH:mm"

# NET USE O: \\sruhlapp01\1card$ in C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\1Card_Connect.bat
New-PSDrive -Name O -PSProvider FileSystem -Root \\SRUHLAPP01\1card$ -description Heartland

# check status of Network Manager subsystem
$gmcipbb = Get-WmiObject -Class win32_process -filter "name='GMCIPBB.EXE'"
If ($gmcipbb -eq $null)
    {
    "{0} GMCIPBB not running" -f $itis >>$log
    }
Else
    {
    "{0} GMCIPBB running" -f $itis >>$log
    }

# check status of Network Manager and relaunch if not running
$netmon = Get-WmiObject -Class win32_process -filter "name='NetMon.exe'"
If ($netmon -eq $null)
    {
    "{0} NetMon not running" -f $itis >>$log
    & "O:\1Card\1Card\NetMon.exe" #TEST at front if testing
    "{0} relaunched O:\1Card\1Card\NetMon.exe which relaunches GMCIPBB" -f $itis >>$log
    # send email when NetMon relaunched
    $ebody = "Heartland Network Manager (NetMon.exe) was not running on SRUHLNM01 at {0} and has been relaunched." -f $itis
    $eto = @("bob.sullivan@salve.edu", "dumontc@salve.edu")
    $efrom = "dataconnect@salve.edu"
    $esubj = "Heartland NetMon relaunched"
    $eport = 25
    $esmtp = "192.168.51.23"
    Send-MailMessage -Subject $esubj -Body $ebody -From $efrom -To $eto -SmtpServer $esmtp -Port $eport
    "{0} NetMon relaunch email sent" -f $itis >>$log
    }
else
    {
    "{0} NetMon running" -f $itis >>$log
    }

# end of netmon.ps1 by Bob Sullivan for Salve Regina University
