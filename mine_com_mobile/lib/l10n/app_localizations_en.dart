// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get darkThemeSubtitle => 'Change app appearance';

  @override
  String get language => 'Language';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle => 'Receive server status notifications';

  @override
  String get aboutApp => 'About app';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get helpSupportSubtitle => 'Documentation and FAQ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicySubtitle => 'Terms of use';

  @override
  String get account => 'Account';

  @override
  String get security => 'Security';

  @override
  String get securitySubtitle => 'Password and two-factor authentication';

  @override
  String get logout => 'Log out';

  @override
  String get logoutTitle => 'Log out';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get openHelp => 'Open help';

  @override
  String get privacyPolicyAction => 'Privacy policy';

  @override
  String get securityAction => 'Security settings';

  @override
  String get appDescription =>
      'Software complex for automating deployment and management of Minecraft servers';

  @override
  String get featuresTitle => 'Features:';

  @override
  String get featureSsh => 'SSH console for management';

  @override
  String get featureMonitoring => 'Real-time metrics monitoring';

  @override
  String get featureLogs => 'Server log viewing';

  @override
  String get featureAutomation => 'Deployment automation';

  @override
  String get featureBackups => 'Backup management';

  @override
  String get version => 'Version';

  @override
  String get platform => 'Platform';

  @override
  String get platformValue => 'Unix-like systems';

  @override
  String get developer => 'Developer';

  @override
  String get developerValue => 'Minecraft Manager Team';

  @override
  String get settingsMainMenu => 'Settings';

  @override
  String get serversMainMenu => 'Servers';

  @override
  String get profileMainMenu => 'Profile';

  @override
  String get onlineServerList => 'Online';

  @override
  String get offlineServerList => 'Offline';

  @override
  String get playersServerList => 'players';

  @override
  String get launchServerList => 'Launch';

  @override
  String get stopServerList => 'Stop';

  @override
  String get restartServerList => 'Restart';

  @override
  String get searchingForServersServerList => 'Searching for servers...';

  @override
  String get clearServerList => 'Clear';

  @override
  String get refreshServerListServerList => 'Refresh server list';

  @override
  String get refreshServerList => 'Refresh';

  @override
  String get closeSearchServerList => 'Close search';

  @override
  String get searchServerList => 'Search';

  @override
  String get noServersFoundServerList => 'No servers found';

  @override
  String get noServersServerList => 'No servers';

  @override
  String get tryChangingYourQueryServerList => 'Try changing your query';

  @override
  String get addNewServerServerList => 'Add a new server';

  @override
  String get totalServersProfile => 'Total servers';

  @override
  String get onlineProfile => 'Online';

  @override
  String get playersProfile => 'players';

  @override
  String get playerProfile => 'Player';

  @override
  String get serverOverviewProfile => 'Server overview';

  @override
  String get averageCpuLoadProfile => 'Average CPU load';

  @override
  String get averageNumberOfPlayersProfile => 'Average number of players';

  @override
  String get averageRamLoadProfile => 'Average RAM load';

  @override
  String get mostPopularServerProfile => 'Most popular server';

  @override
  String get sshConnectionsProfile => 'SSH connections';

  @override
  String get keyAndSessionManagementProfile => 'Key and session management';

  @override
  String get activityHistoryProfile => 'Activity history';

  @override
  String get operationAndChangeLogProfile => 'Operation and change log';

  @override
  String get serverStatusProfile => 'Server status';

  @override
  String get plProfile => 'pl';

  @override
  String get editprofile1Profile => 'Edit profile';

  @override
  String get editProfileProfile => 'Edit profile';

  @override
  String get administratorProfile => 'Administrator';

  @override
  String get systemadministratorProfile => 'System administrator';

  @override
  String get detailedstatisticsProfile => 'detailed statistics';

  @override
  String get startServerDetailServerDetail => 'Start';

  @override
  String get stopServerDetail => 'Stop';

  @override
  String get restartServerDetail => 'Restart';

  @override
  String get onlineServerDetail => 'Online';

  @override
  String get serverStatusServerDetail => 'Server status';

  @override
  String get minecraftVersionServerDetail => 'Minecraft version';

  @override
  String get modLoaderServerDetail => 'Mod loader';

  @override
  String get activePlayersServerDetail => 'Active players';

  @override
  String get dedicatedCoresServerDetail => 'Dedicated cores';

  @override
  String get dedicatedRamServerDetail => 'Dedicated RAM';

  @override
  String get serverInformationServerDetail => 'Server information';

  @override
  String get currentMetricsServerDetail => 'Current metrics';

  @override
  String get cpuServerDetail => 'CPU';

  @override
  String get ramServerDetail => 'RAM';

  @override
  String get detailedMetricsServerDetail => 'Detailed metrics';

  @override
  String get linuxConsoleServerDetail => 'Linux console';

  @override
  String get serverLogsServerDetail => 'Server logs';

  @override
  String get creatingServerBackupServerDetail => 'Creating a server backup';

  @override
  String get connectedToLinuxConsole => 'Connected to';

  @override
  String get connectionErrorLinuxConsole => 'Connection Error:';

  @override
  String get failedToConnect1LinuxConsole => 'Failed to connect:';

  @override
  String get sshSessionEndedLinuxConsole => 'SSH session ended';

  @override
  String get shellStartupErrorLinuxConsole => 'Shell startup error:';

  @override
  String get disconnectedFromServerLinuxConsole => 'Disconnected from server';

  @override
  String get consoleLinuxConsole => 'Console';

  @override
  String get disconnectLinuxConsole => 'Disconnect';

  @override
  String get reconnectLinuxConsole => 'Reconnect';

  @override
  String get failedToConnect2LinuxConsole => 'Failed to connect';

  @override
  String get unknownErrorLinuxConsole => 'Unknown error';

  @override
  String get tryAgainLinuxConsole => 'Try again';

  @override
  String get autoscrollIsEnabledServerLogs => 'Autoscroll enabled';

  @override
  String get autoscrollIsDisabledServerLogs => 'Autoscroll disabled';

  @override
  String get refreshLogsServerLogs => 'Refresh';

  @override
  String get logsUpdatedServerLogs => 'Logs updated';

  @override
  String get clearLogsServerLogs => 'Clear logs';

  @override
  String get exportLogsServerLogs => 'Export';

  @override
  String get searchInLogsServerLogs => 'Search in logs...';

  @override
  String get logsInfoServerLogs => 'Showing \$filtered of \$total entries';

  @override
  String get noResultsFoundServerLogs => 'Nothing found';

  @override
  String get noLogsToDisplayServerLogs => 'No logs to display';

  @override
  String get timeServerLogs => 'Time';

  @override
  String get sourceServerLogs => 'Source';

  @override
  String get messageServerLogs => 'Message:';

  @override
  String get copyToClipboardServerLogs => 'Copy';

  @override
  String get copiedToClipboardServerLogs => 'Copied to clipboard';

  @override
  String get closeServerLogs => 'Close';

  @override
  String get exportLogsTitleServerLogs => 'Export logs';

  @override
  String get exportComingSoonServerLogs =>
      'Export feature will be implemented later.\n\nAvailable formats:\n• TXT\n• JSON\n• CSV';

  @override
  String get understoodServerLogs => 'Got it';

  @override
  String get shownServerLogs => 'shown';

  @override
  String get fromServerLogs => 'from';

  @override
  String get recordsServerLogs => 'records';

  @override
  String get logsServerLogs => 'Logs';

  @override
  String get metricsMetricsFragment => 'Metrics';

  @override
  String get cpuMetricsFragment => 'CPU';

  @override
  String get memoryMetricsFragment => 'Memory';

  @override
  String get overviewMetricsFragment => 'Overview';

  @override
  String get cpuLoadLast10MeasurementsMetricsFragment =>
      'CPU load (last 10 measurements)';

  @override
  String get ramUsageLast10MeasurementsMetricsFragment =>
      'RAM usage (last 10 measurements)';

  @override
  String get metricsOverviewMetricsFragment => 'Metrics overview';

  @override
  String get ramMetricsFragment => 'RAM';

  @override
  String get statisticsMetricsFragment => 'Statistics';

  @override
  String get averageCpuMetricsFragment => 'Average CPU';

  @override
  String get averageRamMetricsFragment => 'Average RAM';

  @override
  String get maxCpuMetricsFragment => 'Max CPU';

  @override
  String get maxRamMetricsFragment => 'Max RAM';
}
