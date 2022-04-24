    #Pre-Create a computer object in AD prior to running this step

    $username = Read-Host "Enter the Domain Intro account name here eg svc_wks_intro"
    $PlainPassword = Read-Host "Enter the Domain Intro account password here eg Password1234"
    $hn = hostname

    #Domain Name and OU path
    $DomainN = "trg.loc"
    $ouPath = "OU=wks,OU=org,DC=trg,DC=Loc"

    #Secure string for password
    $domPassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

    #Creates username and password credentials
    $credential = New-Object System.Management.Automation.PSCredential ($username,$domPassword)

    Add-Computer -ComputerName $hn -DomainName $DomainN -OUPath $ouPath -Credential $credential -ErrorAction SilentlyContinue

  