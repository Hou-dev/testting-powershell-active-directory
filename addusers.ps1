# Import AD Module
Import-Module ActiveDirectory

$filepath = Read-Host -Prompt "Please enter the path of CSV"

#Import the CSV as an array
$users = Import-Csv $filepath
#complete action for each user in csv
ForEach ($user in $users){
    $accoutNumber = verifyUsername($user.'First Name'[0]  + $user.'Last Name')
    $username = ($user.'First Name'[0]  + $user.'Last Name' + $accoutNumber)
    
    New-ADUser `
        -Name($user.'First Name' + " " + $user.'Last Name' + " " + $accoutNumber) `
        -GivenName $user.'First Name' `
        -Surname $user.'Last Title' `
        -UserPrincipalName $username `
        -SamAccountName $username `
        -AccountPassword (ConvertTo-SecureString "P@SSWORD123" -AsPlainText -Force) `
        -Description $user.Description `
        -EmailAddress $user.'Email Address' `
        -Title $user.'Job Title' `
        -OfficePhone $user.'Office Phone' `
        -Path $user.'Organizational Unit' `
        -ChangePasswordAtLogon 1 `
        -Enabled ([System.Convert]::ToBoolean($user.Enabled))
}


#See if username is already in use and add a number if it is
function verifyUsername($username){
    $i = 1
    #Check taken status
    if(userNameTaken($username) -eq $True){
        while(userNameTaken($username + $i) -eq $True){
            $i++
        }
     } else {
         reutrn ""
     }
     return $i
}

#Check duplicates usernames
function userNameToken($username){
    $test1 = Get-ADUser -Filter { userPrincipalNamer -eq $username}
    $test2 = Get-ADUser -Filter { samAccountNamer -eq $username}

    if($test1 -eq $null -and $test2 -eq $null){
        return $False
    }else{
        return $True
    }
}

