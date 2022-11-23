import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';

class PlayAudio extends StatefulWidget {
  final Traduction traduction;
  PlayAudio({
    Key? key,
    required this.traduction,
  }) : super(key: key);

  @override
  State<PlayAudio> createState() => _PlayAudioState(
        traduction: traduction,
      );
}

class _PlayAudioState extends State<PlayAudio> {
  final Traduction traduction;
  final recordingPlayer = AssetsAudioPlayer();
  late final PlayerController playerController;
  String? path;
  late Directory directory;

  late bool isAudioPlayed = false;

  _PlayAudioState({
    required this.traduction,
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kWhite,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: _onPlayOrStopAudio,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: isAudioPlayed ? kRed : kBlue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                isAudioPlayed ? Icons.stop : Icons.play_arrow,
                color: kWhite,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${isAudioPlayed ? 'Arrêter l\'audio' : 'Ecouter l\'enregistrement'}",
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isAudioPlayed ? kRed : kBlue,
            ),
          ),
        ],
      ),
    );
  }

  void _onPlayOrStopAudio() {
    if (isAudioPlayed) {
      stopAudio();
    } else {
      playAudio();
    }
  }

  Future<void> playAudio() async {
    directory = await getApplicationDocumentsDirectory();
    path = "${directory.path}/audio.mp4";
    log("directory ==> $directory");
    log("PATH ==> $path");
    Uint8List decodedbytes = base64.decode(traduction.contenuAudio!);
    File decodedimgfile =
        await File("/data/user/0/bf.openburkina.langtechapp/cache/audio.mp4")
            .writeAsBytes(decodedbytes);
    await recordingPlayer.open(
      Audio.file(decodedimgfile.path),
      autoStart: true,
      showNotification: true,
      volume: 1,
    );

    setState(() {
      isAudioPlayed = true;
    });
  }

  Future<void> stopAudio() async {
    recordingPlayer.stop();
    setState(() {
      isAudioPlayed = false;
    });
  }
}
