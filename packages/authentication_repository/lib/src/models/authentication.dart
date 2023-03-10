// Packages & Dependencies or Helper function
import 'package:equatable/equatable.dart';

class Authentication extends Equatable {
  const Authentication(this.token);

  final String token;

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return 'Authentication{token: $token}';
  }
}
