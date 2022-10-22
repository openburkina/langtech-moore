import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:langtech_moore_mobile/constants/colors.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/widgets/dataTranslate/data_translate_action.dart';
import 'package:langtech_moore_mobile/widgets/dataTranslate/langue_form_fied.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:permission_handler/permission_handler.dart';

class DataTranslate extends StatefulWidget {
  final SourceDonnee sourceDonnee;
  const DataTranslate({
    super.key,
    required this.sourceDonnee,
  });

  @override
  State<DataTranslate> createState() => _DataTranslate(
        sourceDonnee: sourceDonnee,
      );
}

class _DataTranslate extends State<DataTranslate> {
  final SourceDonnee sourceDonnee;
  late bool isEnableText = false;
  late bool isEnableAudio = false;

  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isStartRecorder = false;
  bool isAudioPayed = false;
  final recordingPlayer = AssetsAudioPlayer();
  AudioPlayer player = AudioPlayer();
  String pathToAudio = '';
  int maxDuration = 100;
  int currentDuration = 0;
  String currentDurationLabel = "00:00";

  final List<SelectedListItem> _listLanguages = [
    SelectedListItem(
      name: "MOORE",
      value: "MOORE",
    ),
    SelectedListItem(
      name: "DIOULA",
      value: "DIOULA",
    ),
    SelectedListItem(
      name: "FULFUDE",
      value: "FULFUDE",
    ),
    SelectedListItem(
      name: "GULMATCHE",
      value: "GULMATCHE",
    ),
  ];

  _DataTranslate({
    required this.sourceDonnee,
  });

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw "Microphone permission not allowed !";
    }

    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    if (!isRecorderReady) return;

    await recorder.startRecorder(toFile: 'audio.mp4');
  }

  Future stop() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    setState(() {
      pathToAudio = path;
      // ignore: avoid_print
      print('Recorded audio path: $pathToAudio');
      // ignore: avoid_print
      print('Recorded audio file: $audioFile');
    });
  }

  Future<void> playAudio() async {
    recordingPlayer.open(
      Audio.file(pathToAudio),
      autoStart: true,
      showNotification: true,
    );

    setState(() {
      isAudioPayed = true;
    });
  }

  Future<void> stopAudio() async {
    recordingPlayer.stop();
    setState(() {
      isAudioPayed = false;
    });
  }

  Future<void> pauseAudio() async {
    recordingPlayer.pause();
    setState(() {
      isAudioPayed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: Text(
          'Traduction de la données',
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ButtonSection(
          buttonFonction: () {},
          buttonText: "Enregistrer",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                child: Text(
                  'Données à traduire',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    color: kBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kGris,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: kBlue,
                    width: 2,
                  ),
                ),
                child: Text(
                  '${sourceDonnee.libelle}',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: kBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DataTranslateAction(
                isEnableAudio: isEnableAudio,
                isEnableText: isEnableText,
                textFunction: () {
                  setState(() {
                    isEnableAudio = false;
                    isEnableText = true;
                  });
                },
                audioFunction: () {
                  setState(() {
                    isEnableAudio = true;
                    isEnableText = false;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              !isEnableAudio && isEnableText
                  ? textTranslateForm()
                  : Container(),
              isEnableAudio && !isEnableText ? audioPart() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textTranslateForm() {
    return Column(
      children: [
        LangueFormField(
          function: onTextFieldTap,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kGris,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: kBlue,
              width: 2,
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Entrez la traduction',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 18,
                color: kBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: GoogleFonts.montserrat(
              fontSize: 18,
              color: kBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isSearchVisible: false,
        bottomSheetTitle: Text(
          "Langue de traduction",
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: kBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        submitButtonChild: Text(
          'Fermer',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            color: kBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        data: _listLanguages,
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              setState(() {});
              list.add(item.name);
            }
          }
        },
      ),
    ).showModal(context);
  }

  Widget audioPart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<RecordingDisposition>(
            stream: recorder.onProgress,
            builder: (context, snapshot) {
              final duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;
              maxDuration = duration.inSeconds;

              String twoDigits(int n) => n.toString().padLeft(1);

              final twoDigitsMinutes =
                  twoDigits(duration.inMinutes.remainder(60));
              final twoDigitsSeconds =
                  twoDigits(duration.inSeconds.remainder(60));
              return Text(
                "${twoDigitsMinutes.length < 2 ? '0$twoDigitsMinutes' : twoDigitsMinutes}:${twoDigitsSeconds.length < 2 ? '0$twoDigitsSeconds' : twoDigitsSeconds}",
                style: const TextStyle(
                  fontSize: 50,
                  color: kBlue,
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white.withOpacity(0),
              elevation: 0,
            ),
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: kBlue.withOpacity(0.4),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kBlue.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kBlue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    isStartRecorder ? Icons.stop : Icons.mic,
                    size: 75,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onPressed: () async {
              setState(() {
                isStartRecorder = !isStartRecorder;
              });
              if (recorder.isRecording) {
                await stop();
              } else {
                await record();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<Duration>(
            stream: recordingPlayer.currentPosition,
            builder: (context, snapshot) {
              if (!snapshot.hasData || !recordingPlayer.current.hasValue) {
                return Slider(
                  value: 0.0,
                  onChanged: (double value) => null,
                  activeColor: kBlue,
                  inactiveColor: kRed,
                );
              }

              if (recordingPlayer.current.value == null) {
                return Slider(
                  value: 0.0,
                  onChanged: (double value) => null,
                  activeColor: kBlue,
                  inactiveColor: kRed,
                );
              } else {
                final PlayingAudio playing2 =
                    recordingPlayer.current.value!.audio;
                final Duration? position = snapshot.data;
                // bool _finish = _assetsAudioPlayer.finished.value;

                // print(playing2);

                return Slider(
                  min: 0.0,
                  max: playing2.duration.inMilliseconds.toDouble() - 0.01,
                  value: position!.inMilliseconds.toDouble() ==
                          playing2.duration.inMilliseconds.toDouble()
                      ? 0.0
                      : position.inMilliseconds.toDouble(),
                  onChanged: (double value) {
                    recordingPlayer.seek(Duration(milliseconds: value.toInt()));
                    value = value;
                  },
                  onChangeEnd: (double value) {},
                  activeColor: kBlue,
                  inactiveColor: kRed,
                );
              }
            },
          ),
          Container(
            child: Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: kBlue,
                  ),
                  onPressed: () {
                    if (pathToAudio != '') {
                      if (recordingPlayer.isPlaying.value) {
                        pauseAudio();
                      } else {
                        playAudio();
                      }
                    }
                  },
                  icon: Icon(isAudioPayed ? Icons.pause : Icons.play_arrow),
                  label: Text(isAudioPayed ? "Pause" : "Jouer"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: kRed,
                  ),
                  onPressed: () {
                    if (pathToAudio != '') {
                      if (isAudioPayed) {
                        stopAudio();
                      }
                    }
                  },
                  icon: Icon(Icons.stop),
                  label: Text("Arrêter"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
