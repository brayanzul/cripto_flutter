import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoinCard extends StatelessWidget {
  String name;
  String symbol;
  String image;
  double price;
  double change;
  double changePercentage;
  int rank;

  CoinCard({
    super.key, 
    required this.name, 
    required this.symbol,
    required this.image,
    required this.price,
    required this.change,
    required this.changePercentage,
    required this.rank
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide()
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(image),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          color: Colors.black.withOpacity(.30),
                          child: Center(
                            child: Text(
                              rank.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          symbol.toUpperCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price.toDouble().toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    change.toDouble() < 0 
                      ? change.toDouble().toStringAsFixed(3)
                      : '+' + change.toDouble().toStringAsFixed(3),
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    changePercentage.toDouble() < 0
                      ? changePercentage.toDouble().toString() + '%'
                      : '+' + changePercentage.toDouble().toString() + '%',
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
