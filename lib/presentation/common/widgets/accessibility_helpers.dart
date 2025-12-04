import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

/// A wrapper widget that ensures minimum touch target size (48x48dp)
/// for Material Design accessibility compliance
class AccessibleTouchTarget extends StatelessWidget {
  const AccessibleTouchTarget({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: onTap != null,
      excludeSemantics: excludeSemantics,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ValuesManager.radius8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: ValuesManager.minTouchTarget,
            minHeight: ValuesManager.minTouchTarget,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

/// A wrapper that provides semantic information for screen readers
class SemanticWrapper extends StatelessWidget {
  const SemanticWrapper({
    super.key,
    required this.child,
    this.label,
    this.hint,
    this.isButton = false,
    this.isHeader = false,
    this.isTextField = false,
    this.isImage = false,
    this.isLink = false,
    this.isEnabled = true,
    this.isSelected,
    this.isChecked,
    this.excludeSemantics = false,
    this.onTap,
    this.onLongPress,
  });

  final Widget child;
  final String? label;
  final String? hint;
  final bool isButton;
  final bool isHeader;
  final bool isTextField;
  final bool isImage;
  final bool isLink;
  final bool isEnabled;
  final bool? isSelected;
  final bool? isChecked;
  final bool excludeSemantics;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      header: isHeader,
      textField: isTextField,
      image: isImage,
      link: isLink,
      enabled: isEnabled,
      selected: isSelected,
      checked: isChecked,
      excludeSemantics: excludeSemantics,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}

/// Provides haptic feedback for different interaction types
class HapticFeedbackHelper {
  HapticFeedbackHelper._();

  /// Light impact for subtle interactions (toggles, selections)
  static void lightImpact() => HapticFeedback.lightImpact();

  /// Medium impact for standard interactions (button taps)
  static void mediumImpact() => HapticFeedback.mediumImpact();

  /// Heavy impact for significant interactions (confirmations, deletions)
  static void heavyImpact() => HapticFeedback.heavyImpact();

  /// Selection click for picker/selection changes
  static void selectionClick() => HapticFeedback.selectionClick();

  /// Vibrate for error states
  static void vibrate() => HapticFeedback.vibrate();
}

/// Focus management utilities for form accessibility
class FocusHelper {
  FocusHelper._();

  /// Move focus to the next field
  static void nextFocus(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Move focus to the previous field
  static void previousFocus(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }

  /// Unfocus current field
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Request focus on a specific node
  static void requestFocus(BuildContext context, FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }
}

/// A widget that provides focus highlight for keyboard navigation
class FocusHighlight extends StatelessWidget {
  const FocusHighlight({
    super.key,
    required this.child,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
  });

  final Widget child;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ValuesManager.radius8),
              border: isFocused
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    )
                  : null,
            ),
            child: child,
          );
        },
      ),
    );
  }
}

/// Extension methods for accessibility
extension AccessibilityExtensions on BuildContext {
  /// Get text scale factor for accessibility
  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1.0);

  /// Check if user has enabled bold text
  bool get isBoldTextEnabled => MediaQuery.boldTextOf(this);

  /// Check if animations should be reduced
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);

  /// Check if high contrast is enabled
  bool get isHighContrastEnabled => MediaQuery.highContrastOf(this);

  /// Get the platform brightness
  Brightness get platformBrightness => MediaQuery.platformBrightnessOf(this);

  /// Announce message for screen readers
  void announceForAccessibility(String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
}
