

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../ui/widgets/fidgets/fidgets.dart';

class RightDrawerPage extends StatelessWidget {
  const RightDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: CustomScrollView(
        slivers: [
          SliverSafeArea(
            bottom: false,
            sliver: SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: SliverToBoxAdapter(
                child: BmoFidget(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
