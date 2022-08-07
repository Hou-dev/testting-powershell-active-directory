# Import AD Module
Import-Module ActiveDirectory

# Create the AD User
New-ADUser `
    -Name "Bradley Beal" `
    -GivenName "Bradley" `
    -Surname "Beal" `
    -UserPrincipalName "Bradley Beal" `
    -AccountPassword (ConvertTo-SecureString "p@ssw0rd123" -AsPlainText -Force)`
    -Path "OU=domain users,OU=instructorpaul,DC=itflee,DC=com" `
    -ChangePasswordAtLogon 1 `
    -Enabled 1 `
