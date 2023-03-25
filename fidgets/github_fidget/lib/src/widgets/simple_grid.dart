import 'package:flutter/cupertino.dart';

class SimpleGrid extends StatelessWidget {
  const SimpleGrid({
    Key? key,
    required this.crossAxisCount,
    required this.builder,
    required this.itemCount,
    this.aspectRatio = 1,
    this.axis = Axis.vertical,
  }) : super(key: key);

  final int crossAxisCount;
  final IndexedWidgetBuilder builder;
  final double aspectRatio;
  final int itemCount;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final fullMainAxisCount = itemCount / crossAxisCount;
    var mainAxisCount = itemCount % crossAxisCount > 0
        ? fullMainAxisCount + 1
        : fullMainAxisCount;

    return Flex(
      direction: axis,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < mainAxisCount; i++)
          Flex(
              direction: flipAxis(axis),
              children: [
                for (int j = 0; j < crossAxisCount; j++)
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: i * crossAxisCount + j < itemCount
                          ? builder(context, i * crossAxisCount + j)
                          : const Offstage(),
                    ),
                  )
              ],
            ),

      ],
    );
  }
}
