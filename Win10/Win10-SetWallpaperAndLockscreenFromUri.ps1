####------------------------------------------------------------------------####
#### Script to download and set the Lockscreen and Wallpaper for the user
#### Can be deployed on Win10 Pro  - also via Intune
#### Based upon the script located here: https://abcdeployment.wordpress.com/2017/04/20/how-to-set-custom-backgrounds-for-desktop-and-lockscreen-in-windows-10-creators-update-v1703-with-powershell/
####
#### Editor info: Geir Dybbugt - https://dybbugt.no
####------------------------------------------------------------------------####

# Parameters for source and destination for the Image file
# Current script is edited to put the same image on LockScreen and Wallpaper

$WallpaperURL = "https://drive.google.com/file/d/1SihTUvD4ukAJkxdmq7tVS4mswzNf6Pa3/view?usp=sharing" # Change to your fitting
$LockscreenUrl = "https://drive.google.com/file/d/1T8Y5N270yt12wFDMDSpO5ibhZWSGUZ4c/view?usp=sharing" # Change to your fitting

$ImageDestinationFolder = "C:\Windows\Web\Wallpaper" # Change to your fitting - this is the folder for the wallpaper image
$WallpaperDestinationFile = "$ImageDestinationFolder\wallpaper.png" # Change to your fitting - this is the Wallpaper image
$LockScreenDestinationFile = "$ImageDestinationFolder\LockScreen.png" # Change to your fitting - this is the Lockscreen image

# Creates the destination folder on the target computer
md $ImageDestinationFolder -erroraction silentlycontinue

# Downloads the image file from the source location
Start-BitsTransfer -Source $WallpaperURL -Destination "$WallpaperDestinationFile"
Start-BitsTransfer -Source $LockscreenUrl -Destination "$LockScreenDestinationFile"

# Assigns the wallpaper 
$RegKeyPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP'

$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$LockScreenPath = "LockScreenImagePath"
$LockScreenStatus = "LockScreenImageStatus"
$LockScreenUrl = "LockScreenImageUrl"

$StatusValue = "1"
$DesktopImageValue = "$WallpaperDestinationFile"  
$LockScreenImageValue = "$LockScreenDestinationFile"

IF(!(Test-Path $RegKeyPath))

{

New-Item -Path $RegKeyPath -Force | Out-Null

New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $StatusValue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null

}

ELSE {

New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $Statusvalue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $value -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
}


# Restart explorer.exe
    stop-process -name explorer –force

# Clears the error log from powershell before exiting
    $error.clear()
