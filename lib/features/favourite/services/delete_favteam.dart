import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? getCurrentUserId() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  return user?.uid;
}

Future<bool> deleteFavoriteTeam() async {
  try {
    String? userID = getCurrentUserId();
    if (userID == null) {
      print('User ID is null, user might not be logged in.');
      return false;
    }

    FirebaseFirestore db = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection('users')
        .doc(userID)
        .collection('favoriteTeam')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document's reference
      DocumentReference documentReference = querySnapshot.docs.first.reference;

      // Delete the document
      await documentReference.delete();
      print("Favorite team document deleted successfully.");
    } else {
      print("No favorite team document found to delete.");
    }

    print('Favorite team deleted successfully');
    return true;
  } catch (e) {
    print('Error deleting favorite team: $e');
    return false;
  }
}
