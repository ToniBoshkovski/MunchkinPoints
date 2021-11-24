import 'package:munchkin_points/globals.dart';

class GameCounter {
  int? id;
  DateTime? elapsedTime;

  GameCounter(
    this.id,
    this.elapsedTime,
  );

  GameCounter.fromDbMap(Map<String, dynamic> map) {
    id = map[columnId];
    elapsedTime = safeTimestampConversionInt(map[columnElapsedTime]);
  }

  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnElapsedTime: timeInSeconds(elapsedTime!)
    };
    return map;
  }
}
