# Call API avec PowerShell

Dans cette exercice, nous allons communiquer avec une API en utilisant PowerShell. Pour ce faire, nous allons utiliser l'API de [API Entreprise](https://recherche-entreprises.api.gouv.fr/). Cette API permet de récupérer des informations sur les pays du monde.

https://recherche-entreprises.api.gouv.fr/search?q=XXXXXX

## Objectifs

Créer un programme en PowerShell qui permet de récupérer les informations suivantes sur une entreprise donnée.

-   nom_raison_sociale
-   adresse
-   code_postal
-   date_creation
-   libelle_commune
-   activite_principale

Ces informations devront être insérée dans un fichier .html qui contiendra le code HTML suivant :

```html
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Informations sur l'entreprise</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"/>
    </head>
    <body>
        <h1>Informations sur l'entreprise</h1>
        <ul>
            <li>Nom raison sociale: $nom_raison_sociale</li>
            <li>Adresse: $adresse</li>
            <li>Code postal: $code_postal</li>
            <li>Date creation: $date_creation</li>
            <li>Libelle commune: $libelle_commune</li>
            <li>Activite principale: $activite_principale</li>
        </ul>
    </body>
</html>
```
---

## Étapes

1. Créer un algorigramme pour le programme
2. Rédiger le pseudo-code du programme
3. Implémenter le programme en PowerShell
4. Tester le programme avec un numéro siren de votre choix