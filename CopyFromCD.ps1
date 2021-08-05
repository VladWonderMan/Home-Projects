#$Source = "D:\"
#$Destination = "G:\Backup\CDBackups"
#$CDcount = 1

Function CopyFromCD ($Source,$Destination,$CDcount) {


while ($true){
    
    $CDname = "CD_"+ $CDcount

    Write-Host 'Press any key to continue...'
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')

    Write-Host "Checking CD..." -ForegroundColor Yellow

    If (!(Test-Path $Source)){
        Write-Host "Please Insert CD..." -ForegroundColor Red
        continue
    }

    # $CDname = Read-Host -Prompt "CD Name"
    
    # if (!$CDname){
    #     continue
    # }
    
    $Percentage = 0
    $FilesCopied = 0

    $FileList = get-childitem $Source | select-object Mode, Name, LastWriteTime -Last 10
    Write-Output $FileList

    Write-Host "Reading List of Files..." -ForegroundColor Yellow
    $Files = Get-ChildItem -Path $Source -Recurse
    $TotalFilesCount = $Files.Count
    
    Write-Host "Copy Started..." -ForegroundColor Yellow

    foreach ($File in $Files) {
        #ShowProgress of Copying Files
        $FilesCopied++
        $Percentage = (($FilesCopied/$TotalFilesCount)*100) 
        Write-Progress -Activity "Copying Files..." -Status ("Copied {0} of {1} Files" -f $FilesCopied, $TotalFilesCount) -PercentComplete $Percentage
        
        $NewDir = "{0}\{1}\" -f
        $Destination,
        $CDname

        $FilePath = $File.Fullname.replace($Source,"")
        $DestanationFile = $NewDir + $FilePath

        if (!(Test-Path -Path $NewDir)){
            $null = New-Item -Path $NewDir -ItemType Directory -Force
        }

       Copy-Item -Path $File.FullName -Destination $DestanationFile -Force
    }

    Write-Host "$CDname successfuly coppied $FileCopied" -ForegroundColor Green
    $CDcount++
}
}
