import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A customizable card widget for displaying product information.
class ProductCard extends StatefulWidget {
  /// The unique identifier of the product.
  final String? id;

  /// The URL of the product image.
  final String imageUrl;

  /// A short description of the product.
  final String? shortDescription;

  /// The category name of the product.
  final String categoryName;

  /// The name of the product.
  final String productName;

  /// The price of the product.
  final double price;

  /// The currency symbol used for the price.
  final String currency;

  /// A callback function triggered when the card is tapped.
  final VoidCallback? onTap;

  /// A callback function triggered when the favorite button is pressed.
  final VoidCallback? onFavoritePressed;

  /// Indicates whether the product is available.
  final bool? isAvailable;

  /// The background color of the card.
  final Color cardColor;

  /// The text color used for labels and descriptions.
  final Color textColor;

  /// The border radius of the card.
  final double borderRadius;

  /// The rating of the product (optional).
  final double? rating;

  /// The discount percentage of the product (optional).
  final double? discountPercentage;

  /// The number of products sold (optional).
  final int? soldCount;

  /// Creates a [ProductCard] widget.
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    required this.productName,
    required this.price,
    this.currency = '\$',
    this.onTap,
    this.onFavoritePressed,
    this.shortDescription = '',
    this.id,
    this.isAvailable = true,
    this.cardColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
    this.borderRadius = 12.0,
    this.rating,
    this.discountPercentage,
    this.soldCount,
  });

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        elevation: 4,
        color: widget.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image and favorite button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    height: 170,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        height: 170,
                        width: double.infinity,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isAdded = !_isAdded;
                      });
                      if (widget.onFavoritePressed != null) {
                        widget.onFavoritePressed!();
                      }
                    },
                    icon: Icon(
                      _isAdded
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                      color: _isAdded ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                    ),
                  ),
                  if (widget.shortDescription!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        widget.shortDescription!,
                        style: TextStyle(
                          color: widget.textColor.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  if (widget.rating != null || widget.soldCount != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Row(
                        children: [
                          if (widget.rating != null) ...[
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                          if (widget.rating != null &&
                              widget.soldCount != null) ...[
                            const SizedBox(width: 8),
                            const Text(
                              '·',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          if (widget.soldCount != null)
                            Text(
                              '${_formatSoldCount(widget.soldCount!)} terjual',
                              style: TextStyle(
                                fontSize: 14,
                                color: widget.textColor.withOpacity(0.7),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.isAvailable!)
                        const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Available',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      if (!widget.isAvailable!)
                        const Row(
                          children: [
                            Icon(
                              Icons.do_disturb_alt_rounded,
                              color: Colors.red,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Out of Stock',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      if (widget.discountPercentage != null)
                        Text(
                          '${widget.discountPercentage?.toStringAsFixed(0)}% OFF',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${widget.currency}${_formatPrice(widget.price)}',
                      style: TextStyle(
                        color: widget.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSoldCount(int soldCount) {
    if (soldCount >= 1000) {
      return '${(soldCount / 1000).floor()}rb+';
    }
    return '$soldCount+';
  }

  String _formatPrice(double price) {
    // Format angka dengan pemisah ribuan
    return NumberFormat.decimalPattern('id').format(price);
  }
}
