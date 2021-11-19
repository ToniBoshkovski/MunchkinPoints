import 'package:munchkin_points/globals.dart';

class Player {
  int? id;
  String? name;
  int? points;

  Player(
    this.id,
    this.name,
    this.points,
  );

  Player.fromDbMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    points = map[columnPoints];
  }

  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnName: name,
      columnPoints: points
    };
    return map;
  }
}
