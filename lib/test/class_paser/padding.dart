import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Padding extends SingleChildRenderObjectWidget {
  /// Creates a widget that insets its child.
  ///
  /// The [padding] argument must not be null.
  const Padding({
    super.key,
    required this.padding,
    super.child,
  }) : assert(padding != null);

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  @override
  RenderPadding createRenderObject(BuildContext context) {
    return RenderPadding(
      padding: padding,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPadding renderObject) {
    renderObject
      ..padding = padding
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('padding', padding));
  }
}