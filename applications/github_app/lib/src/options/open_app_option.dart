part of options;

class OpenAppOption extends Option {

  final Application application;

  OpenAppOption(this.application);

  @override
  String name(BuildContext context) {
    return 'Open App';
  }

  @override
  Future<void> onClick(BuildContext context) async {
    application.open(context);
  }

}