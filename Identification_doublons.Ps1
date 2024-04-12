# Récupérez tous les utilisateurs dans Active Directory
$utilisateurs = Get-ADUser -Filter * | Select-Object "Nom", "Nom_de_domaine"

# Identifiez les doublons
$doublons = $utilisateurs | Group-Object -"Le_nom_du_groupe" "Nom_de_domaine" | Where-Object { $_.Count -gt 1 }

# Affichez les utilisateurs
Write-Host "Utilisateurs :"
$utilisateurs | Format-Table -AutoSize

# Affichez les doublons
if ($doublons) {
    Write-Host "`nDoublons :"
    $doublons | ForEach-Object {
        $_.Group | Format-Table -AutoSize
        Write-Host "Nombre de doublons : $($_.Count)`n"
    }
} else {
    Write-Host "Aucun doublon trouvé."
}