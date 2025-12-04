import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

/// A reusable network image widget with built-in loading and error states.
///
/// This widget reduces code duplication across the app for network images
/// by providing consistent loading spinners and error placeholder displays.
class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.errorIconSize = ValuesManager.iconSize48,
    this.loadingStrokeWidth = 2.0,
    this.borderRadius,
    super.key,
  });

  /// The URL of the image to display.
  final String imageUrl;

  /// How the image should be inscribed into the space allocated.
  final BoxFit fit;

  /// The width of the image container.
  final double? width;

  /// The height of the image container.
  final double? height;

  /// The size of the error icon displayed when image loading fails.
  final double errorIconSize;

  /// The stroke width of the loading indicator.
  final double loadingStrokeWidth;

  /// Optional border radius for the image container.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: _buildLoadingIndicator,
      errorBuilder: _buildErrorPlaceholder,
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _buildLoadingIndicator(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;

    return Container(
      color: ColorsManager.shimmerBase,
      width: width,
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
              : null,
          color: ColorsManager.primary,
          strokeWidth: loadingStrokeWidth,
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Container(
      color: ColorsManager.surfaceVariant,
      width: width,
      height: height,
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: ColorsManager.grey,
          size: errorIconSize,
        ),
      ),
    );
  }
}
