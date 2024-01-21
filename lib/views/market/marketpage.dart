import 'package:flutter/material.dart';
import 'package:frontend/controllers/products_controller.dart';
import 'package:frontend/models/productmodel.dart';
import 'package:get/get.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  final ProductController product = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();
  String selectedSortOption = 'Default'; // Default is just a placeholder

  @override
  Widget build(BuildContext context) {
    final productList = product.products.value;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
        actions: [
          IconButton(
            onPressed: () {
              // Implement search functionality here
              // You may need to update your ProductController to handle search
              product.searchProducts(searchController.text);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sorting dropdown button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ),
            SizedBox(height: 16),
            // Product grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  ProductModel productItem = productList[index];
                  return Card(
                    elevation: 4,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            productItem.imageURL ?? '',
                            height: 90,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                
                                child: Text(
                                  productItem.title ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                             
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text('Price: \$${productItem.price ?? ''}')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
