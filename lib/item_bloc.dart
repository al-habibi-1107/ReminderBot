import 'dart:async';

import './item.dart';

class ItemBloc{

// List of Items
List<Item> _itemList=[
Item(1, "Pizza", 26, 1),
Item(2, "Doughnut", 12, 1),
Item(3, "Cake", 8, 1),
Item(4, "Biscuit", 18, 1),
Item(5, "Banana", 10, 1)
];

// all the stream controllers
final _itemListStreamController = StreamController<List<Item>>();

final _itemQuantityIncrementController= StreamController<Item>();

final _itemQuantityDecrementController= StreamController<Item>();

// the stream and sink getters
Stream<List<Item>> get itemListStream => _itemListStreamController.stream;

StreamSink<List<Item>> get itemListSink => _itemListStreamController.sink;
  
StreamSink<Item> get itemQuantityIncrementSink => _itemQuantityIncrementController.sink;

StreamSink<Item> get itemQuantityDecrementSink => _itemQuantityDecrementController.sink;

// Constructor
ItemBloc(){

  _itemListStreamController.add(_itemList);

  _itemQuantityIncrementController.stream.listen(incrementQuantity);

  _itemQuantityDecrementController.stream.listen(decrementQuantity);

}

// increment logic
incrementQuantity(Item item){
  // get the price and quantity
  double price = item.price;
  // increment quanitity
  int quantity =item.quantity+1;

  // make changes in the quantity
  _itemList[item.id-1].quantity=quantity;
  // make changes in the price
  _itemList[item.id-1].price= price*quantity;

  // make the changes as an input to the list sink
  // and make the listener work
  itemListSink.add(_itemList);
}

// decrement logic
decrementQuantity(Item item){

double price =item.price;

int quantity= item.quantity-1;

_itemList[item.id-1].quantity=quantity;
_itemList[item.id-1].price= price*quantity;

itemListSink.add(_itemList);


}



// dispose function to close all controllers
dispose(){
  _itemListStreamController.close();
  _itemQuantityIncrementController.close();
  _itemQuantityDecrementController.close();
}


}