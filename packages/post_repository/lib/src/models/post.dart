import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post(this.id, this.name);

  final int id;
  final String? name;

  @override
  List<Object> get props => [id];

  static const empty = Post(0, null);
}
