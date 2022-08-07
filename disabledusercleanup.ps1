# import the AD module
Import-Module ActiveDirectory

# list all disabled AD users
Search-ADAccount -AccountDisabled | Select-Object Name, DistinguishedName

#move all disabled AD users to disabled users OU
Search-ADAccount -AccountDisabled | where {$_.DistinguishedName -notlike "*disabled users*"}| Move-ADObject -TargetPath "OU=disabled users,OU=instructorpaul,DC=itflee,DC=com"

#Disabled all users in disabled OU
Get-ADUser -Filter {Enabled -eq $True} -SearchBase "OU=disabled users,OU=instructorpaul,DC=itflee,DC=com" | Disable-ADAccount