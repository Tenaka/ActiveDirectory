Get-ADUser -ldapfilter '(&(!lastlogontimestamp=*)(!useraccountcontrol:1.2.840.113556.1.4.803:=2))' |
 Select Name,DistinguishedName

 Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true)} | Select Name,DistinguishedName


$createdtime = (Get-Date).Adddays(-(30))
Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true) -and (whencreated -lt $createdtime)} | 
Select Name,DistinguishedName |
Export-CSV "C:\NeverLoggedOnUsers.csv" -NoTypeInformation -Encoding UTF8



Get-ADUser -Filter { Enabled -eq $True } -Properties LastLogonDate |
Where-Object { $_.LastLogonDate -lt (Get-Date).AddDays(-60) -or -not $_.LastLogonDate } |
Select-Object -Property SamAccountName 
 

