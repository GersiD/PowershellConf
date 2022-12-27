Set-Location C:\Users\Gersi\Desktop\gradSchool\
# Prompt
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jv_sitecorian.omp.json"| Invoke-Expression

# Imports
Import-Module PSFzf
Import-Module -Name terminal-Icons
Import-Module CompletionPredictor

$env:Path += ';C:\Users\Gersi\.cargo\bin\;'
$env:Path += ';C:\Program Files\nodejs\;'
$env:Path += ';C:\Users\Gersi\scoop\apps\gcc\11.2.0\bin\;'
$env:Path += ';C:\Users\Gersi\AppData\Local\Microsoft\WinGet\Links\;' 
$env:Path += ';C:\Program Files\AutoHotkey\Compiler\;' 
$env:Path += ';C:\Users\Gersi\AppData\Local\Microsoft\WindowsApps\;'



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
Set-PSReadlineKeyHandler -Chord 'Ctrl+Shift+A' -Function AcceptSuggestion 
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

# source local functions before aliasing
. "C:\Users\Gersi\.config\powershell\local_funcs.ps1"
# Alias
Set-Alias vim nvim
Set-Alias l ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\brin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias j z
Set-Alias touch New-Item
Set-Alias ex explorer
Set-Alias e launchExplorerInCurrentDir
Set-Alias c launchCodeInCurrentDir
## Which command equiv
Set-Alias which Get-Command
## Command to power off the PC
Set-Alias off shut_down_pc
Set-Alias replaceAHK 'C:\Users\Gersi\Desktop\AHKScripts\replaceAhkScript.ps1'
Set-Alias v nvim
Set-Alias nap sleep_pc
