import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sql/db_handler.dart';
import 'package:sql/user.dart';

import 'dumy_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'My Notes',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  late  Future<List<NotesModel>> cartList ;
  DBHelper? dbHelper ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper() ;
    loadData();

  }

  loadData ()async{

    cartList =  dbHelper!.getCartListWithUserId() ;
  }

  // setState(() {
  // dbHelper!.deleteProduct(snapshot.data![index].id!);
  // cartList = dbHelper!.getCartListWithUserId() ;
  // });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: cartList,
        builder: (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: ()async{

                      await dbHelper!.updateQuantity(
                          NotesModel(id: snapshot.data![index].id!,title: 'Asif Taj tech', age: 11, description: 'USA')
                      );
                      setState(() {
                      cartList = dbHelper!.getCartListWithUserId() ;
                      });
                    },
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding:const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Icon(Icons.delete_forever),
                      ),
                      key: ValueKey<int>(snapshot.data![index].id!),
                      onDismissed: (DismissDirection direction) async {
                        setState(() {
                          dbHelper!.deleteProduct(snapshot.data![index].id!);
                          cartList = dbHelper!.getCartListWithUserId() ;
                          snapshot.data!.remove(snapshot.data![index]);
                        });

                      },
                      child: Container(
                        child: Card(
                            child: ListTile(
                              horizontalTitleGap: 3,
                              minVerticalPadding: 5,
                              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              title: Text(snapshot.data![index].title , style: TextStyle(color: Colors.black ,fontSize: 18, fontWeight: FontWeight.bold),),
                              subtitle: Text(snapshot.data![index].description.toString() , style: TextStyle(color: Colors.black , fontWeight: FontWeight.normal)),
                            )),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dbHelper!.insert(
              NotesModel(
                  description: 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
                  title: 'Lorem Ipsum',
                  age: 12
              )
          ).then((value){
            print('added');
          }).onError((error, stackTrace) {
            print("error"+error.toString());
          });
          setState(() {
            cartList = dbHelper!.getCartListWithUserId() ;
          });

        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
