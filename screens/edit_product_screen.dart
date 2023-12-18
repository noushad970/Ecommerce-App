import 'package:e_shop_today/providers/product.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _discriptionNode = FocusNode();
  final _ImageUrlController = TextEditingController();
  final _imageUrlFocusedNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', Discription: '', imageUrl: '', price: 0);

  @override
  void initState() {
    _ImageUrlController.addListener(_UpdateImgUrl);
    super.initState();
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

  void _UpdateImgUrl() {
    if (!_imageUrlFocusedNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.Discription);
    print(_editedProduct.imageUrl);
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
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: value.toString(),
                          Discription: _editedProduct.Discription,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_discriptionNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          Discription: _editedProduct.Discription,
                          imageUrl: _editedProduct.imageUrl,
                          price: double.parse(value!));
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _discriptionNode,
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
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
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
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
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: '',
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
