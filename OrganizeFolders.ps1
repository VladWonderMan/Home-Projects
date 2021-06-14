$Source = "D:\TestFolder\SFolder"
$Destination = "D:\TestFolder\DFolder"
$UniqNumber = Get-Random -Minimum 1 -Maximum 9999

# retrieve only files from source directory
$Files = Get-ChildItem -File -Path $Source -Recurse
# $Files = Get-ChildItem -Path $Source -Include *.jpg, *.png, *.gif -Recurse

#loop though files

foreach ($File in $Files) {

    

    #genereat new directory name
    #exmaple D:\DestanationFolder\2021
    $NewDir = "{0}\{1}" -f
            $Destination,
            $File.LastWriteTime.Year
    
    $DestFilePath = $NewDir + "\" + $File.Name
    
    if (!(Test-Path -Path $NewDir)){
        New-Item -Path $NewDir -ItemType Directory -Force
    }

    if (!(Test-Path -Path $DestFilePath)){

        Move-Item -Path $File.FullName -Destination $NewDir -Force
        Write-Host "Item Moved from $($File.FullName) to $DestFilePath" 
   }
    elseif ($File.Length -eq ((Get-ChildItem $DestFilePath).Length)){
       
        Write-Host "Duplicate Found with the Same Size (From: $($File.FullName)  To: $DestFilePath)" -ForegroundColor Red 
        # Move-Item -Path $File.FullName -Destination $NewDir -Force
        # Write-Host "Overwritten $DestFilePath" -ForegroundColor Yellow 
        
    }
    else {
        Write-Host "Duplicate Found (From: $($File.FullName)  To: $DestFilePath)" -ForegroundColor Red 
        
		#generate new name 
		#example "D:\DestanationFolder\2021\FileName_34343.jpg"
        $UniqNumber = ++$UniqNumber
        $NewName = "{0}\{1}_{2}{3}" -f
                $NewDir,
                $File.BaseName,
                $UniqNumber,
                $File.Extension
        
        Move-Item -Path $File.FullName -Destination $NewName -Force
        Write-Host "New Name Generated $NewName" -ForegroundColor Yellow
      }
    


}

