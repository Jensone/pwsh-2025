# PSEUDO-CODE (Dis-Siren)

# Initialisation
DÉFINIR nombreTentatives = 0
DÉFINIR délaiAttente = 3 # en secondes
DÉFINIR urlAPI = "https://recherche-entreprises.api.gouv.fr/search?q="

# Fonction principale Get-CompanyInfo
DÉBUT FONCTION Get-CompanyInfo

    # Validation du SIREN
    RÉCUPÉRER le numéro SIREN
    
    SI le numéro SIREN est vide
        ALORS afficher "Veuillez entrer un numéro SIREN"
        RETOURNER erreur
    FIN SI

    SI le numéro SIREN n'est pas composé de 9 chiffres
        ALORS afficher "Le numéro SIREN doit contenir 9 chiffres"
        RETOURNER erreur
    FIN SI

    SI le numéro fourni commence par le caractère "0"
        ALORS afficher "Le numéro SIREN ne peut pas commencer par 0"
        RETOURNER erreur
    FIN SI

    # Préparation de la requête
    CONCATENER urlAPI avec le numéro SIREN

    # Vérification de la connexion
    SI l'utilisateur n'est pas connecté à internet
        ALORS afficher "Erreur: Pas de connexion Internet"
        RETOURNER erreur
    SINON
        # Gestion des tentatives de requête
        TANT QUE nombreTentatives < 2
            INCRÉMENTER nombreTentatives
            LANCER "Get-Siren"
            
            SI la réponse est valide
                ALORS
                    TRAITER la réponse
                    MISE EN FORME des données
                    AFFICHER les informations de l'entreprise
                    RETOURNER succès
            SINON
                SI nombreTentatives < 2
                    ALORS
                        ATTENDRE délaiAttente secondes
                        CONTINUER
                SINON
                    afficher "Échec de la requête après 2 tentatives"
                    RETOURNER erreur
                FIN SI
            FIN SI
        FIN TANT QUE
    FIN SI

FIN FONCTION

AFFICHER "Merci d'avoir utilisé Dis-Siren, à bientôt !"