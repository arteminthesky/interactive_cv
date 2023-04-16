// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cv_themes.dart';

class CvThemeScope extends InheritedWidget {
  final _CvThemeState state;
  final List<CvThemeData> themes;

  const CvThemeScope({
    Key? key,
    required Widget child,
    required this.state,
    required this.themes,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CvThemeScope oldWidget) {
    return oldWidget.themes != themes;
  }
}

class CvTheme extends StatefulWidget {
  const CvTheme({
    Key? key,
    required this.child,
    this.themes,
  }) : super(key: key);

  final Widget child;
  final List<CvThemeData>? themes;

  @override
  _CvThemeState createState() {
    return _CvThemeState();
  }

  static List<CvThemeData>? getAvailableThemes(BuildContext context) {
    return getScope(context)?.themes;
  }

  static int getCurrentThemeIndex(BuildContext context) {
    return getScope(context)?.state.currentThemeIndex ?? -1;
  }

  static void changeTheme(BuildContext context,
      {int? index, CvThemeData? cvThemeData}) {
    getScope(context)
        ?.state
        .changeIndex(index ?? getScope(context)!.themes.indexOf(cvThemeData!));
  }

  static CvThemeScope? getScope(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CvThemeScope>();
  }
}

class _CvThemeState extends State<CvTheme> {
  List<CvThemeData> _themes = [];
  int currentThemeIndex = 0;

  @override
  void initState() {
    super.initState();
    initThemes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CvTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    initThemes();
  }

  void initThemes() {
    CvThemeData? currentCvTheme;
    if (_themes.isNotEmpty) {
      currentCvTheme = _themes[currentThemeIndex];
    }
    _themes = widget.themes ?? [const CvThemeData()];
    if (currentCvTheme != null) {
      int index = _themes.indexOf(currentCvTheme);
      if (index != -1) {
        currentThemeIndex = index;
      } else {
        currentThemeIndex = 0;
      }
    }
  }

  CvThemeData get theme => _themes[currentThemeIndex];

  void changeIndex(int index) {
    setState(() {
      currentThemeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CvThemeScope(
      state: this,
      themes: _themes,
      child: AnimatedTheme(
        data: Theme.of(context).copyWith(
          scaffoldBackgroundColor: theme.backgroundColor,
          cardColor: theme.cardBackgroundColor,
          dividerColor: theme.dividerColor,
          iconTheme: IconThemeData(
            color: theme.textColor,
          ),
          textTheme: Theme.of(context).textTheme.copyWith(
                displayLarge: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: theme.textColor,
                ),
                displayMedium: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: theme.textColor,
                ),
                titleSmall: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.textColor,
                ),
                bodyMedium: GoogleFonts.robotoMono(
                    color: theme.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                bodySmall: GoogleFonts.roboto(
                  color: theme.textColor,
                  fontSize: 14,
                ),
              ),
        ),
        child: widget.child,
      ),
    );
  }
}
