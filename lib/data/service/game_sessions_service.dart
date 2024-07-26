import 'dart:async';
import 'package:monopoly_banker/data/model/game_session.dart';

class GameSessionsService {
  StreamController<List<GameSession>> _streamController =
      StreamController<List<GameSession>>();

  bool disposed = false;

  Stream<List<GameSession>> get stream {
    _checkStreamControllerStatus();
    return _streamController.stream;
  }

  void deleteSession(List<GameSession> sessions, int id) async {
    sessions.removeWhere((session) => session.id == id);
    _streamController.add(sessions);
  }

  void dispose() async {
    disposed = true;
    await _streamController.close();
  }

  void update(List<GameSession> sessions) {
    _checkStreamControllerStatus();
    _streamController.add(sessions);
  }

  void _checkStreamControllerStatus() {
    if (_streamController.hasListener || _streamController.isClosed) {
      _streamController = StreamController<List<GameSession>>();
    }
  }
}
