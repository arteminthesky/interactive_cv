import 'package:cv_app/src/cv/cv.dart';
import 'package:cv_app/src/cv/cv_themes.dart';
import 'package:cv_app/src/cv/widgets/cv_theme_picker.dart';
import 'package:cv_app/src/cv/widgets/cv_theme_widget.dart';
import 'package:cv_app/src/domain/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CvScreen extends StatefulWidget {
  const CvScreen({Key? key}) : super(key: key);

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  late Profile _profile;
  GlobalKey cvWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _profile = Provider.of<Profile>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CvTheme(
      themes: themes,
      child: Scaffold(body: LayoutBuilder(
        builder: (context, constraints) {
          bool isVerticalLayout = constraints.maxWidth <= 500;

          Widget cvWidget = CvWidget(
            key: cvWidgetKey,
            profile: _profile,
          );

          Widget themePicker = const Padding(
            padding: EdgeInsets.all(8.0),
            child: CvThemePicker(),
          );

          return SingleChildScrollView(
            child: Flex(
              direction: isVerticalLayout ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isVerticalLayout) const Spacer(),
                if (isVerticalLayout) themePicker,
                SizedBox(
                  width: isVerticalLayout ? constraints.maxWidth : 500,
                  child: cvWidget,
                ),
                if (!isVerticalLayout)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: themePicker,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      )),
    );
  }
}
