import 'package:whisper/model/post_model.dart';
import 'package:whisper/model/share.dart';
import 'event.dart';
import 'like.dart';

class Comment {

  // Comment Id
  final String id;

  // User Id who is commented
  final String commentBy;

  // User Id who's post
  final String postedBy;

  // Time of comment
  final String createdAt;

  // Comment Message
  final String content;

  // List of replies on that particular comment
  final List<Comment> reply;

  // Id of user who is replied, by default it will be empty
  final String? repliedOn;

  // List of User Id's who are reported on this comment
  final List<String>? report;

  // By default it will be 0, if 1 then that comment will be blocked by the Post of the user
  final int block;

  Comment({
    required this.id,
    required this.commentBy,
    required this.postedBy,
    required this.createdAt,
    required this.content,
    required this.reply,
    this.repliedOn,
    this.report,
    this.block = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'commentBy': commentBy,
      'postedBy': postedBy,
      'createdAt': createdAt,
      'content': content,
      'reply': reply.map((r) => r.toMap()).toList(),
      'repliedOn': repliedOn,
      'report': report,
      'block': block,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      commentBy: map['commentBy'],
      postedBy: map['postedBy'],
      createdAt: map['createdAt'],
      content: map['content'],
      reply: (map['reply'] as List<dynamic>)
          .map((r) => Comment.fromMap(r as Map<String, dynamic>))
          .toList(),
      repliedOn: map['repliedOn'],
      report: (map['report'] as List<dynamic>).map((r) => r.toString()).toList(),
      block: map['block'] ?? 0,
    );
  }
}