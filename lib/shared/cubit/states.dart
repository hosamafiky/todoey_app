abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppDatabaseCreateSuccessState extends AppStates {}

class AppDatabaseCreateErrorState extends AppStates {}

class AppInsertToDatabaseLoadingState extends AppStates {}

class AppInsertToDatabaseSuccessState extends AppStates {}

class AppInsertToDatabaseErrorState extends AppStates {}

class AppGetDataFromDatabaseLoadingState extends AppStates {}

class AppGetDataFromDatabaseSuccessState extends AppStates {}

class AppGetDataFromDatabaseErrorState extends AppStates {}

class AppUpdateDatabaseSuccessState extends AppStates {}

class AppUpdateDatabaseErrorState extends AppStates {}

class AppCleanDatabaseSuccessState extends AppStates {}

class AppSelectScrollDateState extends AppStates {}

class AppSelectTaskState extends AppStates {}
