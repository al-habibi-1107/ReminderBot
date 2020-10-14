import 'package:flutter/material.dart';

import 'item.dart';
import 'item_bloc.dart';

class ExpandTile extends StatefulWidget {
  // an item bloc that will be passed as parameter to constructor
  final ItemBloc _itemBloc;
  // Consturctor
  ExpandTile(this._itemBloc);

  @override
  _ExpandTileState createState() => _ExpandTileState();
}

class _ExpandTileState extends State<ExpandTile> {


  // dispose method to dispose the bloc
  @override
  void dispose() {
    widget._itemBloc.dispose();
    super.dispose();
  }

  // formKey to control form
  final _formKey = GlobalKey<FormState>();
  

  String itemName;
  double price;
  int quantity;

  // A function to validate and save the form
  void _submitForm() {
    // check validity
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      // validate
      _formKey.currentState.save();
      // find index of new item
      int index =widget._itemBloc.itemCount() + 1;
      print(index);
      // add item
      widget._itemBloc.addItem(Item(index, itemName, price, quantity));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return ExpansionTile(
       key: GlobalKey(),
      title: Text(" Add a new Entry"),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromRGBO(238, 111, 87, 1),
                      )),
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(238, 111, 87, 1),
                      ),
                      labelText: "Item Name",
                      border: OutlineInputBorder()),
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
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromRGBO(238, 111, 87, 1),
                          )),
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(238, 111, 87, 1),
                          ),
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
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromRGBO(238, 111, 87, 1),
                        )),
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(238, 111, 87, 1),
                        ),
                        labelText: "Quantity",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        FlatButton(
          color: Color.fromRGBO(31, 60, 136, 1),
          child: Text(
            "Add Item",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: _submitForm,
        ),
      ],
    );
  }
}
