part of di;

abstract class Essentials {
  factory Essentials() => _BaseEssentials();

  const Essentials._();

  abstract final Profile profile;
  abstract final List<Application> applications;

  Future<void> load();
}

class _BaseEssentials extends Essentials {
  _BaseEssentials() : super._();

  final ApplicationLoader _applicationLoader = BaseApplicationLoader();

  Profile? _profile;
  List<Application>? _applications;

  @override
  Future<void> load() async {
    await _initProfile();
    await _initApplications();
  }

  Future<void> _initProfile() async {
    _profile = await _loadProfile();
  }

  Future<Profile> _loadProfile() async {
    return Profile.fromJson(jsonDecode(
      await rootBundle.loadString('assets/profile.json'),
    ));
  }

  Future<void> _initApplications() async {
    assert(_profile != null);
    _applications = await _applicationLoader.load(profile);
  }

  @override
  Profile get profile => _profile!;

  @override
  List<Application> get applications => _applications!;
}
