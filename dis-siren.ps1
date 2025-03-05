# Programme Dis-Siren
# Application de recherche d'entreprises basé sur le numéro SIREN

# Variables
$nombreTentatives = 0
$delaiAttente = 3
$urlAPI = "https://recherche-entreprises.api.gouv.fr/search?q="

Write-Host "
▗▄▄▄ ▗▄▄▄▖ ▗▄▄▖     ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖
▐▌  █  █  ▐▌       ▐▌     █  ▐▌ ▐▌▐▌   ▐▛▚▖▐▌
▐▌  █  █   ▝▀▚▖     ▝▀▚▖  █  ▐▛▀▚▖▐▛▀▀▘▐▌ ▝▜▌
▐▙▄▄▀▗▄█▄▖▗▄▄▞▘    ▗▄▄▞▘▗▄█▄▖▐▌ ▐▌▐▙▄▄▖▐▌  ▐▌
"
Write-Host "beta1.0.0 by @--- • 2025"
Write-Host "Vous pouvez quitter à tout moment avec Ctrl+C"

function Get-CompanyInfo {
    # Validation du SIREN
    Write-Host "Entrez le numéro SIREN de l'entreprise"
    $siren = Read-Host "SIREN (9 chiffres)"

    if ($siren -eq "")
    {
        Write-Host "Veuillez entrer un numéro SIREN"
        Get-CompanyInfo
    }    

    if ($siren.Length -ne 9 -or $siren -notmatch "^[0-9]+$")
    {
        Write-Host "Le numéro SIREN doit contenir 9 chiffres"
        Get-CompanyInfo
    }    
    
    if ($siren.Substring(0, 1) -eq "0")
    {
        Write-Host "Le numéro SIREN ne peut pas commencer par 0"
        Get-CompanyInfo
    }    

    # Préparation de la requête
    $url = $urlAPI + $siren
    $conn = Test-Connection -ComputerName "recherche-entreprises.api.gouv.fr" -Count 1 -Quiet

    if (-not $conn)
    {
        Write-Host "Erreur: Pas de connexion Internet"
    } else {
        # TANT QUE nombreTentatives < 2
        while ($nombreTentatives -lt 2) {
            #INCRÉMENTER nombreTentatives
            $nombreTentatives++

            Write-Host "Récupération des données en cours..."
            
            # Requêtes vers l'API
            $response = Invoke-RestMethod -Method 'Get' -Uri $url 
            
            if ($response.results[0].nom_complet -eq "") {
                Write-Host "Le numéro SIREN n'existe pas"
                Get-CompanyInfo
            }
            
            sleep(3)

            $nom_raison_sociale = $response.results[0].nom_raison_sociale
            $date_creation = $response.results[0].date_creation
            $activite_principale = $response.results[0].activite_principale
            $siret = $response.results[0].siege.siret
            
            $content = @"
| NOM | $nom_raison_sociale |
| SIRET | $siret |
| Date de création | $date_creation |
| Activité principale | $activite_principale |

Recherche effectuée sur le numéro SIREN $siren
"@

            Write-Host $content

            # GENERATION DU DOCUMENT, ENVOI DU MAIL
            $outputFile = "$Env:HOME/Lab/pwsh-2025/output"
            $fileName = $siren + ".txt"
            Write-Host "Le nom du fichier : " $fileName
            $outputFilePath = Join-Path $outputFile -ChildPath $fileName
            $content | Out-File -FilePath $outputFilePath
            Write-Host "Le chemin du fichier : " $outputFilePath
            Write-Host "Merci d'avoir utilisé Dis-Siren, à bientôt !"
            exit
        }
        
        
            
    }


}

Get-CompanyInfo
