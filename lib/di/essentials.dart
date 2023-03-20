part of di;

abstract class Essentials {
  factory Essentials() => _BaseEssentials();

  const Essentials._();

  abstract final Profile profile;
  abstract final List<Application> applications;

  Future<void> load();
}

class _BaseEssentials extends Essentials {

  _BaseEssentials(): super._();

  Profile? _profile;
  List<Application>? _applications;

  @override
  Future<void> load() async {
    _profile = Profile.fromJson(jsonDecode(
      await rootBundle.loadString('assets/profile.json'),
    ));
    _initApplications();
  }

  void _initApplications() {
    final applications = <Application>[];

    applications.add(CVApplication(profile));
    if(profile.githubUrl != null) {
      applications.add(GitHubApplication());
    }
    if(profile.linkedin != null) {
      applications.add(LinkedInApplication(profile.linkedin!));
    }

    _applications = applications;
  }

  @override
  Profile get profile => _profile!;

  @override
  List<Application> get applications => _applications!;


}
