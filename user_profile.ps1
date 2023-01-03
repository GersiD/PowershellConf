$env:Path += ";C:\Users\gersi\scoop\apps\oh-my-posh\12.2.0\bin\"
# Prompt
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Import-Module posh-git
oh-my-posh init pwsh --config 'C:\Users\gersi\scoop\apps\oh-my-posh\current\themes\jandedobbeleer.omp.json' | Invoke-Expression

# Imports
Import-Module PSFzf
Import-Module -Name terminal-Icons
Import-Module CompletionPredictor

# Path fixes
$env:Path += ";C:\Program Files\nodejs\;"
$env:Path += ";C:\Users\gersi\AppData\Local\Microsoft\WindowsApps\;"
$env:Path += ";~\.cargo\bin\;"
$env:Path += ";C:\Users\gersi\AppData\Local\Programs\Microsoft VS Code;"
$env:Path += ";C:\Users\gersi\AppData\Local\Programs\MiKTeX\miktex\bin\x64;"
$env:Path += ";C:\Users\gersi\AppData\Local\Microsoft\WinGet\Links\;"
$env:Path += ";C:\Users\gersi\AppData\Local\Programs\Python\Python311\;"
$env:Path += ";C:\Users\gersi\AppData\Local\Programs\Python\Python311\Scripts\;"






# Cool Features
## Set PSReadLine options and keybindings
$PSROptions = @{
    ContinuationPrompt = '  '
    Colors             = @{
        Operator         = $PSStyle.Foreground.Blue
        Parameter        = $PSStyle.Foreground.Cyan
        Selection        = $PSStyle.Background.BrightBlack
        InLinePrediction = $PSStyle.Foreground.BrightBlue
    }
}
Set-PSReadLineOption @PSROptions
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadlineKeyHandler -Chord 'Ctrl+Shift+A' -Function AcceptNextSuggestionWord 
# Cntrl + Shift + A now accepts the next word
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

## Add argument completer for the dotnet CLI tool
$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition $commandAst.ToString() |
        ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock

# Usefull Functions
function time
{ $Command = "$args"; Measure-Command { Invoke-Expression $Command 2>&1 | out-default} 
}
function launchExplorerInCurrentDir
{ explorer . 
}
function launchCodeInCurrentDir
{ code . 
}
function kall
{ $Command = "$args*"; sudo kill -Force -Name $Command
}
function shut_down_pc
{
    Stop-Computer -Force
}
function rm_force {
    $Command = "$args"; Remove-Item -Force $Command
}
function sleep_pc {
    Add-Type -AssemblyName System.Windows.Forms
    $PowerState = [System.Windows.Forms.PowerState]::Hibernate;
    $Force = $true;   
    $DisableWake = $false;
    # The following function takes (State, Force, DisableWake) as parameters
    [System.Windows.Forms.Application]::SetSuspendState($PowerState, $Force, $DisableWake);
}
# Alias
Set-Alias v nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\brin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias ahk2exe 'C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe'
Set-Alias ahks 'C:\Users\gersi\Desktop\scripts\screenShotShortcut.exe'
Set-Alias replaceAHK 'C:\Users\gersi\Desktop\scripts\replaceAhkScript.ps1'
Set-Alias j z
Set-Alias touch New-Item
Set-Alias e launchExplorerInCurrentDir
Set-Alias which Get-Command
Set-Alias c launchCodeInCurrentDir
Set-Alias off shut_down_pc
Set-Alias rm rm_force
Set-Alias nap sleep_pc
