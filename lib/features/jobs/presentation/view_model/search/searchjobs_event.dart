part of 'searchjobs_bloc.dart';

sealed class SearchjobsEvent extends Equatable {
  const SearchjobsEvent();

  @override
  List<Object?> get props => [];
}

class SearchjobsQueryEvent extends SearchjobsEvent {
  final String query;

  const SearchjobsQueryEvent(this.query);

  @override
  List<Object?> get props => [query];
}
