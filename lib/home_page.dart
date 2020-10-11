import 'package:flutter/material.dart';

import './item_bloc.dart';
import './item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instance of itembloc
  ItemBloc _itemBloc = ItemBloc();

  // the dispose function closes all streams when not is use
  // prevents memory leak
  @override
  void dispose() {
    _itemBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 111, 87, 1),
        title: Text("Reminder Bot"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color.fromRGBO(31, 60, 136, 1),
                        elevation: 4,
                        shadowColor: Color.fromRGBO(31, 60, 136, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "${snapshot.data[index].itemName} ",
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                "x ${snapshot.data[index].quantity}",
                                style: TextStyle(fontSize: 12,color: Colors.white),
                              ),
                            ),
                            Container(
                              child: Text(
                                " ${snapshot.data[index].price}",
                                style: TextStyle(fontSize: 18,color: Colors.white),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.add, color: Colors.green),
                                onPressed: () {
                                  _itemBloc.itemQuantityIncrementSink.add(snapshot.data[index]);
                                }),
                            IconButton(
                                icon: Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  _itemBloc.itemQuantityDecrementSink.add(snapshot.data[index]);
                                }),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
          },
          stream: _itemBloc.itemListStream,
        ),
      ),
    );
  }
}
