import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:todolist/todo_data.dart';
import 'package:todolist/todo_management.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(children: [
        Container(
          child: Column(
            children: [
              Text(
                "Todo List:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Provider.of<ToDoManangement>(context)
                      .getData()
                      .length, // Liste eleman sayısı
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.white,
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: ListTile(
                            title: Text(
                              Provider.of<ToDoManangement>(context)
                                  .getData()[index]
                                  .title,
                              style: TextStyle(
                                  decoration:
                                      Provider.of<ToDoManangement>(context)
                                              .getData()[index]
                                              .isDone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                            ),
                            leading: IconButton(
                                onPressed: () {
                                  Provider.of<ToDoManangement>(context,
                                          listen: false)
                                      .toggleCompletion(index);
                                },
                                icon: Icon(Provider.of<ToDoManangement>(context)
                                        .getData()[index]
                                        .isDone
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank)),
                            trailing: IconButton(
                                onPressed: () {
                                  Provider.of<ToDoManangement>(context,
                                          listen: false)
                                      .deleteData(index);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.purple,
                                )),
                          ),
                        ),
                        Divider(
                          color: Colors.purple.shade100,
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _controller,
                  decoration:
                      InputDecoration(labelText: "Yapıcak işi giriniz..."),
                ),
              )),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<ToDoManangement>(context, listen: false)
                        .addData(
                            TodoData(title: _controller.text, isDone: false));
                    _controller.clear();
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(60, 60),
                      elevation: 10,
                      backgroundColor: Colors.purple.shade300),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.purple.shade300,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 30,
          ),
          Text("Nazife Atmaca"),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/avatar.jpg"),
          )
        ],
      ),
    );
  }
}
