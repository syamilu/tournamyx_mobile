import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? getCurrentUserId() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  return user?.uid;
}

Future<bool> updateFavoriteTeam(
    String? teamID, String teamCategory, String? teamName) async {
  try {
    String? userID = getCurrentUserId();
    if (userID == null) {
      print('User ID is null, user might not be logged in.');
      return false;
    }
    if (teamID == null) {
      print(
          'Team ID is null, cannot update the favorite team without a team ID.');
      return false;
    }

    // Reference to Firestore
    FirebaseFirestore db = FirebaseFirestore.instance;

    // Fetch the single document in the favoriteTeam collection for the user
    QuerySnapshot querySnapshot = await db
        .collection('users')
        .doc(userID)
        .collection('favoriteTeam')
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // No document found, handle accordingly (e.g., create a new document)
      print('No favorite team document found, creating a new one.');
      await db.collection('users').doc(userID).collection('favoriteTeam').add({
        'teamID': teamID,
        'teamCategory': teamCategory,
        'teamName':
            teamName ?? 'Default Team Name', // Provide a default name if null
        'tourName': 'iiumrc',
      });
    } else {
      // Get the document reference
      DocumentReference favoriteTeamDoc = querySnapshot.docs.first.reference;

      // Update the favoriteTeam document
      await favoriteTeamDoc.set(
          {
            'teamID': teamID,
            'teamCategory': teamCategory,
            'teamName': teamName,
            'tourName': 'iiumrc',
          },
          SetOptions(
              merge:
                  true)); // Using merge option to update fields without overwriting the entire document

      print('Favorite team updated successfully.');
    }
    return true;
  } catch (e) {
    print('Error updating favorite team: $e');
    return false;
  }
}
