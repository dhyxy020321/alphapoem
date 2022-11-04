import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';

const int tSampleRate = 16000;
typedef _Fn = void Function();

class langtao extends StatefulWidget {
  const langtao({Key? key}) : super(key: key);

  @override
  _langtaoState createState() => _langtaoState();
}
class _langtaoState extends State<langtao> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String? _mPath;

  StreamSubscription? _mRecordingDataSubscription;
  Map datas={};
  String langhua="请语音输入诗句，将返回对应诗词以及译文";

  Future<void> _openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _mRecorder!.openAudioSession();
    setState(() {
      _mRecorderIsInited = true;
    });
  }
  @override
  void initState() {
    super.initState();
    // Be careful : openAudioSession return a Future.
    // Do not access your FlutterSoundPlayer or FlutterSoundRecorder before the completion of the Future
    _mPlayer!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
    _openRecorder();
  }

  @override
  void dispose() {
    stopPlayer();
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    stopRecorder();
    _mRecorder!.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }
  Future<IOSink> createFile() async {
    var tempDir = await getTemporaryDirectory();
    _mPath = '${tempDir.path}/flutter_sound_example.pcm';
    var outputFile = File(_mPath!);
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }
    return outputFile.openWrite();
  }


  // ----------------------  Here is the code to record to a Stream ------------

  Future<void> record() async {
    assert(_mRecorderIsInited && _mPlayer!.isStopped);
    var sink = await createFile();
    var recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) {
          if (buffer is FoodData) {
            sink.add(buffer.data!);
          }
        });
    await _mRecorder!.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
    setState(() {});
  }
  // --------------------- (it was very simple, wasn't it ?) -------------------

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }
    _mplaybackReady = true;
  }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    print(_mPath);
    return _mRecorder!.isStopped
        ? record
        : () {
      stopRecorder().then((value) => setState(() {
        _uploadFile();

      }));
    };
  }

  void play() async {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    await _mPlayer!.startPlayer(
        fromURI: _mPath,
        sampleRate: tSampleRate,
        codec: Codec.pcm16,
        numChannels: 1,
        whenFinished: () {
          setState(() {});
        }); // The readability of Dart is very special :-(
    setState(() {});
  }

  Future<void> stopPlayer() async {
    await _mPlayer!.stopPlayer();
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped
        ? play
        : () {
      stopPlayer().then((value) => setState(() {}));
    };
  }

  _uploadFile() async {
    var formData = FormData.fromMap({
      // 'name': 'wendux',
      // 'age': 25,
      'file': await MultipartFile.fromFile('/data/user/0/com.example.alpha_poem/cache/flutter_sound_example.pcm',
          filename: 'flutter_sound_example.pcm')
    });
    var response = await Dio().post('http://101.43.253.189:22000/tao', data: formData);
    setState(() {
      datas=json.decode(response.data);
      if(datas["output"]!=null){
        langhua=datas['output'];}
      else{
        langhua="未找到结果，请从新输入";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/background/b.jpg",
              ),
              fit: BoxFit.fill
          )
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //Image.asset("assets/background/huang.jpg"),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 40,
                leading: IconButton(

                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

              ),
              body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: const Image(image: AssetImage('assets/title/dalang.png'),),
                    ),
                    Row(),
                    Container(
                      height: 340.0,
                      width: MediaQuery.of(context).size.width - 40.0,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(150,250, 240, 230),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child:CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: <Widget>[
                          SliverList(
                            delegate:SliverChildListDelegate(
                              [
                                SizedBox(height: 10,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  child:Text(langhua,style: TextStyle(fontSize: 20),),
                                  alignment: Alignment.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: 144,
                      width: 144,
                      child: MaterialButton(
                        child: Image.asset(_mRecorder!.isRecording ? 'assets/chat/microb.png':'assets/chat/micow.png'),
                        onPressed: getRecorderFn(),
                        color: Color.fromARGB(180,80,80,80),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(72)
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(height: 20,
                      decoration: const BoxDecoration(color: Color.fromARGB(150,250, 240, 230)),
                      child: Text(_mRecorder!.isRecording
                          ? 'Play in progress'
                          : 'Player is stopped'),)
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
