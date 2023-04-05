part of options;

class OpenLinkOption extends Option {
  final String githubUser;

  OpenLinkOption(this.githubUser);

  @override
  String name(BuildContext context) {
    return 'Open GitHub';
  }

  @override
  Future<void> onClick(BuildContext context) async {
    launchUrl(Uri.parse('https://github.com/$githubUser'));
  }
}
