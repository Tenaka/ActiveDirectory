$Root = [ADSI]"LDAP://RootDSE"
$rootdse = $Root.rootDomainNamingContext

$adGroups = 
"Administrators",
“Backup Operators”,
“Server Operators”,
“Account Operators”,
“Guests”,
“Domain Admins”
“Schema Admins”,
“Enterprise Admins”,
“DnsAdmins”,
“DHCP Administrators”,
“Domain Guests”

$fragDomainGrps=@()

foreach ($adGroup in $adGroups)
{
    try
    {    
        $gpName = [ADSI]"LDAP://CN=$adGroup,CN=Users,$($rootdse)"
        $gpMembers = $gpName.Member    
        $ArgpMem=@()
        if($gpMembers -ne $null)
        {  
        foreach ($gpMem in $gpMembers)
            {
            write-host $gpMem -ForegroundColor Yellow 
            $gpSting = $gpMem.ToString().split(",").replace("CN=","")[0]
            $ArgpMem += $gpSting


            }
            $joinMem = $ArgpMem -join ", "

            $newObjDomainGrps = New-Object -TypeName PSObject
            Add-Member -InputObject $newObjDomainGrps -Type NoteProperty -Name GroupName -Value $adGroup
            Add-Member -InputObject $newObjDomainGrps -Type NoteProperty -Name GroupMembers -Value $joinMem 
            $fragDomainGrps += $newObjDomainGrps   
        }
    }
finally
    {
        $gpName = [ADSI]"LDAP://CN=$adGroup,CN=builtin,$($rootdse)"
        $gpMembers = $gpName.Member   
        $ArgpMem=@()
                if($gpMembers -ne $null)
        {  
        foreach ($gpMem in $gpMembers)
            {
            write-host $gpMem -ForegroundColor Yellow 
            $gpSting = $gpMem.ToString().split(",").replace("CN=","")[0]
            $ArgpMem += $gpSting


            }
            $joinMem = $ArgpMem -join ", "

            $newObjDomainGrps = New-Object -TypeName PSObject
            Add-Member -InputObject $newObjDomainGrps -Type NoteProperty -Name GroupName -Value $adGroup
            Add-Member -InputObject $newObjDomainGrps -Type NoteProperty -Name GroupMembers -Value $joinMem 
            $fragDomainGrps += $newObjDomainGrps   
        }
    }

}


