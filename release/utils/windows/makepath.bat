set autoexec=%SystemDrive%\AUTOEXEC.BAT
echo %autoexec%
echo path "%~dp0..\.." >>  %autoexec%
echo path "%~dp0..\..\..\tools\wbin" >>  %autoexec%
echo set DEMBROSVN="%~dp0..\..\..\.." >> %autoexec%
echo set DEMBROTRUNK="%~dp0..\..\.." >> %autoexec%
echo set DEMBRO="%~dp0..\.." >> %autoexec%
