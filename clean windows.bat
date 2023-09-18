@echo off

:: Verifique se o script está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Este script deve ser executado como administrador.
    echo Por favor, execute o script como administrador e tente novamente.
    pause
    exit /b
)
::Fechando Explorer.exe
echo.
taskkill /im explorer.exe /f
:: Limpar a pasta Temp
echo Limpando a pasta Temp...
echo.
del /q %temp%\*.*
del /q temp\*.*
RD /S "%windir%\temp" /q 
del %temp%*.* /s /q
del "%windir%\temp" /q
echo Pasta Temp limpa com sucesso.
echo.
echo Limpando a pasta AppData...
echo.
rd /s /q %userprofile%\AppData\Local\Temp
echo Pasta AppData limpa com sucesso.
:: Limpar a pasta Prefetch
echo Limpando a pasta Prefetch...
echo.
del /q %windir%\Prefetch\*.*
echo Pasta Prefetch limpa com sucesso.
echo.
::Limpando Recent.
echo Pasta Recente limpa com sucesso.
echo.
RD /S %windir%\recent" /q 
del /q %userprofile%\recent" /q
::resetResetando Algumas configurações De Rede.
echo Configurações De Rede Resetadas Com Sucesso!
echo.
ipconfig /release  
ipconfig /renew 
ipconfig /flushdns 
Netsh winsock reset
fsutil resource setautoreset true C:\  
netsh int ip reset resetlog.txt  
netsh winsock reset all 
netsh int 6to4 reset all 
Netsh int ip reset all 
netsh int ipv4 reset all 
netsh int ipv6 reset all 
netsh int httpstunnel reset all 
netsh int isatap reset all 
netsh int portproxy reset all 
netsh int tcp  all  
netsh int teredo reset all 
Netsh int ip reset  
Netsh winsock reset
::Limpar a pasta de logs de eventos
echo Limpando a pasta de logs de eventos...
echo.
wevtutil cl Application
wevtutil cl System
wevtutil cl Security
echo Pasta de logs de eventos limpa com sucesso.
echo.
:: Iniciando o Explorer
echo.
start explorer.exe
echo Limpeza completa do Windows concluída.
pause
