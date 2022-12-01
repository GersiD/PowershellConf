# Prompt
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Import-Module posh-git
oh-my-posh init pwsh --config 'C:\Users\gersi\scoop\apps\oh-my-posh\current\themes\jandedobbeleer.omp.json' | Invoke-Expression

# Imports
Import-Module PSFzf
Import-Module -Name terminal-Icons
Import-Module CompletionPredictor

# Path fixes
$env:Path += ";C:\Program Files\nodejs\"
$env:Path += ";C:\Users\gersi\AppData\Local\Microsoft\WindowsApps\"


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
function time { $Command = "$args"; Measure-Command { Invoke-Expression $Command 2>&1 | out-default} }
function launchExplorerInCurrentDir { explorer . }
function launchCodeInCurrentDir { code . }
function kall { $Command = "$args"; sudo kill -Force -Name $Command }
# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\brin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias j z
Set-Alias touch New-Item
Set-Alias e launchExplorerInCurrentDir
Set-Alias which Get-Command
Set-Alias c launchCodeInCurrentDir
