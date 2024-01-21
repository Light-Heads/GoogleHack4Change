import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:frontend/controllers/products_controller.dart';
import 'package:frontend/models/productmodel.dart';
import 'package:frontend/pallete.dart';
import 'package:get/get.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:line_icons/line_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController product = Get.put(ProductController());
  TextEditingController searchController = TextEditingController();
  String selectedSortOption = 'Default'; // Default is just a placeholder

  @override
  Widget build(BuildContext context) {
    final productList = product.products.value;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            onPressed: () {
              // Implement search functionality here
              // You may need to update your ProductController to handle search
            },
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.shopping_cart_outlined),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlutterCarousel.builder(
              options: CarouselOptions(
                // padEnds: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
              ),
              itemCount: 5,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                          child: Card(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          productList[productList.length - itemIndex - 5]
                                  .imageURL ??
                              ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )),
            ),
            // Sorting dropdown button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 8), child: Icon(Icons.sort)),
                  DropdownButton<String>(
                    hint: Text('Sort by: '),
                    icon: Icon(Icons.arrow_drop_down),
                    value: selectedSortOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSortOption = newValue!;
                      });
                      // Implement sorting here
                      // You may need to update your ProductController to handle sorting
                      product.sortProducts(selectedSortOption);
                    },
                    items: <String>[
                      'Default',
                      'Price: Low to High',
                      'Price: High to Low',
                      'Brand: A to Z',
                      'Brand: Z to A',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            // Product grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  ProductModel productItem = productList[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: size.height * 0.2,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(productItem.imageURL ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.24,
                                      child: Text(
                                        productItem.title ?? '',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                            '₹ ${productItem.price?.substring(0, productItem.price!.length - 3)}')),
                                    Container(
                                        child:
                                            Text('${productItem.brand ?? ''}')),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(LineIcons.addToShoppingCart))
                              ],
                            ),
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
