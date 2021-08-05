$Source = "g:\Backup\INSTAGRAMBACKUP\"
$Destination = "g:\Backup\InstagramBackupOrganized"

$Folders = Get-ChildItem -Path $Source -Directory -Recurse -Filter "20*"
$TotalFoldersCount = $Folders.Count
$FoldersCopied = 0
$FilesCount = 0

#loop though files

foreach ($Folder in $Folders) {
    
    $Files = Get-ChildItem -Path $Folder.FullName -Recurse
    #Write-Output $Files
    
    #ShowProgress of Copying Files
    $FoldersCopied++

    $Percentage = (($FoldersCopied/$TotalFoldersCount)*100) 
    Write-Progress -Activity "Copying Files..." -Status ("Copied {0} of {1} Folders" -f $FoldersCopied, $TotalFoldersCount) -PercentComplete $Percentage


     #genereat new directory name
     #exmaple D:\DestanationFolder\2021
        $NewDir = "{0}\{1}" -f
            $Destination,
            $Folder.Name.Substring(0,4)

        if (!(Test-Path -Path $NewDir)){
        New-Item -Path $NewDir -ItemType Directory -Force
        }

    foreach ($File in $Files) {

    $FilesCount++

     #genereat File Name
     #exmaple D:\DestanationFolder\2021\IMG_202101_1.jpg
        $NewFileName = "{0}\IMG_{1}_{2}{3}" -f
            $NewDir,
            $Folder.Name.Substring(0,6),
            $FilesCount,
            $File.Extension
    Move-Item -Path $File.FullName -Destination $NewFileName -Force


    }

}
