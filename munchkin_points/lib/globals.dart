// databaseConstants
import 'package:munchkin_points/database_helpers.dart';

const String tablePlayers = 'players';

const String columnId = '_id';
const String columnName = 'name';
const String columnPoints = 'points';

// routes
const String homeRoute = '/';
const String enterPlayersRoute = '/enterPlayers';
const String showPlayerPointsRoute = '/showPlayerPoints';

// global variables
DatabaseHelper dbHelper = DatabaseHelper.instance;