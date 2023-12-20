import 'package:e_shop_today/providers/product.dart';
import 'package:e_shop_today/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _discriptionNode = FocusNode();
  // ignore: non_constant_identifier_names
  final _ImageUrlController = TextEditingController();
  final _imageUrlFocusedNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', Discription: '', imageUrl: '', price: 0);

  var _initValue = {
    'title': '',
    'discription': '',
    'imageUrl': '',
    'price': ''
  };

  var _isInit = true;

  @override
  void initState() {
    _ImageUrlController.addListener(_UpdateImgUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (!_isInit) {
    //   return;
    // }
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      // ignore: unnecessary_null_comparison
      if (!productId.isEmpty) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(productId);

        _initValue = {
          'title': _editedProduct.title,
          'discription': _editedProduct.Discription,
          'imageUrl': '',
          'price': _editedProduct.price.toString(),
        };
        _ImageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusedNode.removeListener(_UpdateImgUrl);
    _priceFocusNode.dispose();
    _discriptionNode.dispose();
    _ImageUrlController.dispose();
    _imageUrlFocusedNode.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  void _UpdateImgUrl() {
    if (!_imageUrlFocusedNode.hasFocus) {
      if ((!_ImageUrlController.text.startsWith('http') &&
              !_ImageUrlController.text.startsWith('https')) ||
          (!_ImageUrlController.text.endsWith('.png') &&
              !_ImageUrlController.text.endsWith('.jpg') &&
              !_ImageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate(); //

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .UpdateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    initialValue: _initValue['title'],
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          title: value.toString(),
                          Discription: _editedProduct.Discription,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValue['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_discriptionNode);
                    },
                    //this widget is use to display the error input given by a user in input field or form field.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter valid price';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Enter price greater than zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          title: _editedProduct.title,
                          Discription: _editedProduct.Discription,
                          imageUrl: _editedProduct.imageUrl,
                          price: double.parse(value!));
                    },
                  ),
                  TextFormField(
                    initialValue: _initValue['discription'],
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _discriptionNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter discription';
                      }
                      if (value.length <= 10) {
                        return 'Please enter Atleast 10 characters';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          title: _editedProduct.title,
                          Discription: value.toString(),
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price);
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(top: 15, right: 30),
                        decoration: BoxDecoration(
                            //  border: Border.all(width: 1, color: Colors.grey),
                            ),
                        child: _ImageUrlController.text.isEmpty
                            ? Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(_ImageUrlController.text),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'ImageURL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _ImageUrlController,
                          focusNode: _imageUrlFocusedNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter ImageURL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid image URL';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg')) {
                              return 'Please enter a valid image URL';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: _editedProduct.id,
                                isFavourite: _editedProduct.isFavourite,
                                title: _editedProduct.title,
                                Discription: _editedProduct.Discription,
                                imageUrl: value.toString(),
                                price: _editedProduct.price);
                          },
                        ),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}
