import 'package:flutter/material.dart';

class ScalingButton extends StatefulWidget {
  final double width;
  final double height;
  final Widget expandedChild;
  final Duration duration;
  final Widget triggerButton;
  const ScalingButton({
    super.key,
    required this.width,
    required this.height,
    required this.expandedChild,
    required this.triggerButton,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<ScalingButton> createState() => _ScalingButtonState();
}

class _ScalingButtonState extends State<ScalingButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  bool _expanded = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
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
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        AnimatedBuilder(
          animation: _scale,
          builder: (context, child) {
            return Transform.scale(
              scale: _scale.value,
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  borderRadius: BorderRadius.circular(16),
                  child: GestureDetector(
                    onTap: _toggle,
                    child: Align(alignment: Alignment.bottomCenter, child: widget.expandedChild),
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 5,
          right: 10,
          child: GestureDetector(onTap: _toggle, child: widget.triggerButton),
        ),
      ],
    );
  }
}
