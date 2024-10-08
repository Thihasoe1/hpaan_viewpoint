import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  var comments = [].obs;
  var isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void fetchComments(String placeId) async {
    var commentSnapshot = await firestore
        .collection('places')
        .doc(placeId)
        .collection('review')
        .orderBy('timestamp', descending: true)
        .get();

    comments.value = commentSnapshot.docs.map((doc) {
      var data = doc.data();
      data['commentId'] = doc.id; // Add the document ID
      return data;
    }).toList();
  }

  void addComment(String postId, String commentText, double rating) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    try {
      isLoading.value = true;
      if (currentUser != null) {
        await firestore
            .collection('places')
            .doc(postId)
            .collection('review')
            .add({
          'userId': currentUser.uid,
          'username': currentUser.displayName,
          'rating': rating,
          'commentText': commentText,
          'timestamp': FieldValue.serverTimestamp(),
        });

        fetchComments(postId); // Refresh comments after adding a new one
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.toString());
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteComment(String postId, String commentId) async {
    var currentUser = FirebaseAuth.instance.currentUser;

    try {
      isLoading.value = true;
      if (currentUser != null) {
        // Get the comment document
        var commentDoc = await firestore
            .collection('places')
            .doc(postId)
            .collection('review')
            .doc(commentId)
            .get();

        // Check if the current user is the owner of the comment
        if (commentDoc.exists && commentDoc['userId'] == currentUser.uid) {
          // Delete the comment
          await firestore
              .collection('places')
              .doc(postId)
              .collection('review')
              .doc(commentId)
              .delete();

          fetchComments(postId); // Refresh comments after deletion
        } else {
          Get.snackbar("Error", "You can only delete your own comments.");
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Firebase Error", e.toString());
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
