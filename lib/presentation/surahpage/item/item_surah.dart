import 'package:flutter/material.dart';
import 'package:my_equran/domain/entities/surah_entity.dart';

class ItemSurah extends StatefulWidget {
  final SurahEntity surahEntity;
  final Function() onTap;

  const ItemSurah({super.key, required this.surahEntity, required this.onTap});

  @override
  State<ItemSurah> createState() => _ItemSurahState();
}

class _ItemSurahState extends State<ItemSurah> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.surahEntity.id.toString()}.",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.surahEntity.namaLatin,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('arti: '+widget.surahEntity.arti, style: TextStyle(fontStyle: FontStyle.italic),)
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.surahEntity.nama,
                      style: TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
