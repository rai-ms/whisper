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
  final String? repliedBy;

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
    this.repliedBy,
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
      'repliedBy': repliedBy,
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
      repliedBy: map['repliedBy'],
      report: (map['report'] as List<dynamic>).map((r) => r.toString()).toList(),
      block: map['block'] ?? 0,
    );
  }
}

final List<Comment> dummyComments = [
  Comment(
    id: '1',
    commentBy: 'UserA',
    postedBy: 'UserB',
    createdAt: '2023-08-01',
    content: "This is a great post!",
    reply: [],
  ),
  Comment(
    id: '2',
    commentBy: 'UserC',
    postedBy: 'UserA',
    createdAt: '2023-08-02',
    content: "I agree, it's an awesome post.",
    reply: [],
  ),
  Comment(
    id: '3',
    commentBy: 'UserB',
    postedBy: 'UserC',
    createdAt: '2023-08-03',
    content: "Thanks for the kind words!",
    reply: [],
  ),
  Comment(
    id: '4',
    commentBy: 'UserD',
    postedBy: 'UserA',
    createdAt: '2023-08-04',
    content: "This post needs more attention!",
    reply: [],
  ),
  Comment(
    id: '5',
    commentBy: 'UserE',
    postedBy: 'UserD',
    createdAt: '2023-08-05',
    content: "I've shared it with my friends.",
    reply: [],
  ),
  Comment(
    id: '6',
    commentBy: 'UserF',
    postedBy: 'UserA',
    createdAt: '2023-08-06',
    content: "Great discussion here!",
    reply: [],
  ),
  Comment(
    id: '7',
    commentBy: 'UserB',
    postedBy: 'UserF',
    createdAt: '2023-08-07',
    content: "I learned a lot from this post.",
    reply: [],
  ),
  Comment(
    id: '8',
    commentBy: 'UserC',
    postedBy: 'UserA',
    createdAt: '2023-08-08',
    content: "This is one of the best posts I've seen.",
    reply: [],
  ),
  Comment(
    id: '9',
    commentBy: 'UserG',
    postedBy: 'UserA',
    createdAt: '2023-08-09',
    content: "I'm a fan of your work!",
    reply: [],
  ),
  Comment(
    id: '10',
    commentBy: 'UserD',
    postedBy: 'UserA',
    createdAt: '2023-08-10',
    content: "Keep up the good work!",
    reply: [
      Comment(
        id: '10-1',
        commentBy: 'UserH',
        postedBy: 'UserD',
        createdAt: '2023-08-10T12:30:00',
        content: "Thank you!",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-2',
        commentBy: 'UserI',
        postedBy: 'UserD',
        createdAt: '2023-08-10T12:45:00',
        content: "You're an inspiration.",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-3',
        commentBy: 'UserJ',
        postedBy: 'UserD',
        createdAt: '2023-08-10T13:00:00',
        content: "I'm a big fan of your work!",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-4',
        commentBy: 'UserK',
        postedBy: 'UserD',
        createdAt: '2023-08-10T14:15:00',
        content: "Can you share your creative process?",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-5',
        commentBy: 'UserL',
        postedBy: 'UserD',
        createdAt: '2023-08-10T15:30:00',
        content: "I'd love to learn from you.",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-6',
        commentBy: 'UserM',
        postedBy: 'UserD',
        createdAt: '2023-08-10T16:45:00',
        content: "You're a role model for many.",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-7',
        commentBy: 'UserN',
        postedBy: 'UserD',
        createdAt: '2023-08-10T18:00:00',
        content: "I admire your dedication.",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-8',
        commentBy: 'UserO',
        postedBy: 'UserD',
        createdAt: '2023-08-10T19:15:00',
        content: "Your work inspires me.",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-9',
        commentBy: 'UserP',
        postedBy: 'UserD',
        createdAt: '2023-08-10T20:30:00',
        content: "Can I connect with you on social media?",
        repliedBy: 'UserA',
        reply: [],
      ),
      Comment(
        id: '10-10',
        commentBy: 'UserQ',
        postedBy: 'UserD',
        createdAt: '2023-08-10T21:45:00',
        content: "You're doing amazing work!",
        repliedBy: 'UserA',
        reply: [],
      ),
    ],
  ),

];