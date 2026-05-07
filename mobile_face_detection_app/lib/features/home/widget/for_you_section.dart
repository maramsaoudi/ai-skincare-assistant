import 'package:flutter/material.dart';

import 'product_card.dart';

class ForYouSection extends StatelessWidget {
  const ForYouSection({super.key});

  static const primary = Color(0xFFF06090);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "For You",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "See all",
              style: TextStyle(color: primary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ProductCard(
                title: "Vitamin C Serum",
                subtitle: "Radiance Boost",
                price: "\$24",
              ),
              ProductCard(
                title: "Hydra Cream",
                subtitle: "24h Moisture",
                price: "\$32",
              ),
              ProductCard(
                title: "Cleanser",
                subtitle: "pH Balanced",
                price: "\$18",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
