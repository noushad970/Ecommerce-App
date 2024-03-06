import 'package:e_shop_today/Admin/ProductGridsAdmin.dart';
import 'package:e_shop_today/Widgets/App_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class AdminProductOverviewScreen extends StatefulWidget {
  static const routeName = '/admin-product-overview-screen';
  @override
  _AdminProductOverviewScreenState createState() =>
      _AdminProductOverviewScreenState();
}

class _AdminProductOverviewScreenState
    extends State<AdminProductOverviewScreen> {

  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).AdminfetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //  final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Control'),
          backgroundColor: Color.fromARGB(255, 0, 187, 255),
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : productGridAdmin());
  }
}
