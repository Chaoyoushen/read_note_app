import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class Fetch extends LoginEvent{
  @override
  String toString() =>'fetch';
}
