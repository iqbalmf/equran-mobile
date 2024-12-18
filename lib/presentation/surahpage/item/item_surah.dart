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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.surahEntity.id.toString()}.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
                      Text("diturunkan di:\n${widget.surahEntity.tempatTurun}")
                    ],
                  ),
                  Text(
                    widget.surahEntity.nama,
                    style: TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
