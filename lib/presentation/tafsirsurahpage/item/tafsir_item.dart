import 'package:flutter/material.dart';
import 'package:my_equran/domain/entities/tafsir_entity.dart';

class TafsirItem extends StatelessWidget {
  final TafsirEntity tafsirEntity;
  const TafsirItem({super.key, required this.tafsirEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(
          color: Colors.purple.withOpacity(0.4),
          width: 2.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.6),
                shape: BoxShape.rectangle,
              ),
              child: Center(child: Text(tafsirEntity.ayat.toString(),style: TextStyle(color: Colors.white),))
          ),
          SizedBox(height: 10,),
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
