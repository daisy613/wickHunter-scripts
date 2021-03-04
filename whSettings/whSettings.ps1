### author's discord: Daisy#2718
### this script exports/imports WickHunter settings

write-host "`n"
write-host "======= Daisy's WH Settings Export/Import Script =======" -f "Cyan"

if(!(Get-Module -name "PSSQLite")) {
    Install-Module PSSQLite
    Import-Module PSSQLite
}

write-host "WARNING: Please pause your bot and exit it before proceeding!" -f "Magenta"
do {
    $mode = Read-Host -Prompt "Select Mode (1 for export, 2 for import)"
} while ($mode -ne "1" -and $mode -ne "2")

function getFileName () {
    param($message,$type)
    write-host $message -f "Yellow"
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $FileBrowser.filter = "$($type) | *.$($type)"
    [void]$FileBrowser.ShowDialog()
    return $FileBrowser.FileName
}

if ($mode -eq "1") {
    ### query user for the location of WH storage db:
    $dataSource   = getFileName "Please select the storage.db file that contains the settings to export." "db"
    write-host "DB File: $($dataSource)" -f "Green"
    $settingsFile = (Split-Path $dataSource) + "\settingsExport.json"

    ### export settings to file
    $object = [PSCustomObject]@{
        ApiSettings          = Invoke-SqliteQuery -DataSource $dataSource -Query "SELECT * FROM ApiSettings"
        DcaSettings          = Invoke-SqliteQuery -DataSource $dataSource -Query "SELECT * FROM DcaSettings"
        DiscordNotifications = Invoke-SqliteQuery -DataSource $dataSource -Query "SELECT * FROM DiscordNotifications"
        Instrument           = Invoke-SqliteQuery -DataSource $dataSource -Query "SELECT * FROM Instrument"
        StrategySettings     = Invoke-SqliteQuery -DataSource $dataSource -Query "SELECT * FROM StrategySettings"
    }
    if (test-path $settingsFile) { cp $settingsFile ($settingsFile + ".bak") -Confirm:$false -force }
    if ($object) {
        ($object | ConvertTo-Json) | sc $settingsFile -force
        write-host "Settings exported to $($settingsFile)" -f "Green"
    }
    else { write-host "Found no settings data to export! Try again please." -f "Red" ; sleep 3 ; exit}
}

if ($mode -eq "2") {
    ### query user for the location of the settingsExport file:
    $settingsFile = getFileName "Please select the settingsExport.json file that contains the settings to import." "json"
    write-host "Settings File: $($settingsFile)" -f "Green"
    $dataSource   = getFileName "Please select the storage.db file that contains the settings to export." "db"
    write-host "DB File: $($dataSource)" -f "Green"

    ### import settings from file
    $object = (gc $settingsFile | ConvertFrom-Json)

    write-host "Backing up your current WH storage.db..." -f "Yellow"
    cp $dataSource "$($dataSource).bak" -force

    $query = 'DROP TABLE IF EXISTS "DcaSettings"; CREATE TABLE IF NOT EXISTS "DcaSettings" ( "Batch" TEXT NOT NULL, "Symbol" TEXT NOT NULL, "Range" INTEGER NOT NULL, "PercentFromAverage" NUMBER NOT NULL, "PercentBuy" NUMBER NOT NULL, "NumberOfBuys" NUMBER NOT NULL, "PercentTakeProfit" NUMBER NOT NULL ); DROP TABLE IF EXISTS "ApiSettings"; CREATE TABLE IF NOT EXISTS "ApiSettings" ( "IsReal" INTEGER NOT NULL, "RealApiKey" TEXT NOT NULL, "RealApiSecret" TEXT NOT NULL, "TestnetApiKey" TEXT NOT NULL, "TestnetApiSecret" TEXT NOT NULL ); DROP TABLE IF EXISTS "Instrument"; CREATE TABLE IF NOT EXISTS "Instrument" ( "Symbol" TEXT NOT NULL, "IsPermitted" INTEGER NOT NULL, "IsNonDeaultSettigs" INTEGER NOT NULL) ; DROP TABLE IF EXISTS "StrategySettings"; CREATE TABLE IF NOT EXISTS "StrategySettings" ( "Batch" TEXT NOT NULL, "Symbol" TEXT NOT NULL, "PercentBuy" NUMBER NOT NULL, "Margin" TEXT NOT NULL, "Leverage" INTEGER NOT NULL, "PercentTakeProfit" NUMBER NOT NULL, "LiquidationSize" NUMBER NOT NULL, "LongVWAPPercent" NUMBER NOT NULL, "ShortVWAPPercent" NUMBER NOT NULL, "MaxPairOpen" INTEGER NOT NULL, "MaxAllocationPerPair" NUMBER NOT NULL, "IsolationMode" NUMBER NOT NULL, "StopLoss" NUMBER NOT NULL, "MinVolume" NUMBER NOT NULL, "MaxVolume" NUMBER NOT NULL, "VwapTimeFrame" TEXT NOT NULL, "VwapPeriod" INTEGER NOT NULL ); DROP TABLE IF EXISTS "DiscordNotifications"; CREATE TABLE IF NOT EXISTS "DiscordNotifications" ( "WebHookAddress" TEXT NOT NULL, "TradeOpenedNotification" INTEGER NOT NULL, "DCABuysNotification" INTEGER NOT NULL, "TradeClosedNotification" INTEGER NOT NULL, "IsolationModeEngagedNotification" INTEGER NOT NULL, "MaxAllocationOnPairNotification" INTEGER NOT NULL, "MaterialErrorNotification" INTEGER NOT NULL ); '
    if ($object) { Invoke-SqliteQuery -DataSource $dataSource -Query $query }
    else { write-host "Found no settings data to import! Try again please." -f "Red" ; sleep 3 ; exit}

    $props = $object.PSObject.Properties.name
    foreach ($item in $props) {
        Invoke-SQLiteBulkCopy -DataTable ($object.$item |  Out-DataTable) -DataSource $dataSource -Table $item -NotifyAfter 1000 -Confirm:$false
    }
    write-host "Settings imported to $($dataSource)" -f "Green"
}
