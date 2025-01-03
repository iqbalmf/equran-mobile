import 'package:flutter/material.dart';
import 'package:my_equran/domain/entities/ayat_entity.dart';

class AyatItem extends StatelessWidget {
  final AyatEntity ayatEntity;
  final bool isPlayAudio;

  const AyatItem(
      {super.key, required this.ayatEntity, this.isPlayAudio = false});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Center(
                      child: Text(
                    ayatEntity.nomorAyat.toString(),
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                  ))),
              Row(
                children: [
                  isPlayAudio
                      ? Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 20,
                          ))
                      : Container(),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: isPlayAudio
                          ? Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 20,
                            )
                          : Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 20,
                            )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ayatEntity.textArab,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                Text(
                  ayatEntity.textLatin,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.right,
                )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            ayatEntity.textIndonesia,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
