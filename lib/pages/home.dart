import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../dao/authentication_helper.dart';
import '../dao/users_dao.dart';
import '../model/users.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final userDao = UserDao();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String key="";
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  bool editStatus =false;


  @override
  void initState() {
    // TODO: implement initState
    final connectedReference = widget.userDao.getMessageQuery();
    connectedReference.keepSynced(true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_)=>_scrollToBottom());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Firebase Demo"),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Error in loading data");
          }else{
            return Column(
              children: <Widget>[
                Padding(
                padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: "Enter Name"),
                  ),
                ),
                const SizedBox(height: 5.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(hintText: "Enter Comment"),
                  ),
                ),
                const SizedBox(height: 5.0,),
                _getMessageList(),
                const SizedBox(height: 5.0,),

              ],
            );
          }
        },
      ),
      // this is unofficial
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _addData(_nameController.value.text,_commentController.value.text);
        },
        child: const Icon(Icons.add),
      ),

    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Home Page"),
    //   ),
    //   body: Center(
    //     child: Container(
    //       color: Colors.black45,
    //       child: TextButton(
    //         onPressed: () {
    //           _signOut();
    //         },
    //         child: const Text("Logout Login"),
    //       ),
    //     ),
    //   ),
    // );
  }

  void _addData(String name, String comment){
    final user = Users(name: name.toUpperCase(), comment: comment.toLowerCase());

    switch(editStatus){
      case false:
        widget.userDao.saveUsers(user);
        break;
      case true:
        widget.userDao.updateUser(key, user);
        editStatus = false;
        break;
    }

    _cleadData();


  }


  Widget _getMessageList(){
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: widget.userDao.getMessageQuery(),
        itemBuilder: (context,snapshot,animation,index){
          final json = snapshot.value as Map<dynamic,dynamic>;
          final users =  Users.fromJson(json);
          return Card(
            child: ListTile(
              title: Text(users.name),
              subtitle: Text(users.comment),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: (){
                        key = snapshot.key as String;
                        _nameController.text=users.name;
                        _commentController.text=users.comment;
                        editStatus = true;

                      },
                      icon: const Icon(Icons.edit)
                  ),
                  IconButton(
                      onPressed: (){
                        setState(() {
                            key = snapshot.key as String;
                            print("Select key is $key");
                            deleteUser(key);
                        });
                      },
                      icon: const Icon(Icons.delete)
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }
  
  void _scrollToBottom(){
    if(_scrollController.hasClients){
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void deleteUser(String key){
    widget.userDao.deleteUser(key);
  }

   void _cleadData(){
    _nameController.clear();
    _commentController.clear();
   }


  void _signOut(){
    AuthenticationHelper().signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
}
