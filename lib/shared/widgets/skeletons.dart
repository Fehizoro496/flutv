import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _Shim extends StatelessWidget {
  const _Shim({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariant,
      highlightColor: AppColors.surface,
      period: const Duration(milliseconds: 1400),
      child: child,
    );
  }
}

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        _Shim(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShimmerBox(width: double.infinity, height: 200, radius: 24),
          ),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < 3; i++) ...[
          _Shim(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ShimmerBox(width: 140, height: 18, radius: 6),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 168,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) => const _Shim(
                child: Column(
                  children: [
                    ShimmerBox(width: 112, height: 112, radius: 18),
                    SizedBox(height: 8),
                    ShimmerBox(width: 80, height: 12, radius: 4),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class GridSkeleton extends StatelessWidget {
  const GridSkeleton({super.key, this.columns = 3, this.tileCount = 9});

  final int columns;
  final int tileCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: tileCount,
      itemBuilder: (_, _) => _Shim(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ShimmerBox(
                width: double.infinity,
                height: double.infinity,
                radius: 18,
              ),
            ),
            const SizedBox(height: 8),
            ShimmerBox(width: 70, height: 12, radius: 4),
          ],
        ),
      ),
    );
  }
}

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemCount: 8,
      itemBuilder: (_, _) => const _Shim(
        child: ShimmerBox(width: double.infinity, height: double.infinity, radius: 16),
      ),
    );
  }
}
