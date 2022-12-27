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
{ Stop-Computer -Force 
}
function sleep_pc
{
    Add-Type -AssemblyName System.Windows.Forms
    $PowerState = [System.Windows.Forms.PowerState]::Hibernate;
    $Force = $true;
    $DisableWake = $false;
    # The following function takes (State, Force, DisableWake) as parameters
    [System.Windows.Forms.Application]::SetSuspendState($PowerState, $Force, $DisableWake);
}
