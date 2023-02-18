import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double g;

  const Gap({Key? key, required this.g}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: g,
      width: g,
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement,
            size: 150.0,
            color: Colors.orangeAccent,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Text('Oops!, No Record Found',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  // color: Colors.orangeAccent,
                )),
          ),
        ],
      ),
    );
  }
}
