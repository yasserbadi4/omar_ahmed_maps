// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:omar_ahmed_maps/constants/my_colors.dart';

import 'package:omar_ahmed_maps/data/models/place_suggestions.dart';

class PlaceItem extends StatelessWidget {
  final PlaceSuggestions suggestions;
  const PlaceItem({
    Key? key,
    required this.suggestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subTitle = suggestions.description
        .replaceAll(suggestions.description.split(',')[0], '');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.lightBlue,
              ),
              child: Icon(
                Icons.place,
                color: MyColors.blue,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${suggestions.description.split(',')[0]}\n',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: subTitle.substring(2),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
