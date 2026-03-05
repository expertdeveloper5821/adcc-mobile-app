import 'package:flutter/material.dart';

class StoreProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onTap;

  const StoreProductGrid({
    super.key,
    required this.products,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 172 / 252,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return _StoreProductCard(
          product: product,
          onTap: () => onTap(product),
        );
      },
    );
  }
}

class _StoreProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const _StoreProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 172,
        height: 252,
        decoration: BoxDecoration(
          color: Color(0xFFFFF9EF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product['image'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                /// LOCATION BADGE
                Positioned(
                  top: 12,
                  left: 7,
                  child: Container(
                    height: 21,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(22.5),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/location.png",
                          height: 11.98,
                          width: 11.98,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          product['location'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5
                ),
              ),
            ),

            const SizedBox(height: 4),

            /// PRICE + TIME
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    product['price'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFC12D32),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "•${product['timePosted']}",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xB31A1C20),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 4),

            /// POSTED BY
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Posted by ${product['postedBy']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xB31A1C20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}