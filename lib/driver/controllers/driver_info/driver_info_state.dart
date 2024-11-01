part of 'driver_info_cubit.dart';

sealed class DriverInfoState {}

final class DriverInfoInitial extends DriverInfoState {}
final class DriverInfoLoading extends DriverInfoState {}
final class DriverInfoLoaded extends DriverInfoState {}
final class DriverInfoError extends DriverInfoState {}
