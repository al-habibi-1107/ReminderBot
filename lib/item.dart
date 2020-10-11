class Item {
  int _id;
  String _itemName;
  double _price;
  int _quantity;

  Item(this._id, this._itemName, this._price, this._quantity);

  // setters
  set id(int id) {
    this._id = id;
  }

  set itemName(String itemName) {
    this._itemName = itemName;
  }

  set price(double price) {
    this._price = price;
  }

  set quantity(int quantity) {
    this._quantity = quantity;
  }

  // getters

  int get id => this._id;
  String get itemName => this._itemName;
  double get price => this._price;
  int get quantity => this._quantity;

}
