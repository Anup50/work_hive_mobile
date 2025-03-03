// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:work_hive_mobile/core/domain/repository/connectivity_repository.dart';

// class ConnectivityService implements ConnectivityRepository {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   Future<bool> isConnected() async {
//     final result = await _connectivity.checkConnectivity();
//     return _isConnected(result);
//   }

//   @override
//   Stream<bool> monitorConnection() {
// return _connectivity.onConnectivityChanged.map(_isConnected);
//   }

//   bool _isConnected(ConnectivityResult result) {
//     return result != ConnectivityResult.none;
//   }
// }
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:work_hive_mobile/core/domain/repository/connectivity_repository.dart';

class ConnectivityService implements ConnectivityRepository {
  final Connectivity _connectivity = Connectivity();

  @override
  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();
    return _isConnected(results);
  }

  @override
  Stream<bool> monitorConnection() {
    return _connectivity.onConnectivityChanged.map(_isConnected);
  }

  bool _isConnected(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
