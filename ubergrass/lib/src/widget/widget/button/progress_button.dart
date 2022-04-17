import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ButtonState buttonState;
  final Widget? child;
  final Color? backgroundColor;
  final Color? progressColor;
  final double? borderRadiusSize;

  const ProgressButton(
      {Key? key,
      required this.buttonState,
      required this.onPressed,
      this.child,
      this.backgroundColor,
      this.borderRadiusSize,
      this.progressColor})
      : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

enum ButtonState { inProgress, error, normal }

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  late AnimationController _errorAnimationController;
  late AnimationController _progressAnimationController;
  late Animation<Offset> _errorAnimation;
  late Animation<BorderRadius?> _borderAnimation;
  late Animation<double?> _widthAnimation;

  double get buttonWidth => _widthAnimation.value ?? 0;
  BorderRadius get borderRadius =>
      _borderAnimation.value ??
      BorderRadius.circular(widget.borderRadiusSize ?? 12);

  Color get backgroundColor =>
      widget.backgroundColor ?? Theme.of(context).primaryColor;

  Color get progressColor => widget.progressColor ?? Colors.white;

  Widget get child => widget.child ?? Container();

  @override
  void initState() {
    super.initState();

    _errorAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _progressAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    // Define errorAnimation sequence
    _errorAnimation = TweenSequence<Offset>([
      TweenSequenceItem<Offset>(
          tween: Tween(begin: const Offset(0, 0), end: const Offset(0.03, 0)),
          weight: 1),
      TweenSequenceItem<Offset>(
          tween:
              Tween(begin: const Offset(0.03, 0), end: const Offset(-0.03, 0)),
          weight: 2),
      TweenSequenceItem<Offset>(
          tween:
              Tween(begin: const Offset(-0.03, 0), end: const Offset(0.03, 0)),
          weight: 2),
      TweenSequenceItem<Offset>(
          tween:
              Tween(begin: const Offset(0.03, 0), end: const Offset(-0.03, 0)),
          weight: 2),
      TweenSequenceItem<Offset>(
          tween: Tween(begin: const Offset(-0.03, 0), end: const Offset(0, 0)),
          weight: 1)
    ]).animate(CurvedAnimation(
      parent: _errorAnimationController,
      curve: Curves.linear,
    ));
  }

  @override
  void didUpdateWidget(ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.buttonState != ButtonState.error &&
        widget.buttonState == ButtonState.error) {
      _errorAnimationController.reset();
      _errorAnimationController.forward();
    }
    if (oldWidget.buttonState != ButtonState.inProgress &&
        widget.buttonState == ButtonState.inProgress) {
      _progressAnimationController.stop();
      _progressAnimationController.forward();
    }
    if (oldWidget.buttonState == ButtonState.inProgress &&
        widget.buttonState != ButtonState.inProgress) {
      _progressAnimationController.stop();
      _progressAnimationController.reverse();
    }
  }

  bool isAnimationRunning(AnimationController controller) {
    return !controller.isCompleted && !controller.isDismissed;
  }

  @override
  Widget build(BuildContext context) {
    return getErrorAnimatedBuilder();
  }

  AnimatedBuilder getErrorAnimatedBuilder() {
    return AnimatedBuilder(
        animation: _errorAnimationController,
        builder: (context, child) {
          return SlideTransition(
              position: _errorAnimation,
              child: LayoutBuilder(builder: getProgressAnimatedBuilder));
        });
  }

  AnimatedBuilder getProgressAnimatedBuilder(
      BuildContext context, BoxConstraints constraints) {
    var buttonHeight = constraints.maxHeight;
    // If there is no constraint on height, we should constrain it
    if (buttonHeight == double.infinity) buttonHeight = 48;

    // These animation configurations can be tweaked to have
    // however you like it
    _borderAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(
                widget.borderRadiusSize ?? buttonHeight / 6),
            end: BorderRadius.circular(buttonHeight / 2))
        .animate(CurvedAnimation(
            parent: _progressAnimationController, curve: Curves.linear));

    _widthAnimation = Tween<double>(
      begin: constraints.maxWidth,
      end: buttonHeight, // Circular progress must be contained in a square
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.linear,
    ));

    Widget? buttonContent;

    if (widget.buttonState != ButtonState.inProgress) {
      buttonContent = child;
    } else if (widget.buttonState == ButtonState.inProgress) {
      buttonContent = SizedBox(
          height: buttonHeight,
          width: buttonHeight, // needs to be a square container
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              strokeWidth: 3,
            ),
          ));
    }

    return AnimatedBuilder(
      animation: _progressAnimationController,
      builder: (context, child) {
        return Card(
          elevation: 3,
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadiusSize ?? 12),
            ),
          ),
          child: SizedBox(
            width: buttonWidth,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: borderRadius,
              // this fixes the ripple effect
              child: Center(
                child: Ink(
                  width: buttonWidth,
                  height: buttonHeight,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: backgroundColor),
                  child: Center(child: buttonContent),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
