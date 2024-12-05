# Create a new COM object for simulating keystrokes
$wshell = New-Object -ComObject wscript.shell

# Send Ctrl+A (Select All)
$wshell.SendKeys("^a")
Start-Sleep -Milliseconds 2

# Send Ctrl+S (Save)
$wshell.SendKeys("^s")
Start-Sleep -Milliseconds 1000

# Send "pass"
$wshell.SendKeys("pass")
Start-Sleep -Milliseconds 1500

# Send Enter
$wshell.SendKeys("{ENTER}")
