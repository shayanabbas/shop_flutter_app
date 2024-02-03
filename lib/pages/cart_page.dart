import 'package:flutter/material.dart';
import 'package:shop_flutter_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
            ),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              'Size: ${cartItem['size']}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Remove Item'),
                        content: const Text(
                            'Do you want to remove this item from the cart?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .removeFromCart(cartItem);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
            ),
          );
        },
      ),
    );
  }
}
