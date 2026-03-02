# Projet Docker - Todo App

Application web Symfony affichant une liste de todos stockés dans une base de données PostgreSQL.
Chaque todo possède un identifiant, un titre et un statut (fait / à faire).

## Architecture

Trois services indépendants, chacun avec son propre 'Dockerfile' basé sur une image alpine :

Les services Symfony et Adminer s'attachent au réseau 'symfony_network' créé par le compose de la BDD ('external: true').

## Docker Compose séparés

Conformément aux consignes, Symfony et la BDD sont sur des fichiers 'docker-compose' distincts :

- 'bdd/compose.yaml' — crée le réseau 'symfony_network' et démarre PostgreSQL
- 'symfony/compose.yml' — démarre Symfony, rejoint le réseau existant
- 'adminer/compose.yaml' — démarre Adminer, rejoint le réseau existant

## Images custom

### PostgreSQL ('bdd/')

- Base : 'alpine:3.19', PostgreSQL installé manuellement via 'apk'
- Les variables 'POSTGRES_USER', 'POSTGRES_PASSWORD', 'POSTGRES_DB' sont lues dans "docker-entrypoint.sh" pour créer la base et l'utilisateur au premier démarrage
- Le script 'init-scripts/01-init-db.sql' crée la table 'todo' et insère 10 lignes

### Symfony ('symfony/')

- Multi-stage build :
  - **Stage 1** ('projet-composer') : 'php:8.2-alpine', installe Composer depuis l'installeur officiel via 'curl'
  - **Stage 2** : 'php:8.2-cli-alpine', installe les extensions PHP nécessaires ('pdo_pgsql', 'gd', 'intl', etc.), copie le binaire Composer du stage précédent, puis installe les dépendances via 'composer install'
- Le contrôleur 'TodoController' se connecte à PostgreSQL via PDO et expose l'endpoint '/'
- La vue Twig affiche les todos dans un tableau HTML

### Adminer ('adminer/')

- Base : 'alpine:3.19'
- Téléchargement de l'archive PHP d'Adminer depuis GitHub via 'wget'
- Serveur intégré PHP lancé directement ('php82 -S')

## Lancement

'''bash

# 1. Démarrer la BDD (crée aussi le réseau)

cd bdd && docker compose up -d

# 2. Démarrer Symfony

cd ../symfony && docker compose up -d

# 3. (Optionnel) Démarrer Adminer

cd ../adminer && docker compose up -d
'''

- Application : http://localhost:8000
- Adminer : http://localhost:8080 (serveur 'postgres', base 'symfony_db', user 'symfony_user')

### Collaborateurs :

- Ilian Igoudgil
- Noan Delatouche
