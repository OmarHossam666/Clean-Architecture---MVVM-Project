import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

/// A shimmer effect skeleton loader widget for loading states.
/// Provides a better UX than simple spinners by showing content placeholders.
class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = ValuesManager.radius8,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                ColorsManager.shimmerBase,
                ColorsManager.shimmerHighlight,
                ColorsManager.shimmerBase,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// A skeleton card widget for loading card-like content
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
    this.width = double.infinity,
    this.height = ValuesManager.height140,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ValuesManager.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonLoader(
              width: width,
              height: height * 0.6,
              borderRadius: ValuesManager.radius8,
            ),
            const SizedBox(height: ValuesManager.spacing8),
            SkeletonLoader(width: width * 0.7, height: ValuesManager.spacing16),
            const SizedBox(height: ValuesManager.spacing4),
            SkeletonLoader(width: width * 0.5, height: ValuesManager.spacing12),
          ],
        ),
      ),
    );
  }
}

/// A skeleton list tile widget for loading list items
class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ValuesManager.padding16,
        vertical: ValuesManager.padding8,
      ),
      child: Row(
        children: [
          const SkeletonLoader(
            width: ValuesManager.iconSize48,
            height: ValuesManager.iconSize48,
            borderRadius: ValuesManager.radius24,
          ),
          const SizedBox(width: ValuesManager.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: ValuesManager.spacing16,
                ),
                const SizedBox(height: ValuesManager.spacing8),
                SkeletonLoader(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: ValuesManager.spacing12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A skeleton loader for banner/carousel items
class SkeletonBanner extends StatelessWidget {
  const SkeletonBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ValuesManager.padding16),
      child: SkeletonLoader(
        width: double.infinity,
        height: ValuesManager.height140,
        borderRadius: ValuesManager.radius16,
      ),
    );
  }
}

/// A skeleton grid for loading grid-like content
class SkeletonGrid extends StatelessWidget {
  const SkeletonGrid({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 4,
    this.childAspectRatio = 1.0,
  });

  final int crossAxisCount;
  final int itemCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: ValuesManager.spacing8,
        crossAxisSpacing: ValuesManager.spacing8,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const SkeletonLoader(
          width: double.infinity,
          height: double.infinity,
          borderRadius: ValuesManager.radius16,
        );
      },
    );
  }
}
