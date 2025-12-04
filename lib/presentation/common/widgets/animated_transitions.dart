import 'dart:math' as math;
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

/// Slide direction for transitions
enum SlideDirection { right, left, up, down }

/// Custom page route with fade transition
class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadePageRoute({required this.page, super.settings})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(
          milliseconds: ValuesManager.animationDurationMedium,
        ),
        reverseTransitionDuration: const Duration(
          milliseconds: ValuesManager.animationDurationMedium,
        ),
      );
}

/// Custom page route with slide transition
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  SlidePageRoute({
    required this.page,
    this.direction = SlideDirection.right,
    super.settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final begin = _getBeginOffset(SlideDirection.right);
           return SlideTransition(
             position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
               CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
             ),
             child: child,
           );
         },
         transitionDuration: const Duration(
           milliseconds: ValuesManager.animationDurationMedium,
         ),
         reverseTransitionDuration: const Duration(
           milliseconds: ValuesManager.animationDurationMedium,
         ),
       );

  static Offset _getBeginOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.right:
        return const Offset(1.0, 0.0);
      case SlideDirection.left:
        return const Offset(-1.0, 0.0);
      case SlideDirection.up:
        return const Offset(0.0, 1.0);
      case SlideDirection.down:
        return const Offset(0.0, -1.0);
    }
  }
}

/// Custom page route with scale transition
class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScalePageRoute({required this.page, super.settings})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(
          milliseconds: ValuesManager.animationDurationMedium,
        ),
        reverseTransitionDuration: const Duration(
          milliseconds: ValuesManager.animationDurationMedium,
        ),
      );
}

/// An animated visibility widget with fade effect
class AnimatedVisibilityWidget extends StatelessWidget {
  const AnimatedVisibilityWidget({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(
      milliseconds: ValuesManager.animationDurationShort,
    ),
    this.curve = Curves.easeInOut,
  });

  final bool visible;
  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: duration,
      curve: curve,
      child: AnimatedScale(
        scale: visible ? 1.0 : 0.95,
        duration: duration,
        curve: curve,
        child: visible ? child : const SizedBox.shrink(),
      ),
    );
  }
}

/// A widget that animates its entry with a slide and fade effect
class SlideInWidget extends StatefulWidget {
  const SlideInWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(
      milliseconds: ValuesManager.animationDurationMedium,
    ),
    this.direction = SlideDirection.up,
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final SlideDirection direction;
  final Curve curve;

  @override
  State<SlideInWidget> createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<SlideInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    Offset begin;
    switch (widget.direction) {
      case SlideDirection.right:
        begin = const Offset(-0.3, 0.0);
        break;
      case SlideDirection.left:
        begin = const Offset(0.3, 0.0);
        break;
      case SlideDirection.up:
        begin = const Offset(0.0, 0.3);
        break;
      case SlideDirection.down:
        begin = const Offset(0.0, -0.3);
        break;
    }

    _slideAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );
  }
}

/// A widget that pulses to draw attention
class PulsingWidget extends StatefulWidget {
  const PulsingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.minScale = 0.95,
    this.maxScale = 1.05,
  });

  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  @override
  State<PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<PulsingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}

/// A widget that shakes to indicate error
class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    super.key,
    required this.child,
    required this.shake,
    this.duration = const Duration(milliseconds: 500),
    this.shakeCount = 3,
    this.shakeOffset = 10.0,
  });

  final Widget child;
  final bool shake;
  final Duration duration;
  final int shakeCount;
  final double shakeOffset;

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));
  }

  @override
  void didUpdateWidget(ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shake && !oldWidget.shake) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _shakeValue(double animation) {
    return math.sin(animation * widget.shakeCount * 2 * math.pi) *
        widget.shakeOffset;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeValue(_animation.value), 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
