// databaseConstants
import 'package:flutter/cupertino.dart';
import 'package:munchkin_points/database_helpers.dart';

const String tablePlayers = 'players';

const String columnId = '_id';
const String columnName = 'name';
const String columnPoints = 'points';

// routes
const String loadingRoute = '/';
const String numPlayersRoute = '/numPlayers';
const String enterPlayersRoute = '/enterPlayers';
const String showPlayersRoute = '/showPlayers';

// global variables
DatabaseHelper dbHelper = DatabaseHelper.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
