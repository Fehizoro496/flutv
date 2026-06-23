sealed class IptvFailure implements Exception {
  const IptvFailure(this.message);
  final String message;

  @override
  String toString() => message;
}

class NetworkFailure extends IptvFailure {
  const NetworkFailure([super.message = 'Pas de connexion. Vérifie ton réseau.']);
}

class TimeoutFailure extends IptvFailure {
  const TimeoutFailure([super.message = 'Le serveur met trop de temps à répondre.']);
}

class ServerFailure extends IptvFailure {
  const ServerFailure(super.message);
}

class ParseFailure extends IptvFailure {
  const ParseFailure([super.message = 'Réponse inattendue du serveur.']);
}
