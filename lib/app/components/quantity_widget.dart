import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuantityWidget extends StatefulWidget {
  QuantityWidget({
    super.key,
    required this.quantity,
    required this.result,
  });

  int quantity;
  void Function(int) result;

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                if (widget.quantity > 0) {
                  widget.quantity = widget.quantity - 1;
                }
                widget.result(widget.quantity);
              });
            },
            child: const Icon(Icons.remove, size: 20)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.quantity.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
            onTap: () {
              setState(() {
                widget.quantity = widget.quantity + 1;
                widget.result(widget.quantity);
              });
            },
            child: const Icon(Icons.add, size: 20)),
      ],
    );
  }
}
