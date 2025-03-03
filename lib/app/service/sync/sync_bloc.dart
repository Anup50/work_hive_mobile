import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:work_hive_mobile/app/service/sync/sync.dart';
import 'package:work_hive_mobile/core/common/internet_checker.dart';

final _logger = Logger('SyncBloc');

abstract class SyncState {}

class SyncInitial extends SyncState {}

class SyncInProgress extends SyncState {}

class SyncSuccess extends SyncState {
  final SyncStatus? status;
  SyncSuccess({this.status});
}

class SyncFailure extends SyncState {
  final String error;
  final SyncStatus? status;
  SyncFailure(this.error, {this.status});
}

// Sync Events
abstract class SyncEvent {}

class StartSync extends SyncEvent {}

class ConnectivityChanged extends SyncEvent {
  final bool isConnected;
  ConnectivityChanged(this.isConnected);
}

class RetryFailedSyncs extends SyncEvent {}

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncService _syncService;
  final NetworkInfo _networkInfo;
  StreamSubscription? _connectivitySubscription;

  SyncBloc({
    required SyncService syncService,
    required NetworkInfo networkInfo,
  })  : _syncService = syncService,
        _networkInfo = networkInfo,
        super(SyncInitial()) {
    on<StartSync>(_onStartSync);
    on<ConnectivityChanged>(_onConnectivityChanged);
    on<RetryFailedSyncs>(_onRetryFailedSyncs);

    _connectivitySubscription = _networkInfo.onConnectivityChanged.listen(
      (isConnected) => add(ConnectivityChanged(isConnected)),
    );
  }

  Future<void> _onStartSync(StartSync event, Emitter<SyncState> emit) async {
    emit(SyncInProgress());
    try {
      final pendingItems = await _syncService.getPendingSyncs();
      _logger.info('Pending Sync Items: ${pendingItems.length}');

      await _syncService.syncPendingItems();

      final status = await _syncService.getSyncStatus();

      emit(SyncSuccess(status: status));
    } catch (e) {
      _logger.severe('Sync Error', e);

      final status = await _syncService.getSyncStatus();
      emit(SyncFailure(e.toString(), status: status));
    }
  }

  Future<void> _onConnectivityChanged(
      ConnectivityChanged event, Emitter<SyncState> emit) async {
    if (event.isConnected) {
      _logger.info('Network connected, initiating sync');
      add(StartSync());
    }
  }

  Future<void> _onRetryFailedSyncs(
      RetryFailedSyncs event, Emitter<SyncState> emit) async {
    emit(SyncInProgress());
    try {
      await _syncService.retryFailedSyncs();

      final status = await _syncService.getSyncStatus();

      emit(SyncSuccess(status: status));
    } catch (e) {
      _logger.severe('Failed Sync Retry', e);

      final status = await _syncService.getSyncStatus();
      emit(SyncFailure(e.toString(), status: status));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
