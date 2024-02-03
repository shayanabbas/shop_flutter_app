import 'package:flutter/material.dart';
import 'package:shop_flutter_app/global_variables.dart';
import 'package:shop_flutter_app/widgets/product_card.dart';
import 'package:shop_flutter_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Sneakers',
    'Boots',
    'Heels',
    'Sandals',
  ];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Shoes \nCollection',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final filter = filters[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Chip(
                    backgroundColor: (selectedFilter == filter)
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    label: Text(
                      filter,
                      style: TextStyle(
                        color: selectedFilter == filter
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 1080) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ProductDetailsPage(product: product);
                      })),
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Colors.white,
                      ),
                    );
                  });
            } else {
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ProductDetailsPage(product: product);
                    })),
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      backgroundColor: index.isEven
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.white,
                    ),
                  );
                },
              );
            }
          }),
        ),
      ]),
    );
  }
}
