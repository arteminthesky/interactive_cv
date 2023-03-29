part of sections;


class BaseInfoSection extends StatelessWidget {
  const BaseInfoSection({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return _Section(
      header: Header(
        profile.name,
        subtitle: profile.bio,
      ),
    );
  }
}
