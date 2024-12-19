import 'package:flutter/material.dart';
import 'package:my_equran/domain/entities/tafsir_entity.dart';

class TafsirItem extends StatelessWidget {
  final TafsirEntity tafsirEntity;
  const TafsirItem({super.key, required this.tafsirEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(
          color: Colors.purple.withOpacity(0.4),
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(tafsirEntity.ayat.toString(),style: TextStyle(color: Colors.white),))
          ),
          Text(
            tafsirEntity.text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
