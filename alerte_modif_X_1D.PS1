# Spécifiez le chemin du fichier à surveiller
$cheminFichier = "C:\chemin\vers\votre\fichier.txt"

# Vérifiez si le fichier existe
if (Test-Path $cheminFichier) {
    # Obtenez les métadonnées du fichier
    $metadonnees = Get-Item $cheminFichier | Select-Object LastWriteTime

    # Obtenez la date actuelle
    $dateActuelle = Get-Date

    # Vérifiez si le fichier a été modifié aujourd'hui
    if ($metadonnees.LastWriteTime.Date -eq $dateActuelle.Date) {
        # Si le fichier a été modifié aujourd'hui, comptez les modifications
        $modifications = (Get-Content $cheminFichier).Length

        # Si plus de trois modifications ont été détectées, envoyez une alerte
        if ($modifications -gt 3) {
            $subject = "Alerte : Plus de 3 modifications détectées sur $cheminFichier"
            $body = "Plus de 3 modifications ont été détectées sur $cheminFichier aujourd'hui.`n`n"
            $body += "Nombre de modifications : $modifications`n"
            $body += "Dernière modification : $($metadonnees.LastWriteTime)`n"

            # Envoyez l'e-mail de notification (vous devrez remplacer les détails SMTP par les vôtres)
            Send-MailMessage -To "votre@email.com" -From "alertes@email.com" -Subject $subject -Body $body -SmtpServer "smtp.example.com"
        }
    }
} else {
    Write-Host "Le fichier $cheminFichier n'existe pas."
}