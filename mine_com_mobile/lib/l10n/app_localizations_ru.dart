// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get settings => 'Настройки';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get darkTheme => 'Темная тема';

  @override
  String get darkThemeSubtitle => 'Изменить внешний вид приложения';

  @override
  String get language => 'Язык';

  @override
  String get notifications => 'Уведомления';

  @override
  String get notificationsSubtitle => 'Получать уведомления о статусе серверов';

  @override
  String get aboutApp => 'О приложении';

  @override
  String versionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String get helpSupport => 'Помощь и поддержка';

  @override
  String get helpSupportSubtitle => 'Документация и FAQ';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacyPolicySubtitle => 'Условия использования';

  @override
  String get account => 'Аккаунт';

  @override
  String get security => 'Безопасность';

  @override
  String get securitySubtitle => 'Пароль и двухфакторная аутентификация';

  @override
  String get logout => 'Выйти из аккаунта';

  @override
  String get logoutTitle => 'Выход из аккаунта';

  @override
  String get logoutConfirm => 'Вы уверены, что хотите выйти из аккаунта?';

  @override
  String get cancel => 'Отмена';

  @override
  String get close => 'Закрыть';

  @override
  String get openHelp => 'Открыть справку';

  @override
  String get privacyPolicyAction => 'Политика конфиденциальности';

  @override
  String get securityAction => 'Настройки безопасности';

  @override
  String get appDescription =>
      'Программный комплекс автоматизации развертывания и управления Minecraft-серверами';

  @override
  String get featuresTitle => 'Возможности:';

  @override
  String get featureSsh => 'SSH консоль для управления';

  @override
  String get featureMonitoring => 'Мониторинг метрик в реальном времени';

  @override
  String get featureLogs => 'Просмотр логов серверов';

  @override
  String get featureAutomation => 'Автоматизация развертывания';

  @override
  String get featureBackups => 'Управление бэкапами';

  @override
  String get version => 'Версия';

  @override
  String get platform => 'Платформа';

  @override
  String get platformValue => 'Unix-подобные системы';

  @override
  String get developer => 'Разработчик';

  @override
  String get developerValue => 'Minecraft Manager Team';

  @override
  String get settingsMainMenu => 'Настройки';

  @override
  String get serversMainMenu => 'Серверы';

  @override
  String get profileMainMenu => 'Профиль';

  @override
  String get onlineServerList => 'Онлайн';

  @override
  String get offlineServerList => 'Офлайн';

  @override
  String get playersServerList => 'игроков';

  @override
  String get launchServerList => 'Запустить';

  @override
  String get stopServerList => 'Остановить';

  @override
  String get restartServerList => 'Перезапустить';

  @override
  String get searchingForServersServerList => 'Поиск серверов...';

  @override
  String get clearServerList => 'Очистить';

  @override
  String get refreshServerListServerList => 'Обновление списка серверов';

  @override
  String get refreshServerList => 'Обновить';

  @override
  String get closeSearchServerList => 'Закрыть поиск';

  @override
  String get searchServerList => 'Поиск';

  @override
  String get noServersFoundServerList => 'Серверы не найдены';

  @override
  String get noServersServerList => 'Нет серверов';

  @override
  String get tryChangingYourQueryServerList => 'Попробуйте изменить запрос';

  @override
  String get addNewServerServerList => 'Добавьте новый сервер';

  @override
  String get totalServersProfile => 'Всего серверов';

  @override
  String get onlineProfile => 'Онлайн';

  @override
  String get playersProfile => 'игроков';

  @override
  String get playerProfile => 'Игрок';

  @override
  String get serverOverviewProfile => 'Обзор серверов';

  @override
  String get averageCpuLoadProfile => 'Средняя нагрузка CPU';

  @override
  String get averageNumberOfPlayersProfile => 'Среднее количество игроков';

  @override
  String get averageRamLoadProfile => 'Средняя нагрузка RAM';

  @override
  String get mostPopularServerProfile => 'Самый популярный сервер';

  @override
  String get sshConnectionsProfile => 'SSH-подключения';

  @override
  String get keyAndSessionManagementProfile => 'Управление ключами и сессиями';

  @override
  String get activityHistoryProfile => 'История активности';

  @override
  String get operationAndChangeLogProfile => 'Журнал операций и изменений';

  @override
  String get serverStatusProfile => 'Статус сервера';

  @override
  String get plProfile => 'игр.';

  @override
  String get editprofile1Profile => 'Редактировать профиль';

  @override
  String get editProfileProfile => 'Редактирование профиля';

  @override
  String get administratorProfile => 'Администратор';

  @override
  String get systemadministratorProfile => 'Системный администратор';

  @override
  String get detailedstatisticsProfile => 'детальная статистика';

  @override
  String get startServerDetailServerDetail => 'Запуск';

  @override
  String get stopServerDetail => 'Стоп';

  @override
  String get restartServerDetail => 'Перезагрузка';

  @override
  String get onlineServerDetail => 'Онлайн';

  @override
  String get serverStatusServerDetail => 'Статус сервера';

  @override
  String get minecraftVersionServerDetail => 'Версия Minecraft';

  @override
  String get modLoaderServerDetail => 'Mod Loader';

  @override
  String get activePlayersServerDetail => 'Активные игроки';

  @override
  String get dedicatedCoresServerDetail => 'Выделенные ядра';

  @override
  String get dedicatedRamServerDetail => 'Выделенная ОП';

  @override
  String get serverInformationServerDetail => 'Информация о сервере';

  @override
  String get currentMetricsServerDetail => 'Текущие метрики';

  @override
  String get cpuServerDetail => 'CPU';

  @override
  String get ramServerDetail => 'Оперативная память';

  @override
  String get detailedMetricsServerDetail => 'Подробные метрики';

  @override
  String get linuxConsoleServerDetail => 'Консоль Linux';

  @override
  String get serverLogsServerDetail => 'Логи сервера';

  @override
  String get creatingServerBackupServerDetail => 'Создание бэкапа сервера';

  @override
  String get connectedToLinuxConsole => 'Подключение к';

  @override
  String get connectionErrorLinuxConsole => 'Ошибка подключения:';

  @override
  String get failedToConnect1LinuxConsole => 'Не удалось подключиться:';

  @override
  String get sshSessionEndedLinuxConsole => 'SSH сессия завершена';

  @override
  String get shellStartupErrorLinuxConsole => 'Ошибка запуска shell:';

  @override
  String get disconnectedFromServerLinuxConsole => 'Отключено от сервера';

  @override
  String get consoleLinuxConsole => 'Консоль';

  @override
  String get disconnectLinuxConsole => 'Отключиться';

  @override
  String get reconnectLinuxConsole => 'Переподключиться';

  @override
  String get failedToConnect2LinuxConsole => 'Не удалось подключиться';

  @override
  String get unknownErrorLinuxConsole => 'Неизвестная ошибка';

  @override
  String get tryAgainLinuxConsole => 'Попробовать снова';

  @override
  String get autoscrollIsEnabledServerLogs => 'Автопрокрутка включена';

  @override
  String get autoscrollIsDisabledServerLogs => 'Автопрокрутка выключена';

  @override
  String get refreshLogsServerLogs => 'Обновить';

  @override
  String get logsUpdatedServerLogs => 'Логи обновлены';

  @override
  String get clearLogsServerLogs => 'Очистить логи';

  @override
  String get exportLogsServerLogs => 'Экспортировать';

  @override
  String get searchInLogsServerLogs => 'Поиск в логах...';

  @override
  String get logsInfoServerLogs => 'Показано \$filtered из \$total записей';

  @override
  String get noResultsFoundServerLogs => 'Ничего не найдено';

  @override
  String get noLogsToDisplayServerLogs => 'Нет логов для отображения';

  @override
  String get timeServerLogs => 'Время';

  @override
  String get sourceServerLogs => 'Источник';

  @override
  String get messageServerLogs => 'Сообщение:';

  @override
  String get copyToClipboardServerLogs => 'Копировать';

  @override
  String get copiedToClipboardServerLogs => 'Скопировано в буфер обмена';

  @override
  String get closeServerLogs => 'Закрыть';

  @override
  String get exportLogsTitleServerLogs => 'Экспорт логов';

  @override
  String get exportComingSoonServerLogs =>
      'Функция экспорта будет реализована позже.\n\nБудет доступен экспорт в форматы:\n• TXT\n• JSON\n• CSV';

  @override
  String get understoodServerLogs => 'Понятно';

  @override
  String get shownServerLogs => 'Показано';

  @override
  String get fromServerLogs => 'из';

  @override
  String get recordsServerLogs => 'записей';

  @override
  String get logsServerLogs => 'Логи';

  @override
  String get metricsMetricsFragment => 'Метрики';

  @override
  String get cpuMetricsFragment => 'CPU';

  @override
  String get memoryMetricsFragment => 'Память';

  @override
  String get overviewMetricsFragment => 'Обзор';

  @override
  String get cpuLoadLast10MeasurementsMetricsFragment =>
      'Нагрузка CPU (последние 10 измерений)';

  @override
  String get ramUsageLast10MeasurementsMetricsFragment =>
      'Использование ОП (последние 10 измерений)';

  @override
  String get metricsOverviewMetricsFragment => 'Общий обзор метрик';

  @override
  String get ramMetricsFragment => 'ОП';

  @override
  String get statisticsMetricsFragment => 'Статистика';

  @override
  String get averageCpuMetricsFragment => 'Среднее CPU';

  @override
  String get averageRamMetricsFragment => 'Среднее ОП';

  @override
  String get maxCpuMetricsFragment => 'Макс CPU';

  @override
  String get maxRamMetricsFragment => 'Макс ОП';
}
