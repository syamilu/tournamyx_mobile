import 'package:tournamyx_mobile/features/favourite/model/favourite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // Assuming you're using Flutter for UI.

String? getCurrentUserId() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  return user?.uid;
}

Future<List<FavouriteTeamModel>> fetchUserFavouriteTeams() async {
  try {
    String? userId = getCurrentUserId();
    if (userId == null) {
      throw UserNotLoggedInException();
    }
    final querySnapshot = await getUserFavouriteTeamsCollection(userId).get();
    return querySnapshot.docs
        .map((doc) => FavouriteTeamModel.fromJson(
            doc.data() as Map<String, dynamic>? ?? {}))
        .toList();
  } on FirebaseException catch (firebaseException) {
    // Check for specific FirebaseException related to connection issues
    if (firebaseException.code == 'unavailable') {
      debugPrint(
          "Connection issue: Unable to establish connection to Firebase.");
      // Optionally, you could retry the operation here or inform the user to check their internet connection
    } else {
      debugPrint(
          "Failed to fetch favourite teams due to Firebase exception: ${firebaseException.message}");
    }
    throw FetchFavouriteTeamsException(
        "Failed to fetch favourite teams: ${firebaseException.message}");
  } catch (e) {
    debugPrint("Failed to fetch favourite teams: $e");
    throw FetchFavouriteTeamsException("Failed to fetch favourite teams: $e");
  }
}

CollectionReference<Map<String, dynamic>> getUserFavouriteTeamsCollection(
    String userId) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('favouriteTeams');
}

class UserNotLoggedInException implements Exception {
  final String message;
  UserNotLoggedInException([this.message = "User not logged in"]);
  @override
  String toString() => message;
}

class FetchFavouriteTeamsException implements Exception {
  final String message;
  FetchFavouriteTeamsException(this.message);
  @override
  String toString() => message;
}
