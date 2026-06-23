# Roadmap Flutv

Plan de développement de l'application Flutv, organisé en phases incrémentales. Chaque phase produit une version fonctionnelle de l'app.

## Phase 0 — Scaffold (terminé)

- [x] `flutter create` Android uniquement
- [x] README.md et ROADMAP.md initiaux

## Phase 1 — Fondations (terminé)

Objectif : projet prêt à coder, avec thème et navigation en place.

- [x] Ajouter les dépendances dans `pubspec.yaml` :
  - `flutter_riverpod`, `go_router`, `dio`, `hive`, `hive_flutter`
  - `media_kit`, `media_kit_video`, `media_kit_libs_android_video`
  - `cached_network_image`, `freezed_annotation`, `json_annotation`
  - dev : `build_runner`, `freezed`, `json_serializable`
- [x] Configurer `android/app/build.gradle` : minSdk 21, permission `INTERNET`
- [x] Créer la structure de dossiers `lib/core` + `lib/features/*`
- [x] Thème clair Material 3 avec accent bleu (`#2563EB`)
- [x] Configurer `go_router` avec routes : `/`, `/player/:id`, `/search`, `/favorites`
- [ ] Splash screen et icône d'app *(reporté en Phase 5)*

## Phase 2 — Couche données (terminé)

Objectif : récupérer les chaînes françaises et leurs flux.

- [x] Modèles `Channel`, `StreamLink`, `Category`, `Country`, `ChannelView` (freezed + JSON)
- [x] `IptvOrgClient` (dio) avec endpoints channels/streams/categories/countries
- [x] Cache Hive 24h des métadonnées (`CacheStore`)
- [x] Repository qui fusionne channels + streams + filtre `country == FR` ou `languages.contains('fra')`
- [x] Providers Riverpod : `channelsProvider`, `categoriesProvider`, `channelsByCategoryProvider`
- [x] Gestion erreur réseau + loader (`IptvFailure`, `AsyncValueView`)

## Phase 3 — Accueil et navigation (terminé)

Objectif : naviguer dans le catalogue.

- [x] Bottom navigation : Accueil / Recherche / Catégories / Favoris *(posé en Phase 1)*
- [x] Écran Accueil :
  - Hero carousel auto-scroll (chaînes vedettes)
  - Rails horizontaux par catégorie (Info, Sport, Cinéma, Jeunesse, Divertissement)
  - Card chaîne avec logo + nom (animation scale au tap)
- [x] Écran Catégories : grille des catégories disponibles + écran détail filtré
- [x] Écran Recherche : `TextField` + filtrage live (debounced) sur le nom
- [x] Hero animation entre tuile et écran lecteur (tag scopé par source)

## Phase 4 — Lecteur vidéo (terminé)

Objectif : lire les flux HLS/TS de manière fiable.

- [x] Écran `PlayerScreen` avec `media_kit`
- [x] Contrôles overlay custom : play/pause, mute, fullscreen, indicateur live
- [x] Gestion orientation : portrait par défaut, paysage en fullscreen
- [x] Gestes : double-tap pour fullscreen, swipe vertical pour volume
- [x] Gestion erreur de flux (stream indisponible → message + retour)
- [x] Indicateur de buffering
- [x] Garder l'écran allumé pendant la lecture (`wakelock_plus`)

## Phase 5 — Favoris et polish

Objectif : finaliser l'expérience utilisateur.

- [ ] Boîte Hive `favorites` (liste d'IDs de chaînes)
- [ ] Bouton cœur sur chaque card + détail
- [ ] Écran Favoris listant les chaînes sauvegardées
- [ ] Pull-to-refresh sur l'accueil
- [ ] Skeleton loaders (shimmer) pendant le chargement
- [ ] Animations de transition affinées
- [ ] Mode hors-ligne : afficher cache + message si pas de réseau
- [ ] Icône d'app et splash screen personnalisés

## Phase 6 — EPG (futur)

Objectif : guide TV intégré.

- [ ] Parser XMLTV depuis `iptv-org/epg`
- [ ] Stockage Hive des programmes
- [ ] Affichage "En cours / À suivre" sur chaque card
- [ ] Écran guide TV par chaîne (timeline horizontale)

## Idées hors-scope initial

- Cast vers Chromecast (`flutter_cast_video`)
- Picture-in-Picture
- Téléchargement pour visionnage hors-ligne (pas adapté au live)
- Compte utilisateur + sync cloud des favoris
- Support tablette / Android TV
- Recommandations basées sur l'historique

## Conventions

- Commits : style conventionnel (`feat:`, `fix:`, `chore:`, `refactor:`)
- Branches : `main` stable, `feat/*` pour les fonctionnalités
- Code : `dart format` + `flutter analyze` sans warnings avant commit
