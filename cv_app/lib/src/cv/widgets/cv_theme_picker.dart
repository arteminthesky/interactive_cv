import 'package:cv_app/src/cv/widgets/cv_theme_widget.dart';
import 'package:flutter/material.dart';

import '../cv_themes.dart';

class CvThemePicker extends StatelessWidget {
  const CvThemePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
      spacing: 3,
      children: CvTheme.getAvailableThemes(context)
              ?.map((e) => _buildCvThemeItem(e, context))
              .toList() ??
          [],
    );
  }

  Widget _buildCvThemeItem(CvThemeData theme, BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(7),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => CvTheme.changeTheme(context, cvThemeData: theme),
        child: SizedBox(
          width: 25,
          height: 25,
          child: theme.previewBuilder(context),
        ),
      ),
    );
  }
}
