import 'package:flutter/material.dart';
import '../model/product.dart';

class SearchPage extends StatefulWidget {
  final List<Product> allProducts;

  const SearchPage({Key? key, required this.allProducts}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = widget.allProducts;
  }

  void _performSearch(String query) {
    List<Product> results = [];
    for (Product product in widget.allProducts) {
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        results.add(product);
      }
    }

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                _performSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(_searchResults[index].name),
                    leading: Image.asset(
                      _searchResults[index].assetName,
                      package: _searchResults[index].assetPackage,
                      width: 40.0, // Set the desired width
                      height: 40.0, // Set the desired height
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
