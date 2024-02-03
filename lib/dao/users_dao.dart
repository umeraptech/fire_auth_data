import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_login/model/users.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserDao{
  final _databaseReference = FirebaseDatabase.instance.ref("users");

  Query getMessageQuery(){
    if(!kIsWeb){
      FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _databaseReference;
  }

  void saveUsers(Users users){
    _databaseReference.push().set(users.toJson());
  }

  void deleteUser(String key){
    _databaseReference.child(key).remove();
  }

  void updateUser(String key, Users users){
    _databaseReference.child(key).update(users.toMap());
  }

}