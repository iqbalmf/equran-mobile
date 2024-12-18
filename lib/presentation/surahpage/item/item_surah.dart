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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.surahEntity.namaLatin,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.surahEntity.deskripsi,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.place, size: 13, color: Colors.black),
                      SizedBox(
                        width: 8,
                      ),
                      Text(widget.surahEntity.tempatTurun),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
