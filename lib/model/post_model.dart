import 'like.dart';
import 'comment.dart';
import 'share.dart';

class Post {

  final String? id;

  // Description of the post
  final String? postDescription;

  // Image link of the post
  final String? image;

  // Time of the post
  final String postedAt;

  // No of Likes
  final List<Like>? likes;

  // No of comments
  final List<Comment>? comments;

  // No of Shares
  final List<Share>? shares;

  final String postedBy;

  // Location of the post, It will be optional
  // final String? postLocation;

  // Id's of persons who are tagged on the post
  // final List<String>? tag;

  // Feeling of the post
  // final String? feeling;

  // List of User Id's who reported the post
  final List<String>? report;


  Post({
    this.id,
    this.postDescription,
    this.image,
    required this.postedBy,
    required this.postedAt,
    this.likes,
    this.comments,
    this.shares,
    this.report,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postedBy': postedBy,
      'postDescription': postDescription,
      'image': image,
      'postedAt': postedAt,
      'likes': likes?.map((like) => like.toJson()).toList(),
      'comments': comments?.map((comment) => comment.toMap()).toList(),
      'shares': shares?.map((share) => share.toMap()).toList(),
      'report': report,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      postedBy: map['postedBy'],
      postDescription: map['postDescription'],
      image: map['image'],
      postedAt: map['postedAt'],
      likes: (map['likes'] as List<dynamic>)
          .map((like) => Like.fromJson(like as Map<String, dynamic>))
          .toList(),
      comments: (map['comments'] as List<dynamic>)
          .map((comment) => Comment.fromMap(comment as Map<String, dynamic>))
          .toList(),
      shares: (map['shares'] as List<dynamic>)
          .map((share) => Share.fromMap(share as Map<String, dynamic>))
          .toList(),
      report: (map['report'] as List<dynamic>).map((r) => r.toString()).toList(),
    );
  }
}
