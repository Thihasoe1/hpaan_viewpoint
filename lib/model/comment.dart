import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String postId;
  final String uid;
  final String name;
  final String userName;
  final String message;
  final Timestamp timestamp;

  // Constructor
  Comment({
    required this.id,
    required this.postId,
    required this.uid,
    required this.name,
    required this.userName,
    required this.message,
    required this.timestamp,
  });

  // Factory method to create an instance of Comment from a JSON map
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      id: doc['id'] as String,
      postId: doc['postId'] as String,
      uid: doc['uid'] as String,
      name: doc['name'] as String,
      userName: doc['userName'] as String,
      message: doc['message'] as String,
      timestamp: doc['timestamp'] as Timestamp,
    );
  }

  // Method to convert an instance of Comment to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'uid': uid,
      'name': name,
      'userName': userName,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
