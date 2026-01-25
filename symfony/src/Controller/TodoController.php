<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class TodoController extends AbstractController
{
    #[Route('/', name: 'app_todo')]
    public function index(): Response
    {
        try {
            $dsn = $_ENV['DATABASE_URL'] ?? 'postgresql://symfony_user:symfony_password@postgres:5432/symfony_db';

            // Extraire les informations de connexion
            preg_match('/postgresql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)\?/', $dsn, $matches);
            $user = $matches[1] ?? 'symfony_user';
            $password = $matches[2] ?? 'symfony_password';
            $host = $matches[3] ?? 'postgres';
            $port = $matches[4] ?? '5432';
            $dbname = $matches[5] ?? 'symfony_db';

            $pdo = new \PDO(
                "pgsql:host=$host;port=$port;dbname=$dbname",
                $user,
                $password,
                [\PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION]
            );

            $stmt = $pdo->query('SELECT id, titre, done FROM todo ORDER BY id ASC');
            $todos = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\Exception $e) {
            $todos = [];
            $this->addFlash('error', 'Erreur de connexion à la base de données : ' . $e->getMessage());
        }

        return $this->render('todo/index.html.twig', [
            'todos' => $todos,
        ]);
    }
}
