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

    comments.value = commentSnapshot.docs.map((doc) => doc.data()).toList();
  }

  void addComment(String postId, String commentText) async {
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
}
