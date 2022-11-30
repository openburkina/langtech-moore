import 'dart:convert';
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
import 'package:langtech_moore_mobile/enum/etat.dart';
import 'package:langtech_moore_mobile/enum/type_traduction.dart';
import 'package:langtech_moore_mobile/models/langue.dart';
import 'package:langtech_moore_mobile/models/source_donnee.dart';
import 'package:langtech_moore_mobile/models/traduction.dart';
import 'package:langtech_moore_mobile/services/http.dart';
import 'package:langtech_moore_mobile/widgets/dataTranslate/data_translate_action.dart';
import 'package:langtech_moore_mobile/widgets/dataTranslate/langue_form_fied.dart';
import 'package:langtech_moore_mobile/widgets/loginPage/button_section.dart';
import 'package:langtech_moore_mobile/widgets/shared/toast.dart';
import 'package:permission_handler/permission_handler.dart';

class DataTranslate extends StatefulWidget {
  final SourceDonnee sourceDonnee;
  final String action;
  final Traduction? updateTraduction;
  const DataTranslate({
    super.key,
    required this.sourceDonnee,
    this.action = 'CREATE',
    this.updateTraduction,
  });

  @override
  State<DataTranslate> createState() => _DataTranslate(
        sourceDonnee: sourceDonnee,
        action: action,
        updateTraduction: updateTraduction,
      );
}

class _DataTranslate extends State<DataTranslate> {
  final SourceDonnee sourceDonnee;
  final String action;
  final Traduction? updateTraduction;
  late bool isEnableText = false;
  late bool isEnableAudio = false;

  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isRecorderFinished = false;
  bool isStartRecorder = false;
  bool isAudioPayed = false;
  final recordingPlayer = AssetsAudioPlayer();
  AudioPlayer player = AudioPlayer();
  String pathToAudio = '';
  int maxDuration = 100;
  int currentDuration = 0;
  String currentDurationLabel = "00:00";
  var textTranslateController = TextEditingController();

  final List<SelectedListItem> _listLanguages = [];
  late Traduction traduction = new Traduction();
  String languePlaceholderText = "Sélectionner la langue";
  List<Langue> _langues = [];

  _DataTranslate({
    required this.sourceDonnee,
    required this.action,
    required this.updateTraduction,
  });

  @override
  void initState() {
    super.initState();
    _initData();
    getLangues();
    initRecorder();
  }

  void _initData() {
    if (action == 'UPDATE') {
      traduction = updateTraduction!;
      languePlaceholderText = "${traduction.langue?.libelle}";

      if (traduction.type == 'AUDIO') {
        isEnableAudio = true;
      } else {
        isEnableText = true;
        textTranslateController.text = traduction.contenuTexte!;
      }
    }
  }

  void getLangues() {
    Http.getLangues().then((value) {
      _langues = value;
      value.forEach((langue) {
        _listLanguages.add(
          SelectedListItem(
            name: "${langue.libelle}",
            value: "${langue.id}",
          ),
        );
      });
    });
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
    isRecorderFinished = false;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future startRecorder() async {
    if (!isRecorderReady) return;

    setState(() {
      isRecorderFinished = false;
    });

    if (recordingPlayer.isPlaying.value) {
      await stopAudio();
    }

    await recorder.startRecorder(toFile: 'audio.mp4');
  }

  Future stopRecorder() async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    setState(() {
      pathToAudio = path;
      isRecorderFinished = true;
      isAudioPayed = false;
      // ignore: avoid_print
      print('Recorded audio path: $pathToAudio');
      // ignore: avoid_print
      print('Recorded audio file: $audioFile');
    });
  }

  Future<void> playAudio() async {
    await recordingPlayer.open(
      Audio.file(pathToAudio),
      autoStart: true,
      showNotification: true,
      volume: 1,
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
    recordingPlayer.playOrPause();
    setState(() {
      isAudioPayed = true;
    });
  }

  void _getTranslateInfos() {
    traduction.libelle = sourceDonnee.libelle;
    traduction.sourceDonnee = sourceDonnee;
    traduction.etat = Etat.EN_ATTENTE.name;
    traduction.note = 0;
    if (traduction.langue == null) {
      Toast.showFlutterToast(
          context, "Veuillez choisir la langue à traduire !", 'warning');
    } else if (isEnableText) {
      if (textTranslateController.text.isEmpty) {
        Toast.showFlutterToast(
            context, "Veuillez saisir la traduction textuelle !", 'warning');
      } else {
        traduction.contenuTexte = textTranslateController.text;
        traduction.type = TypeTraduction.TEXTE.name;
        traduction.contenuAudio = null;
        _saveTranslate();
      }
    } else if (isEnableAudio) {
      log("LANGUE ==> ${traduction.langue?.libelle}");
      if (pathToAudio == '') {
        Toast.showFlutterToast(
            context, "Veuillez enregistrer la traduction !", "warning");
      } else {
        traduction.contenuAudioContentType = 'audio/mp4';
        traduction.contenuTexte = null;
        traduction.type = TypeTraduction.AUDIO.name;
        var fileContent = File(pathToAudio).readAsBytesSync();
        var fileContentBase64 = base64.encode(fileContent);
        traduction.contenuAudio = fileContentBase64;
        _saveTranslate();
      }
    } else {
      Toast.showFlutterToast(
          context, "Veuillez choisir le type de traduction !", "warning");
    }
  }

  void _saveTranslate() {
    Http.onSaveTraduction(traduction).then((response) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        Toast.showFlutterToast(
          context,
          "Traduction ${!isEnableAudio && isEnableText ? 'texte' : 'audio'} enregistrée avec succès !",
          "success",
        );
        Navigator.pop(context, true);
      } else {
        Toast.showFlutterToast(
          context,
          "Une erreur est survenue lors l'enregistrement de la traduction !",
          "error",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: Text(
          'Traduction de la données',
          style: GoogleFonts.montserrat(),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ButtonSection(
          buttonFonction: _getTranslateInfos,
          buttonText: isEnableAudio || isEnableText ? "Enregistrer ${!isEnableAudio && isEnableText ? 'un texte' : 'un audio'}" : "Enregistrer",
          buttonSize: 16,
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
          function: openLangueModal,
          languePlaceholderText: languePlaceholderText,
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
            controller: textTranslateController,
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

  void openLangueModal() {
    DropDownState(
      DropDown(
        isSearchVisible: false,
        bottomSheetTitle: Text(
          "Choisir la langue à traduire",
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
              Langue selectedLangue = new Langue();
              selectedLangue.id = int.parse(item.value!);
              selectedLangue.libelle = item.name;
              setState(() {
                traduction.langue = selectedLangue;
                languePlaceholderText = item.name;
              });
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
          LangueFormField(
            function: openLangueModal,
            languePlaceholderText: languePlaceholderText,
          ),
          const SizedBox(
            height: 20,
          ),
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
                await stopRecorder();
              } else {
                await startRecorder();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          isRecorderFinished ? playRecorderPart() : Container(),
        ],
      ),
    );
  }

  Widget playRecorderPart() {
    return Column(
      children: [
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

              return Slider(
                min: 0.0,
                max: playing2.duration.inMilliseconds.toDouble() - 0.01,
                value: position!.inMilliseconds.toDouble() ==
                        playing2.duration.inMilliseconds.toDouble()
                    ? 0.0
                    : position.inMilliseconds.toDouble(),
                onChanged: (double value) {
                  log("Slider ==> $value");
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
              !isAudioPayed
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: kBlue,
                      ),
                      onPressed: () {
                        if (pathToAudio != '') {
                          if (!isAudioPayed) {
                            playAudio();
                          } else {
                            stopAudio();
                          }
                        }
                      },
                      icon: Icon(Icons.play_arrow),
                      label: Text("Ecouter l'enregistrement"),
                    )
                  : ElevatedButton.icon(
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
                      label: Text("Arrêter l'audio"),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
