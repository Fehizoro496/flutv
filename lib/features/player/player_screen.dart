import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.channelId});

  final String channelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Chaîne $channelId'),
      ),
      body: const Center(
        child: Text(
          'Le lecteur arrivera en Phase 4.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
