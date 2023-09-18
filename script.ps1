
# function to get pc info
function get_pc_info {
    $manufacturer = (Get-WmiObject win32_bios | select Manufacturer | Format-Table -HideTableHeaders | Out-String).Trim()
    $model = (Get-CimInstance Win32_ComputerSystemProduct | Select Name | Format-Table -HideTableHeaders | Out-String).Trim()
    $serial = (Get-WmiObject win32_bios | select Serialnumber | Format-Table -HideTableHeaders | Out-String).Trim()

    $result = "Manufacturer : $($manufacturer)`nModel        : $($model)`nSerial Number: $($serial)`n------------------------------"
                
    return $result
}

# function to get user info
function get_userinfo {
    $username = ($Env:UserName).Trim()
    $domain = ($Env:UserDomain).Trim()
    $pcname = ($Env:ComputerName).Trim()

    $result = "Username     : $($username)`nPCName       : $($pcname)`nDomain       : $($domain)`n"

    return $result

}

# function to get monitors info
function get_monitors_info {
    function Decode {
        If ($args[0] -is [System.Array]) {
            [System.Text.Encoding]::ASCII.GetString($args[0])
        }
        Else {
            "Not Found"
        }
    }

    ForEach ($Monitor in Get-WmiObject WmiMonitorID -Namespace root\wmi) {  
        $Manufacturer = Decode $Monitor.ManufacturerName -notmatch 0
        $Name = Decode $Monitor.UserFriendlyName -notmatch 0
        $Serial = Decode $Monitor.SerialNumberID -notmatch 0
        
        echo "Manufacturer : $($Manufacturer)`nModel        : $($Name)`nSerial Number: $($Serial)`n"
    }
}

function time_f {
    return Get-Date -Format "dd/MM/yyyy HH:mm:ss"
}
