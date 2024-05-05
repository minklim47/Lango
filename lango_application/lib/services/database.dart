import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// To create a new Firestore instance, call the instance getter on FirebaseFirestore:
// FirebaseFirestore firestore = FirebaseFirestore.instance;

// By default, this allows you to interact with Firestore using the default Firebase App
// used whilst installing FlutterFire on your platform. If however you'd like to use 
//Firestore with a secondary Firebase App, use the instanceFor method:
FirebaseApp langoApp = Firebase.app('lango');
FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: langoApp);
