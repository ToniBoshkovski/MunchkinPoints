// databaseConstants
import 'package:flutter/cupertino.dart';
import 'package:munchkin_points/database_helpers.dart';

const String tablePlayers = 'players';
const String tableGameCounter = 'gameCounter';

const String columnId = '_id';
const String columnName = 'name';
const String columnPoints = 'points';
const String columnElapsedTime = 'elapsedTime';

// routes
const String loadingRoute = '/';
const String numPlayersRoute = '/numPlayers';
const String enterPlayersRoute = '/enterPlayers';
const String showPlayersRoute = '/showPlayers';

// global variables
DatabaseHelper dbHelper = DatabaseHelper.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


// global functions
int timeInSeconds(DateTime value) {
  var ms = value.millisecondsSinceEpoch;
  return (ms / 1000).round();
}

DateTime? safeTimestampConversionInt(int value) {
  if (value == 0) return null;
  return DateTime.fromMillisecondsSinceEpoch(value * 1000);
}
