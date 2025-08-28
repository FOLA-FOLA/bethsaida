import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;
  
  runApp(Bethsaida(camera: firstCamera));
}

class Bethsaida extends StatelessWidget {
  final CameraDescription? camera;
  
  const Bethsaida({Key? key, this.camera}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bethsaida',
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 106, 83),
          secondary: const Color.fromARGB(255, 3, 232, 121),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Lato',
      ),
      home: RoleSelectionScreen(camera: camera),
    );
  }
}

class RoleSelectionScreen extends StatefulWidget {
  final CameraDescription? camera;
  
  const RoleSelectionScreen({Key? key, this.camera}) : super(key: key);
  
  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String _selectedLanguage = 'English';
  final List<String> _languages = [
    'English', 
    'Yoruba', 
    'Igbo', 
    'Hausa',
    'Pidgin'
  ];
  
  final Map<String, Map<String, String>> _translations = {
    'English': {
      'appTitle': 'Bethsaida',
      'welcome': 'Welcome to Bethsaida',
      'roleSelection': 'Select Your Role',
      'blindUser': 'I Need Help',
      'volunteer': 'I Want to Help',
      'language': 'Select Language',
      'getHelp': 'Get Help Now',
      'connecting': 'Connecting to a volunteer...',
      'helpDescription': 'Connect with a volunteer who can assist you with visual tasks',
    },
    'Yoruba': {
      'appTitle': 'Bethsaida',
      'welcome': 'Kaabo si Bethsaida',
      'roleSelection': 'Yan Ipa Re',
      'blindUser': 'Mo Nilo Iranloowo',
      'volunteer': 'Mo Fe Le Se Iranloowo',
      'language': 'Yan Ede',
      'getHelp': 'Gba Iranloowo Ni Bayi',
      'connecting': 'O n so o po pelu iranloowo...',
      'helpDescription': 'So po pelu oluranlowo ti yoo ran o lowo ninu ohun ti o fe se',
    },
    'Igbo': {
      'appTitle': 'Bethsaida',
      'welcome': 'Nno na Bethsaida',
      'roleSelection': 'Horo Oru Gi',
      'blindUser': 'Achoro M Enyemaka',
      'volunteer': 'Achoro M Inyeaka',
      'language': 'Horo Asusu',
      'getHelp': 'Nweta Enyemaka Ugbu a',
      'connecting': 'Ijiko na onye oru afo ofufo...',
      'helpDescription': 'Jikoo na onye oru afo ofufo nke nwere ike inyere gi aka n\'oru anya',
    },
    'Hausa': {
      'appTitle': 'Bethsaida',
      'welcome': 'Barka da zuwa Bethsaida',
      'roleSelection': 'Zabi Matsayin Ku',
      'blindUser': 'Ina Bukatar Taimako',
      'volunteer': 'Ina Son Taimakawa',
      'language': 'Zabi Harshe',
      'getHelp': 'Samun Taimako Yanzu',
      'connecting': 'Hadawa zuwa ma\'aikacin sa kai...',
      'helpDescription': 'Hadu tare da ma\'aikacin sa kai wanda zai iya taimaka muku da ayyukan gani',
    },
    'Pidgin': {
      'appTitle': 'Bethsaida',
      'welcome': 'Welcome to Bethsaida',
      'roleSelection': 'Choose Your Role',
      'blindUser': 'I Need Help',
      'volunteer': 'I Wan Help',
      'language': 'Choose Language',
      'getHelp': 'Get Help Now',
      'connecting': 'Dey connect you to volunteer...',
      'helpDescription': 'Connect with volunteer wey go help you for things wey you need to see',
    },
  };
  
  @override
  Widget build(BuildContext context) {
    final t = _translations[_selectedLanguage]!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t['appTitle']!),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          DropdownButton<String>(
            value: _selectedLanguage,
            icon: Icon(Icons.language, color: Colors.white),
            dropdownColor: Colors.green[700],
            style: TextStyle(color: Colors.white),
            underline: Container(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
              });
            },
            items: _languages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.green[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                t['welcome']!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                t['roleSelection']!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 40),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.visibility_off, color: Colors.green[700]),
                  title: Text(t['blindUser']!),
                  subtitle: Text(t['helpDescription']!),
                  onTap: () {
                    if (widget.camera != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlindUserHomeScreen(
                            camera: widget.camera!,
                            language: _selectedLanguage,
                            translations: _translations[_selectedLanguage]!,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Camera not available')),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.visibility, color: Colors.green[700]),
                  title: Text(t['volunteer']!),
                  subtitle: Text('Help visually impaired Nigerians with daily tasks'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VolunteerHomeScreen(
                          language: _selectedLanguage,
                          translations: _translations[_selectedLanguage]!,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Supported by the Nigerian Association for the Blind',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.green[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlindUserHomeScreen extends StatefulWidget {
  final CameraDescription camera;
  final String language;
  final Map<String, String> translations;
  
  const BlindUserHomeScreen({
    Key? key,
    required this.camera,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  _BlindUserHomeScreenState createState() => _BlindUserHomeScreenState();
}

class _BlindUserHomeScreenState extends State<BlindUserHomeScreen> {
  bool _isCalling = false;
  bool _permissionsGranted = false;
  
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }
  
  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final micStatus = await Permission.microphone.request();
    
    setState(() {
      _permissionsGranted = cameraStatus.isGranted && micStatus.isGranted;
    });
    
    if (!_permissionsGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera and microphone permissions required')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final t = widget.translations;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t['appTitle']!),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.green[100]!],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.visibility_off,
                    size: 80,
                    color: Colors.green[700],
                  ),
                  SizedBox(height: 20),
                  Text(
                    t['getHelp']!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      t['helpDescription']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  if (!_isCalling && _permissionsGranted)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isCalling = true;
                        });
                        
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallScreen(
                                camera: widget.camera,
                                isVolunteer: false,
                                language: widget.language,
                                translations: widget.translations,
                              ),
                            ),
                          ).then((_) {
                            if (mounted) {
                              setState(() {
                                _isCalling = false;
                              });
                            }
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                        child: Text(
                          t['getHelp']!,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  if (!_permissionsGranted)
                    ElevatedButton(
                      onPressed: _requestPermissions,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text('Grant Permissions'),
                    ),
                ],
              ),
            ),
            if (_isCalling)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      SizedBox(height: 20),
                      Text(
                        t['connecting']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class VolunteerHomeScreen extends StatelessWidget {
  final String language;
  final Map<String, String> translations;
  
  const VolunteerHomeScreen({
    Key? key,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final t = translations;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${t['appTitle']!} - Volunteer'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.green[100]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.visibility,
                size: 80,
                color: Colors.green[700],
              ),
              SizedBox(height: 20),
              Text(
                'Ready to Help',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Waiting for a help request...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final cameras = await availableCameras();
                    final camera = cameras.isNotEmpty ? cameras.first : null;
                    
                    if (camera != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallScreen(
                            camera: camera,
                            isVolunteer: true,
                            language: language,
                            translations: translations,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No camera available')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error accessing camera: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
                  child: Text(
                    'Simulate Incoming Call',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CallScreen extends StatefulWidget {
  final CameraDescription camera;
  final bool isVolunteer;
  final String language;
  final Map<String, String> translations;
  
  const CallScreen({
    Key? key,
    required this.camera,
    required this.isVolunteer,
    required this.language,
    required this.translations,
  }) : super(key: key);
  
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isVideoEnabled = true;
  bool _isAudioEnabled = true;
  bool _isFrontCamera = false;
  List<CameraDescription> _cameras = [];
  
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }
  
  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      
      final camera = _isFrontCamera 
          ? _cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
              orElse: () => widget.camera,
            )
          : widget.camera;
      
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );
      
      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }
  
  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;
    
    await _controller?.dispose();
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    await _initializeCamera();
  }
  
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final t = widget.translations;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            if (!widget.isVolunteer && _controller != null)
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _isVideoEnabled ? CameraPreview(_controller!) : Container(color: Colors.black);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
            else
              Container(
                color: Colors.green[900],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.green[700],
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Helping a User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Language: ${widget.language}',
                        style: TextStyle(
                          color: Colors.green[200],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Call controls
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Microphone toggle
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: _isAudioEnabled ? Colors.black54 : Colors.red,
                    child: IconButton(
                      icon: Icon(
                        _isAudioEnabled ? Icons.mic : Icons.mic_off,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _isAudioEnabled = !_isAudioEnabled;
                        });
                      },
                    ),
                  ),
                  
                  // End call button
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  
                  // Camera toggle
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: _isVideoEnabled ? Colors.black54 : Colors.red,
                    child: IconButton(
                      icon: Icon(
                        _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _isVideoEnabled = !_isVideoEnabled;
                        });
                      },
                    ),
                  ),
                  
                  if (!widget.isVolunteer)
                    // Switch camera
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: Icon(
                          Icons.switch_camera,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: _switchCamera,
                      ),
                    ),
                ],
              ),
            ),
            
            // User info (for volunteer)
            if (widget.isVolunteer)
              Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connected to:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'User from Nigeria',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Language: ${widget.language}',
                      style: TextStyle(
                        color: Colors.green[200],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}