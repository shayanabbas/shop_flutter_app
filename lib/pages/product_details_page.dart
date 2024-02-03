import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:shop_flutter_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'].toString(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product['imageUrl'] as String,
              height: 250,
            ),
          ),
          const Spacer(flex: 2),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            backgroundColor: (selectedSize == size)
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            label: Text(
                              size.toString(),
                              style: TextStyle(
                                color: (selectedSize == size)
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedSize == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a size'),
                          ),
                        );
                        return;
                      }
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart({
                        'id': widget.product['id'],
                        'title': widget.product['title'],
                        'price': widget.product['price'],
                        'imageUrl': widget.product['imageUrl'],
                        'company': widget.product['company'],
                        'size': selectedSize,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to cart'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
