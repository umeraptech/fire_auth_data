import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_login/model/user_detail.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserDetailsDao{
  final _databaseReference = FirebaseDatabase.instance.ref("users_details");

  Query getMessageQuery(){
    if(!kIsWeb){
      FirebaseDatabase.instance.setPersistenceEnabled(true);
    }
    return _databaseReference;
  }

  void saveUsers(UserDetails users){
    _databaseReference.push().set(users.toJson());
  }

  void deleteUser(String key){
    _databaseReference.child(key).remove();
  }

  void updateUser(String key, UserDetails users){
    _databaseReference.child(key).update(users.toMap());
  }

}