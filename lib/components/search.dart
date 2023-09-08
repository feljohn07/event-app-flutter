import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchField extends StatefulWidget {

  String? query;

  SearchField({Key? key, this.query}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController queryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: queryController,
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        labelText: 'Search',
      ),
      onChanged: (text) {
        if (text.isEmpty) {
          setState(() {
            widget.query = text;
          });
        }
      },
      onSubmitted: (value) {
        setState(() {
          widget.query = value;
        });
      },
    );
  }
}
