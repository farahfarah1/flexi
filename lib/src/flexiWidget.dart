import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

// Define a class for the ZoomAndPanDemo widget
class Flexi extends StatefulWidget {
  // Constructor with optional parameters and required child widget
  const Flexi({
    super.key,
    required this.child,
    this.minScale = 0.8,
    this.maxScale = 2.5,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.canRotate = true,
    this.canScale = true,
    this.canTranslate = true,
    this.returnToOrigin = true,
    this.enabled = true,
    this.maxTranslationX = 100,
    this.maxTranslationY = 100,
  });
  // Properties of the class

  /// The child is required.
  final Widget child;

  /// Minimum scale factor for scaling.
  final double minScale;

  /// Maximum scale factor for scaling.
  final double maxScale;

  /// Function to be triggered at the start of the scaling event.
  final Function(ScaleStartDetails)? onScaleStart;

  /// Function to be triggered during the scaling event.
  /// Parameters: Offset (sessionOffset), double (scale), double (rotationAngle).
  final Function(Offset, double, double)? onScaleUpdate;

  /// Function to be triggered at the end of the scaling event.
  final Function(ScaleEndDetails)? onScaleEnd;

  /// Flag to enable rotation.
  final bool canRotate;

  /// Flag to enable scaling.
  final bool canScale;

  /// Flag to enable translation.
  final bool canTranslate;

  /// Flag to enable returning to the origin on double tap.
  final bool returnToOrigin;

  /// Flag to enable or disable the [Flexi] widget.
  final bool enabled;

  /// Maximum translation value along the X-axis.
  final double maxTranslationX;

  /// Maximum translation value along the Y-axis.
  final double maxTranslationY;

  // Create the state for the widget
  @override
  _FlexiState createState() => _FlexiState();
}

// Define the state for the ZoomAndPanDemo widget
class _FlexiState extends State<Flexi> {
  // Initialize variables
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _sessionOffset = Offset.zero;
  double _scale = 1.0;
  double _initialScale = 1.0;
  double _rotationAngle = 0.0;
  double _initialRotationAngle = 0.0;
  final _deferredPointerLink = DeferredPointerHandlerLink();
  // Build the widget
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width;
      double height;
      if (constraints.hasBoundedWidth) {
        width = constraints.maxWidth;
      } else {
        width = MediaQuery.of(context).size.width;
      }
      if (constraints.hasBoundedHeight) {
        height = constraints.maxHeight;
      } else {
        height = MediaQuery.of(context).size.height;
      }
      double aspectRatio = (width / height);
      return AbsorbPointer(
        absorbing: !widget.enabled,
        child: AspectRatio(
            aspectRatio: aspectRatio,
            child: DeferredPointerHandler(
                link: _deferredPointerLink,
                child: InteractiveViewer.builder(
                    scaleEnabled: false,
                    panEnabled: false,
                    builder: (context, quo) => Transform.translate(
                        offset: _clampOffset(_offset + _sessionOffset),
                        child: Transform.scale(
                          scale: _scale,
                          child: Transform.rotate(
                              angle: _rotationAngle,
                              child: DeferPointer(
                                  link: _deferredPointerLink,
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onDoubleTap: _onDoubleTap,
                                      onScaleStart: _onScaleStart,
                                      onScaleEnd: _onScaleEnd,
                                      onScaleUpdate: _onScaleUpdate,
                                      child: widget.child))),
                        ))))),
      );
    });
  }

  // Function to handle the start of a scaling event
  void _onScaleStart(ScaleStartDetails details) {
    _initialFocalPoint = details.focalPoint;
    _initialScale = _scale;
    _initialRotationAngle = _rotationAngle;
    if (widget.onScaleStart != null) {
      widget.onScaleStart!(details);
    }
  }

  // Function to handle an update to a scaling event
  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (widget.canTranslate) {
      _sessionOffset = details.focalPoint - _initialFocalPoint;
    }
    if (widget.canScale) {
      _scale = (_initialScale * details.scale)
          .clamp(widget.minScale, widget.maxScale);
    }
    if (widget.canRotate) {
      _rotationAngle = _initialRotationAngle + details.rotation;
    }
    if (widget.onScaleUpdate != null) {
      widget.onScaleUpdate!(_sessionOffset, _scale, _rotationAngle);
    }
    setState(() {});
  }

  // Function to handle the end of a scaling event
  void _onScaleEnd(ScaleEndDetails details) {
    if (widget.canTranslate) {
      _offset += _sessionOffset;
      _sessionOffset = Offset.zero;
    }
    if (widget.onScaleEnd != null) {
      widget.onScaleEnd!(details);
    }
    setState(() {});
  }

  // Function to clamp the offset within a certain range
  Offset _clampOffset(Offset offset) {
    final dx = offset.dx.clamp(-widget.maxTranslationX, widget.maxTranslationX);
    final dy = offset.dy.clamp(-widget.maxTranslationY, widget.maxTranslationY);
    return Offset(dx, dy);
  }

  // Function to reset variables on double tap
  void _onDoubleTap() {
    if (widget.returnToOrigin) {
      setState(() {
        _offset = Offset.zero;
        _scale = 1.0;
        _rotationAngle = 0.0;
      });
    }
  }
}
