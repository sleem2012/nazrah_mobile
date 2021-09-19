import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 10));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Bahij',
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        Text(
          "• ",
          style: TextStyle(
            fontFamily: 'Bahij',
            fontSize: 20,
            color: Colors.black,
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}

class UnorderedListMobile extends StatelessWidget {
  UnorderedListMobile(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListMobileItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 10));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListMobileItem extends StatelessWidget {
  UnorderedListMobileItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Bahij',
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        Text(
          "• ",
          style: TextStyle(
            fontFamily: 'Bahij',
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
