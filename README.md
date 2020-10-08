# netmonappdown
monitor status of interactive Heartland OneCard Network Manager

We run the Heartland OneCard Network Manager in interactive mode because the user interface is helpful in monitoring what NetMon is doing.
If you run NetMon as a service only because it will restart itself then the user interface is not available and this script won't be of any assistance.

I use a Windows Task "HeartlandNetMon" (also here as an .XML) to run my netmon.ps1 script on the dedicated server for Heartland OneCard NetMon every 10 minutes 24/7/365. 
The script checks whether or not NetMon.exe and/or subcomponenet GMCIPBB.exe are running and logs ethat status.
In brief testing, I could not restart GMCIPBB.exe if NetMon.exe was running, but I did get NetMon.exe to restart. Of late, the restart is not working.
However, the email notification that NetMon was down does go out to my team.
