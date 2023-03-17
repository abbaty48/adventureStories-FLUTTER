import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
  final Widget body;
  final Axis? direction;
  final Widget? footerChild;
  final Widget? headerChild;
  final BoxBorder? shapeBorder;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const CardBox(
      {super.key,
      this.headerChild,
      this.footerChild,
      this.shapeBorder,
      required this.body,
      this.direction = Axis.vertical,
      this.margin = const EdgeInsets.all(5),
      this.backgroundColor = Colors.transparent,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.stretch,
      this.borderRadius = const BorderRadius.all(Radius.circular(30)),
      this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 5)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: borderRadius,
        border:
            shapeBorder ?? Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Flex(
        direction: direction!,
        mainAxisAlignment: mainAxisAlignment!,
        crossAxisAlignment: crossAxisAlignment!,
        children: [
          if (headerChild != null)
            Container(
              padding: padding,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor))),
              child: headerChild,
            ),
          Padding(
              padding: padding!,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width, child: body)),
          if (footerChild != null)
            Container(
              padding: padding,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Theme.of(context).dividerColor))),
              child: footerChild,
            )
        ],
      ),
    );
  }
}
