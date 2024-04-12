# Spécifiez le nombre de jours pour déterminer l'inactivité
$nbJoursInactivite = 90 

# Obtenez la date actuelle
$dateActuelle = Get-Date

# Calculez la date à laquelle les utilisateurs sont considérés comme inactifs
$dateInactivite = $dateActuelle.AddDays(-$nbJoursInactivite)

# Récupérez les utilisateurs inactifs dans Active Directory
$utilisateursInactifs = Get-ADUser -Filter {LastLogonTimeStamp -lt $dateInactivite} -Properties LastLogonTimeStamp | Select-Object Name, SamAccountName, LastLogonTimeStamp

# Affichez les utilisateurs inactifs
$utilisateursInactifs | Format-Table -AutoSize