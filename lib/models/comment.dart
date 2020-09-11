import 'package:firebase_database/firebase_database.dart';

class Comment {
  String id;
  String userId;
  String comment;
  String productId;
  DateTime date;

  Comment({
      this.id,
      this.date,
      this.userId,
      this.comment,
      this.productId});

      
  Comment.map(dynamic obj) {
    this.id = obj['id'];
    this.date = obj['date'];
    this.comment = obj['comment'];
    this.userId = obj['userId'];
    this.productId = obj['productId'];
  }

  

  Comment.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    date = snapshot.value['date'];
    comment = snapshot.value['comment'];
    userId = snapshot.value['userId'];
    comment = snapshot.value['comment'];
  }
}
