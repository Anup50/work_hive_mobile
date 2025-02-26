import 'package:equatable/equatable.dart';

class EmployerEntity extends Equatable {
  final String? employerId;
  final String companyName;
  final String companyLogo;
  final String location;

  const EmployerEntity({
    this.employerId,
    required this.companyName,
    required this.companyLogo,
    required this.location,
  });

  @override
  List<Object?> get props => [employerId, companyName, companyLogo, location];
}
