import 'package:whisper/model/share.dart';
import 'comment.dart';
import 'event.dart';
import 'like.dart';

class Post {
  // Description of the post
  final String? postDescription;

  // Image link of the post
  final String? image;

  // Time of the post
  final String postedAt;

  // No of Likes
  final List<Like> likes;

  // No of comments
  final List<Comment> comments;

  // No of Shares
  final List<Share> shares;

  // Location of the post, It will be optional
  final String? postLocation;

  // Id's of persons who are tagged on the post
  final List<String> tag;

  // Feeling of the post
  final String feeling;

  // Is this post an event
  final Event? event;

  // List of User Id's who reported the post
  final List<String> report;

  Post({
    this.postDescription,
    this.image,
    required this.postedAt,
    this.likes = const [],
    this.comments = const [],
    this.shares = const [],
    this.postLocation,
    this.tag = const [],
    this.feeling = '',
    this.event,
    this.report = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'postDescription': postDescription,
      'image': image,
      'postedAt': postedAt,
      'likes': likes.map((like) => like.toJson()).toList(),
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'shares': shares.map((share) => share.toMap()).toList(),
      'postLocation': postLocation,
      'tag': tag,
      'feeling': feeling,
      'event': event?.toMap(),
      'report': report,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
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
      postLocation: map['postLocation'],
      tag: (map['tag'] as List<dynamic>).map((tag) => tag.toString()).toList(),
      feeling: map['feeling'],
      event: Event.fromMap(map['event'] as Map<String, dynamic>),
      report: (map['report'] as List<dynamic>).map((r) => r.toString()).toList(),
    );
  }
}