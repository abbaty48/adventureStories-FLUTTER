import 'skeleton.dart';
import 'package:flutter/material.dart';

class StorySkeleton extends StatelessWidget {
  const StorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Skeleton(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(right: 5),
        )),
        const SizedBox(height: 5),
        SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width * 1.0,
            child: Stack(
              children: [
                Positioned(
                    left: 70,
                    top: 10,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Skeleton(
                          height: 50,
                          width: 50,
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ))),
                Positioned(
                    left: 95,
                    top: 10,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Skeleton(
                            height: 50,
                            width: 50,
                            color: Theme.of(context).backgroundColor,
                            border: Border.fromBorderSide(BorderSide(
                                strokeAlign: StrokeAlign.outside,
                                color: Colors.black.withOpacity(0.1),
                                width: 1)),
                            borderRadius: BorderRadius.circular(50)))),
                Positioned(
                    left: 120,
                    top: 10,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Skeleton(
                            height: 50,
                            width: 50,
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1), width: 1),
                            borderRadius: BorderRadius.circular(50)))),
              ],
            )),
        const SizedBox(height: 5),
      ],
    );
  }
}
