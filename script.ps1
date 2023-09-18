# get pc info
function get_pc_info {
    $manufacturer = (Get-WmiObject win32_bios | Select-Object Manufacturer | Format-Table -HideTableHeaders | Out-String).Trim()
    $model = (Get-CimInstance Win32_ComputerSystemProduct | Select-Object Name | Format-Table -HideTableHeaders | Out-String).Trim()
    $serial = (Get-WmiObject win32_bios | Select-Object Serialnumber | Format-Table -HideTableHeaders | Out-String).Trim()

    $result = "---------- Komputer ----------`nManufacturer : $($manufacturer)`nModel        : $($model)`nSerial Number: $($serial)`n`n------------------------------"
    return $result
}

# get user info
function get_userinfo {
    $username = ($Env:UserName).Trim()
    $domain = ($Env:UserDomain).Trim()
    $pcname = ($Env:ComputerName).Trim()

    $result = "Username     : $($username)`nPCName       : $($pcname)`nDomain       : $($domain)`n"
    return $result

}

# get monitors info
function get_monitors_info {
    function Decode {
        If ($args[0] -is [System.Array]) {
            [System.Text.Encoding]::ASCII.GetString($args[0])
        }
        Else {
            "Not Found"
        }
    }

    Write-Output "---------- Monitory ----------"

    ForEach ($Monitor in Get-WmiObject WmiMonitorID -Namespace root\wmi) {  
        $Manufacturer = Decode $Monitor.ManufacturerName -notmatch 0
        $Name = Decode $Monitor.UserFriendlyName -notmatch 0
        $Serial = Decode $Monitor.SerialNumberID -notmatch 0
        
        $result = "Manufacturer : $($Manufacturer)`nModel        : $($Name)`nSerial Number: $($Serial)`n".Replace("`0", "")
        Write-Output $result
    }
}

# get current time
function time_f {
    Write-Output "------------ Czas ------------"
    Get-Date -Format "dd/MM/yyyy HH:mm:ss"
}

# save all gathered data into output.txt
function output {
    get_pc_info
    get_userinfo
    get_monitors_info
    time_f
}

output | Out-File -FilePath .\output.txt 
Write-Host "OK"
Pause