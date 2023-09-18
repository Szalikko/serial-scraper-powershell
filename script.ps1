

function get_pc_info() {
    $manufacturer = (Get-WmiObject win32_bios | select Manufacturer | Format-Table -HideTableHeaders | Out-String).Trim()
    $model = (Get-CimInstance Win32_ComputerSystemProduct | Select Name | Format-Table -HideTableHeaders | Out-String).Trim()
    $serial = (Get-WmiObject win32_bios | select Serialnumber | Format-Table -HideTableHeaders | Out-String).Trim()

    $result = "Manufacturer : $($manufacturer)`nModel        : $($model)`nSerial       : $($serial)`n"
            
        
    return $result
}