import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FavButton extends StatefulWidget{
  final String documentId;
  final CollectionReference collection;

  const FavButton({required this.documentId, required this.collection, super.key});

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool isFav = false;

  @override
  void initState(){
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    DocumentSnapshot documentSnapshot = await widget.collection.doc(widget.documentId).get();
    if (documentSnapshot.exists){
      setState(() {
        isFav = documentSnapshot['isFav'] ?? false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isFav = !isFav;
    });
    await widget.collection.doc(widget.documentId).update({'isFav': isFav});
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.grey,
      ),
      onPressed: _toggleFavorite,
      );
  }
}


