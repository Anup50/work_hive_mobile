import 'package:equatable/equatable.dart';

class JobDescriptionEntity extends Equatable {
  final String summary;
  final List<String> responsibilities;

  const JobDescriptionEntity({
    required this.summary,
    required this.responsibilities,
  });

  @override
  List<Object?> get props => [summary, responsibilities];
}
