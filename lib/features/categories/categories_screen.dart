import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/async_value_view.dart';
import '../channels/data/models/category.dart';
import '../channels/providers/channels_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Catégories')),
      body: AsyncValueView<List<Category>>(
        value: categories,
        loadingMessage: 'Chargement des catégories…',
        onRetry: () => ref.invalidate(categoriesProvider),
        data: (list) => _CategoryGrid(categories: list),
      ),
    );
  }
}

class _CategoryGrid extends ConsumerWidget {
  const _CategoryGrid({required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grouped = ref.watch(channelsByCategoryProvider);
    final available = categories
        .where((c) => (grouped[c.id]?.isNotEmpty ?? false))
        .toList();
    if (available.isEmpty) {
      return Center(
        child: Text(
          'Aucune catégorie disponible.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: available.length,
      itemBuilder: (context, i) {
        final cat = available[i];
        final count = grouped[cat.id]?.length ?? 0;
        return Card(
          margin: EdgeInsets.zero,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.push('/category/${cat.id}', extra: cat.name),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  const Icon(Icons.label_rounded),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cat.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$count chaîne${count > 1 ? 's' : ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
