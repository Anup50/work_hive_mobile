abstract class ConnectivityRepository {
  Future<bool> isConnected();
  Stream<bool> monitorConnection();
}
