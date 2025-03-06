import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? name;

  const UserEntity({
    this.userId,
    this.name,
  });

  @override
  List<Object?> get props => [
        userId,
        name,
      ];
}
