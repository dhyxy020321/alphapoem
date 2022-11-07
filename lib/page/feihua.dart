/// 原生
//import 'package:audioplayers/audio_cache.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_common_templates/lib/lib02/pickers.dart';
import 'package:flutter_common_templates/lib/lib02/style/picker_style.dart';
import 'package:flutter_common_templates/lib/widget/my_text.dart';

/// 第三方
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

///本地
import '../chat_module/bubble.dart'; /// 聊天气泡
import '../chat_module/luyin.dart';

const int tSampleRate = 16000;
typedef _Fn = void Function();
//气球聊天详情页x
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super (key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String? _mPath;
  StreamSubscription? _mRecordingDataSubscription;


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
    player=AudioCache(prefix: '');
    ///初始化视频播放
    /*_controller = VideoPlayerController.network(
        'https://gugu-1300042725.cos.ap-shanghai.myqcloud.com/0_szDjEDn.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setVolume(0);
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();*/

    getHistoryMessages();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        keyboardShowing = true;
        if(emojiShowing){
          setState(() {
            emojiShowing = !emojiShowing;
          });
        }
      } else {
        keyboardShowing = false;
      }
    });

    super.initState();
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
    if(player!=null){
      audioPlayer= null;
    }
    if(audioPlayer!=null){
      audioPlayer=null;
    }
    //_controller.dispose(); //移除监听
    scrollController.dispose();
    super.dispose();
  }
  Map datas={};
  Map datas1={};

  getdata(String flyflow)async{
    var response=await register('200', flyflow);
    setState(() {
      Utf8Decoder decode = new Utf8Decoder();
      datas=json.decode(response?.data);
      _messageList.insert(0,{"messageDirection": 0, "content": datas['yuanju']});
    });
  }


  static Future<Response?> register(String username,String password) async{
    try{
      return await Dio().post("http://101.43.253.189:22000/fly_flower",data:
      {'msg':username,'word':password});//Map or String
    }catch(e){
      print(e);
      return null;
    }
  }
  _uploadFile() async {
    var formData = FormData.fromMap({
      // 'name': 'wendux',
      // 'age': 25,
      'file': await MultipartFile.fromFile('/data/user/0/com.example.alpha_poem/cache/flutter_sound_example.pcm',
          filename: 'flutter_sound_example.pcm')
    });
    var response = await Dio().post('http://101.43.253.189:22000/getmp3', data: formData);
    setState(() {
      datas1=json.decode(response.data);
      _messageList.insert(0,{"messageDirection": 1, "content": datas1['yuanju']});
    });
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
    return _mRecorder!.isStopped
        ? record
        : () {stopRecorder().then(
            (value) => setState(() {
              _uploadFile();
              Future.delayed(Duration(milliseconds: 1000), getdata(feihua));
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
          setState(() {

          });
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
      stopPlayer().then((value) => setState(() {
      }));
    };
  }
  get dropdownValue => null;

  get pickerStyle => null;
  AudioPlayer? audioPlayer ;
  AudioCache? player ;
  AudioPlayer fixedPlayer = new AudioPlayer();
  AudioCache players = AudioCache(fixedPlayer: null);


  /// 用户头像
  Widget userAvatar(img, size){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        radius: size/2,
        backgroundImage: AssetImage(img),
      ),
    );
  }

  /// 通用简单text格式
  singleTextWeight(text, color, fontSize){
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 通用获取安全顶部距离
  Widget safePadding(BuildContext context, color){
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: color,
    );
  }

  /// 隐藏键盘
  void hideKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  ScrollController scrollController = ScrollController();

  /// 消息列表
  var _messageList = [];
  String feihua=' ';
  /// 输入框焦点
  FocusNode focusNode = FocusNode();

  //late VideoPlayerController _controller; //背景视频播放控制器

  //var _visZhifeiji = true; //发送按钮隐藏和显示
  //final bool _isText = true; //true文本输入  false语言输入
  final TextEditingController _messageText = TextEditingController(); //需要初始化的时候赋值用
  bool emojiShowing = false; /// 是否显示表情
  bool keyboardShowing = false; /// 是否显示键盘
  bool isRaise=false;
  List<bool>  isRisnw=[];
  List<String>  sounds=[];
  /// 获取用户历史消息
  getHistoryMessages() async {
    setState(() {
      _messageList = [
        {"messageDirection": 2, "content": "请加油对出更多的诗句"},
        {"messageDirection": 2, "content": "app也会返回一句进行对抗"},
        {"messageDirection": 2, "content": "之后请语音输入与飞花相关诗句"},
        {"messageDirection": 2, "content": "请先选择一个字作为飞花"},
      ];
      sounds=[
        'assets/sounds/hai.mp3',
        'assets/sounds/hahah.mp3',
        'assets/sounds/hai.mp3',
      ];
      isRisnw.length=_messageList.length;
      for(int i=0;i<isRisnw.length;i++){
        isRisnw[i]=false;
      }

    });
  }

  void isRaisdown(){
    for(int i=0;i<isRisnw.length;i++){
      if(isRisnw[i]==true)
        isRisnw[i]=false;
    }
  }
  /*///选中表情
  _onEmojiSelected(Emoji emoji) {
    setState(() {
      _visZhifeiji = false;
    });
    _messageText
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _messageText.text.length));
  }

  ///表情删除按钮
  _onBackspacePressed() {
    _messageText
      ..text = _messageText.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _messageText.text.length));
    if(_messageText.text.isNotEmpty){
      setState(() {
        _visZhifeiji = true;
      });
    }
  }*/
  void _onClickItem(pickerStyle) {
    Pickers.showSinglePicker(context,
        data: ['花','月','风','雨'],
        pickerStyle: pickerStyle=customizeStyle(),
        onConfirm: (p, __) =>setState(() {
          feihua = p;
        }),
        onChanged: (p, __) => setState(() {
          feihua = p;
        }),
        onCancel: (p) => setState(() {
                feihua='';
        }),
    );
  }
  PickerStyle customizeStyle() {
    double menuHeight = 46.0;
    Widget _headMenuView = Container(
        color: Colors.transparent,
        height: menuHeight,
        child: const Center(child: MyText('请选择', color: Colors.white)));

    Widget _cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: const MyText('关闭', color: Colors.white, size: 14),
    );

    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
      child:const MyText('确定', color: Colors.white, size: 14),
    );

    // 头部样式
    Decoration headDecoration =const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)));

    Widget title =const Center(child: MyText('飞花选择', color: Colors.green, size: 14));

    /// item 覆盖样式
    Widget itemOverlay = Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.deepOrangeAccent, width: 0.7)),
      ),
    );

    return PickerStyle(
      menu: _headMenuView,
      menuHeight: menuHeight,
      pickerHeight: 320,
      pickerTitleHeight: 60,
      pickerItemHeight: 50,
      cancelButton: _cancelButton,
      commitButton: _commitButton,
      headDecoration: headDecoration,
      title: title,
      textColor: Colors.amberAccent,
      backgroundColor: Colors.transparent,
      itemOverlay: itemOverlay,
    );
  }

  String url='请选择地区';
  var value;
  /// 头部 Banner
  Widget _buildHeader(context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 30.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/4,
              child: Row(
                children: [
                  GestureDetector(
                    child: const Text("返回"),
                    onTap: ()=>Navigator.of(context).pop(),
                  ),
                  const Expanded(child: Text("")),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/4,
              child: Center(
                child: singleTextWeight("", Colors.white, 16.0),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/4,
              child: const Text(""),
            ),
          ],
        ),
      ),
    );
  }

  /// 渲染聊天内容
  next(_messageRealList, index){
      int c=index;
    return Row(
      children: [
        _messageRealList[index]['messageDirection'] == 1 ? const Expanded(child: Text("")) : userAvatar("assets/chat/touxiang.jpg", 58.0),
        GestureDetector(
          onTap: () async{
               //    if(audioPlayer!=null){
               //        audioPlayer!.stop();
               //        }
               // audioPlayer=await player!.play(sounds[index]);
               //    print('播放成功');
          },
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 128.0
            ),
            child: Bubble(
                direction: _messageRealList[index]['messageDirection'] == 1 ? BubbleDirection.right : BubbleDirection.left,
                color: const Color.fromARGB(120, 240, 255, 255),
                child: Text(
                  "${_messageRealList[index]['content']}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0
                  ),
                ),
            ),
          ),
        ),
        _messageRealList[index]['messageDirection'] != 1 ? const Expanded(child: Text("")) : userAvatar("assets/chat/touxiang.jpg", 58.0),
      ],
    );
  }

  /// 渲染聊天部分
  Widget _chatList(BuildContext context){
    List _messageRealList = _messageList.reversed.toList();
    /*if(scrollController.hasClients && scrollController.position.maxScrollExtent != 0.0){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }*/
    return Column(
      children: [
        safePadding(context, Colors.transparent),
        _buildHeader(context),
        Container(
          height: 80.0,
          width: MediaQuery.of(context).size.width - 40.0,
          decoration: BoxDecoration(
              color: const Color.fromARGB(150,250, 240, 230),
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Center(
            child: Image.asset('assets/title/feihua.png'),
          ),
        ),
         Container(
           height: 80,
           width: 100,
           decoration: BoxDecoration(borderRadius:BorderRadius.circular(10), ),
           child: Stack(
             alignment: Alignment.center,
             children: [
               const Image(image: AssetImage('assets/chat/gezi.png'),),
               MaterialButton(
                 child: Text(feihua,
                     style: const TextStyle(fontSize:40,fontWeight:FontWeight.w700, )
                 ),
               onPressed: () =>_onClickItem(pickerStyle),
               color: Colors.transparent,
               elevation: 0,
             ),

             ]
           ),
         ),
         Expanded(
              child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) => next(_messageRealList, index),
                        childCount: _messageList.length,

                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 312.0 / 60.0,
                      ),
                    )
                  ]
              )),
        ///表情
        Container(
          height: 144,
          width: 144,
          child: MaterialButton(
              child: Image.asset(_mRecorder!.isRecording ? 'assets/chat/microb.png':'assets/chat/micow.png'),
            onPressed:getRecorderFn(),
            color: Color.fromARGB(255,139,71,38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(72)
              ),
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(height: 20,
        decoration: const BoxDecoration(color: Color.fromARGB(150,250, 240, 230)),
        child: Text(_mRecorder!.isRecording
            ? 'Play in progress'
            : 'Player is stopped'),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: KeyboardVisibilityBuilder( /// 检测键盘是否弹出
          builder: (context, isKeyboardVisible){
            if(isKeyboardVisible && !mounted){ /// 当键盘弹出时自动跳转到最底部
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            }
            return GestureDetector(
              onTap: () => {
                hideKeyboard(context), /// 隐藏键盘
                emojiShowing = false,
              },
              child: Container(
                height: 400,width: 500,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/background/c.jpg",
                        ),
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                     //Image.asset("assets/background/c.jpg"),
                    Scaffold(
                        backgroundColor: Colors.transparent,
                        body: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: _chatList(context),
                        )
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}

