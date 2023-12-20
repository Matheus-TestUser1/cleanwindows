@echo off
taskkill /im explorer.exe /f

:: Clearing temporary files
Takeown /f %temp% /R /D N
icacls %temp% /E /T /G Todos:F
RD /S %temp% /q
del %temp% /q

:: Clearing Windows temp folder
Takeown /f \"%windir%\\temp\" /R /D N
icacls \"%windir%\\temp\" /E /T /G Todos:F
RD /S \"%windir%\\temp\" /q
del \"%windir%\\temp\" /q

:: Clearing prefetch folder
Takeown /f \"%windir%\\prefetch\" /R /D N
icacls \"%windir%\\prefetch\" /E /T /G Todos:F
RD /S \"%windir%\\prefetch\" /q
del \"%windir%\\prefetch\" /q

:: Clearing recent folder
Takeown /f %userprofile%\\recent\" /R /D N
icacls %userprofile%\\recent\" /E /T /G Todos:F
RD /S %userprofile%\\recent\" /q
del %userprofile%\\recent\" /q

:: Clearing AppData for current user
RD /S /Q "%userprofile%\AppData\Local\Temp"
RD /S /Q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache"
RD /S /Q "%userprofile%\AppData\Local\Microsoft\Windows\History"
RD /S /Q "%userprofile%\AppData\Local\Microsoft\Windows\Cookies"

:: Clearing AppData for all users
RD /S /Q "%windir%\ServiceProfiles\LocalService\AppData\Local\Temp"
RD /S /Q "%windir%\ServiceProfiles\NetworkService\AppData\Local\Temp"

:: Clearing browser history and cache
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351

:: Resetting network configurations
ipconfig /release
ipconfig /renew
ipconfig /flushdns
Netsh winsock reset
net localgroup administradores localservice /add
fsutil resource setautoreset true C:\\
netsh int ip reset resetlog.txt
netsh winsock reset all
netsh int 6to4 reset all
Netsh int ip reset all
netsh int ipv4 reset all
echo off
echo Limpando a memória RAM...

:: Libera a memória RAM usando o EmptyStandbyList
%SystemRoot%\System32\rundll32.exe advapi32.dll,ProcessIdleTasks

echo Limpeza concluída.
start explorer
exit