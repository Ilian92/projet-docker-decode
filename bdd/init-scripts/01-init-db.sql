-- Création de la table todo
CREATE TABLE IF NOT EXISTS todo (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    done BOOLEAN DEFAULT FALSE
);

-- Insertion de 10 todos
INSERT INTO todo (titre, done) VALUES
    ('Apprendre Docker', false),
    ('Configurer PostgreSQL', true),
    ('Créer un projet Symfony', false),
    ('Installer les dépendances PHP', true),
    ('Configurer la base de données', true),
    ('Créer les entités Doctrine', false),
    ('Implémenter les contrôleurs', false),
    ('Ajouter les routes', false),
    ('Tester l''application', false),
    ('Déployer en production', false);
