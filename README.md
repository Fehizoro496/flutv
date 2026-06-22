# Flutv

Application Android de streaming TV en direct, inspirée de MyCanal, alimentée par les playlists publiques de [iptv-org](https://github.com/iptv-org/iptv).

Conçue pour les chaînes francophones, avec un design clair et moderne (accent bleu).

## Fonctionnalités prévues

- Catalogue de chaînes TV françaises chargé dynamiquement depuis l'API iptv-org
- Navigation par catégories (Sport, Info, Cinéma, Jeunesse, etc.)
- Lecteur vidéo natif avec contrôles personnalisés (HLS, MPEG-TS)
- Recherche de chaînes
- Favoris stockés en local
- Design clair avec accent bleu, animations fluides
- EPG (guide TV) — phase ultérieure

## Stack technique

| Domaine | Choix |
|---|---|
| Framework | Flutter 3.41 / Dart 3.11 |
| Plateforme | Android uniquement (min SDK 21) |
| State management | Riverpod 2 |
| Navigation | go_router |
| Lecteur vidéo | media_kit (libmpv) |
| HTTP | dio |
| Cache images | cached_network_image |
| Stockage local | Hive |

## Sources de données

L'application consomme l'API JSON publique d'iptv-org :

- `https://iptv-org.github.io/api/channels.json` — métadonnées des chaînes
- `https://iptv-org.github.io/api/streams.json` — URLs des flux
- `https://iptv-org.github.io/api/categories.json` — catégories
- `https://iptv-org.github.io/api/countries.json` — pays

Filtrage côté client sur `country = FR` et `languages = fra`.

## Démarrage

```bash
cd flutv
flutter pub get
flutter run
```

## Structure prévue du projet

```
lib/
  core/        # client API, parser M3U, theme, constants
  features/
    channels/  # modèles, repository, providers
    home/      # accueil avec rails par catégorie
    player/    # écran lecteur media_kit
    search/    # recherche
    favorites/ # favoris locaux
  app.dart
  main.dart
```

## Statut

Phase 1 : scaffold initial. Voir [ROADMAP.md](./ROADMAP.md) pour le détail.

## Licence

Projet personnel. Les flux IPTV proviennent de sources publiques agrégées par iptv-org.
