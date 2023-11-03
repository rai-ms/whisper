// class Comment {
//
//   // Comment Id
//   final String id;
//
//   // User Id who is commented
//   final String commentBy;
//
//   // User Id who's post
//   final String postedBy;
//
//   // Time of comment
//   final String createdAt;
//
//   // Comment Message
//   final String content;
//
//   // List of replies on that particular comment
//   final List<Comment> reply;
//
//   // Id of user who is replied, by default it will be empty
//   final String? repliedOn;
//
//   // List of User Id's who are reported on this comment
//   final List<String>? report;
//
//   // By default it will be 0, if 1 then that comment will be blocked by the Post of the user
//   final int block;
//
//   Comment({
//     required this.id,
//     required this.commentBy,
//     required this.postedBy,
//     required this.createdAt,
//     required this.content,
//     required this.reply,
//     this.repliedOn,
//     this.report,
//     this.block = 0,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'commentBy': commentBy,
//       'postedBy': postedBy,
//       'createdAt': createdAt,
//       'content': content,
//       'reply': reply.map((r) => r.toMap()).toList(),
//       'repliedOn': repliedOn,
//       'report': report,
//       'block': block,
//     };
//   }
//
//   factory Comment.fromMap(Map<String, dynamic> map) {
//     return Comment(
//       id: map['id'],
//       commentBy: map['commentBy'],
//       postedBy: map['postedBy'],
//       createdAt: map['createdAt'],
//       content: map['content'],
//       reply: (map['reply'] as List<dynamic>)
//           .map((r) => Comment.fromMap(r as Map<String, dynamic>))
//           .toList(),
//       repliedOn: map['repliedOn'],
//       report: (map['report'] as List<dynamic>).map((r) => r.toString()).toList(),
//       block: map['block'] ?? 0,
//     );
//   }
// }

class CommentPayload {
  String comment;
  CommentPayload({required this.comment});

  Map<String, dynamic> toMap() {
    return {'comment': comment};
  }
}

class APIResponseCommentModel {
  final int statusCode;
  final String type;
  final Data? data; // Make 'data' nullable

  APIResponseCommentModel({
    required this.statusCode,
    required this.type,
    this.data, // Mark 'data' as nullable
  });

  factory APIResponseCommentModel.fromJson(Map<String, dynamic> json) {
    return APIResponseCommentModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<APIResponseComment>? comments; // Make 'comments' nullable

  Data({this.comments}); // Mark 'comments' as nullable

  factory Data.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? commentsList =
        json['Comments']; // Make 'commentsList' nullable
    final List<APIResponseComment>? comments = commentsList?.map((commentJson) {
      return APIResponseComment.fromJson(commentJson);
    }).toList();

    return Data(comments: comments);
  }
}

class APIResponseComment {
  final String id;
  final String comment;
  final APIResponseUser user;

  APIResponseComment({
    required this.id,
    required this.comment,
    required this.user,
  });

  factory APIResponseComment.fromJson(Map<String, dynamic> json) {
    return APIResponseComment(
      comment: json['comment'],
      id: json['_id'],
      user: APIResponseUser.fromJson(json['User']),
    );
  }
}

class APIResponseUser {
  final String id;
  final String username;
  final String email;
  String? profilePic;

  APIResponseUser({
    required this.id,
    required this.username,
    required this.email,
    this.profilePic,
  });

  factory APIResponseUser.fromJson(Map<String, dynamic> json) {
    return APIResponseUser(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profilePic: json['profilePic'],
    );
  }
}
