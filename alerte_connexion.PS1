# Spécifiez l'heure après laquelle vous souhaitez surveiller les connexions (20h)
$heureLimite = "20:00"

# Définissez le chemin du journal des événements de sécurité de Windows
$logPath = "Security"

# Obtenez les événements de connexion après l'heure spécifiée
$events = Get-WinEvent -FilterHashtable @{
    LogName = $logPath
    ID = 4624  # ID d'événement de connexion réussie
    StartTime = (Get-Date).Date
} | Where-Object { $_.TimeCreated.TimeOfDay -ge $heureLimite }

# Si des événements sont trouvés après l'heure spécifiée, envoyez une alerte
if ($events) {
    $subject = "Alerte : Connexions après $heureLimite"
    $body = "Des connexions ont été détectées après $heureLimite :`n`n"
    $body += $events | Select-Object -"le_nom_du_groupe ou objet" TimeCreated, @{Name="Utilisateur"; Expression={$_.Properties[5].Value}} | Format-Table -AutoSize | Out-String

    # Envoyez l'e-mail de notification (vous devrez remplacer les détails SMTP par les vôtres)
    Send-MailMessage -To "votre@email.com" -From "alertes@email.com" -Subject $subject -Body $body -SmtpServer "smtp.example.com"
}