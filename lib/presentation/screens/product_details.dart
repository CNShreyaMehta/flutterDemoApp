import 'package:demo_app/presentation/screens/product_tile.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
    final Product productInfo;

  const ProductDetails({super.key, required this.productInfo});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    // Fetch the passed arguments (product data)
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productInfo.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.productInfo.imageLink,
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              widget.productInfo.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.productInfo.price}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 8),
            if (widget.productInfo.rating != null)
              Row(
                children: [
                  Text(
                    widget.productInfo.rating.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                ],
              ),
            // Add more product details here as needed
          ],
        ),
      ),
    );
  }
}
