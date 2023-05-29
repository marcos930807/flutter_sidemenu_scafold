import 'package:flutter/material.dart';

class ShadowCard extends StatelessWidget {
  const ShadowCard({
    Key? key,
    this.child,
    this.backgroundColor,
    this.gradient,
    this.border,
    this.borderRadius,
    this.height,
    this.width,
    this.margin,
    this.elevetion,
    this.constraints,
  }) : super(key: key);
  final Widget? child;
  final Color? backgroundColor;
  final LinearGradient? gradient;
  final Border? border;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double? elevetion;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.all(0),
      constraints: constraints,
      decoration: BoxDecoration(
          gradient: gradient,
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(10)),
          border: border,
          boxShadow: <BoxShadow>[
            if (Theme.of(context).brightness == Brightness.light)
              BoxShadow(
                blurRadius: 8,
                color: Theme.of(context).primaryColor.withAlpha(20),
              )
          ]),
      child: ClipRRect(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(10)),
        child: Material(
          color: Colors.transparent,
          elevation: elevetion ?? 0.0,
          child: child,
        ),
      ),
    );
  }

  factory ShadowCard.bordered({
    required final BuildContext context,
    required final Widget child,
    final EdgeInsetsGeometry? margin,
    final double? height,
    final double? width,
    final BorderRadius? borderRadius,
  }) {
    return ShadowCard(
      margin: margin,
      height: height,
      width: width,
      borderRadius: borderRadius,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      border: Theme.of(context).brightness == Brightness.light
          ? Border.all(color: Theme.of(context).primaryColor.withAlpha(20))
          : null,
      child: child,
    );
  }
}
