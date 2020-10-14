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

  final _formKey = GlobalKey<FormState>();

  String itemName;
  double price;
  int quantity;

  void _submitForm() {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      int index = ItemBloc().itemCount() + 1;
      print(index);
      _itemBloc.addItem(Item(index, itemName, price, quantity));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 111, 87, 1),
        title: Text("Reminder Bot"),
      ),
      body: Column(
        children: [
          ExpansionTile(
            title: Text(" Add a new Entry"),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: device.width * 0.9,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter an Item Name";
                          } else
                            return null;
                        },
                        onSaved: (value) {
                          itemName = value;
                        },
                        key: ValueKey("itemName"),
                        decoration: InputDecoration(
                            labelText: "Item Name",
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 10),
                          width: device.width * 0.5,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: ValueKey("price"),
                            validator: (value) {
                              if (value.isEmpty || double.parse(value) == 0) {
                                return "Enter a Valid Price";
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              price = double.parse(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Price",
                                border: const OutlineInputBorder()),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: device.width * 0.3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: ValueKey("quantity"),
                            validator: (value) {
                              if (value.isEmpty || int.parse(value) == 0) {
                                return "Enter a Valid quantity";
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              quantity = int.parse(value);
                            },
                            decoration: InputDecoration(
                                labelText: "Quantity",
                                border: const OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FlatButton(
                child: Text("Add Item"),
                onPressed: _submitForm,
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
                builder:
                    (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                  return snapshot.data == null
                      ? Container()
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color.fromRGBO(31, 60, 136, 1),
                              elevation: 4,
                              shadowColor: Color.fromRGBO(31, 60, 136, 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "${snapshot.data[index].itemName} ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "x ${snapshot.data[index].quantity}",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      " ${snapshot.data[index].price}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                  IconButton(
                                      icon:
                                          Icon(Icons.add, color: Colors.green),
                                      onPressed: () {
                                        _itemBloc.itemQuantityIncrementSink
                                            .add(snapshot.data[index]);
                                      }),
                                  IconButton(
                                      icon:
                                          Icon(Icons.remove, color: Colors.red),
                                      onPressed: () {
                                        _itemBloc.itemQuantityDecrementSink
                                            .add(snapshot.data[index]);
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
          ),
        ],
      ),
    );
  }
}
