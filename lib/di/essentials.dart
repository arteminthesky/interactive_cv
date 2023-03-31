part of di;

abstract class Essentials {
  factory Essentials() => _BaseEssentials();

  const Essentials._();

  abstract final ConfigurationBundle configurationBundle;
  abstract final List<Application> applications;

  Future<void> load();
}

class _BaseEssentials extends Essentials {
  _BaseEssentials() : super._();

  final ApplicationLoader _applicationLoader = BaseApplicationLoader();

  ConfigurationBundle? _configurationBundle;
  List<Application>? _applications;

  @override
  Future<void> load() async {
    await _initProfile();
    await _initApplications();
  }

  Future<void> _initProfile() async {
    _configurationBundle = await _loadConfiguration();
  }

  Future<ConfigurationBundle> _loadConfiguration() async {
    return ConfigurationBundle.fromJson(jsonDecode(
      await rootBundle.loadString('assets/config.json'),
    ));
  }

  Future<void> _initApplications() async {
    assert(_configurationBundle != null);
    _applications = await _applicationLoader.load(_configurationBundle!);
  }

  @override
  ConfigurationBundle get configurationBundle => _configurationBundle!;

  @override
  List<Application> get applications => _applications!;
}
