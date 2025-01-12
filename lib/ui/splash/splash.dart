import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:paopao_accounting/ui/main_page.dart';
import '../../base/util/localization_service.dart';

class SplashScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SplashScreen({super.key, required this.onLocaleChange});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _logoController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    // init video controller
    _videoController = VideoPlayerController.asset("assets/splash_video.mp4")
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
        setState(() {});
      });

    // init animation controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // animation start
    _logoController.forward().then((_) {
      _textController.forward();
    });

    // set timer to navigate to main page 5s later
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // video player
          if (_videoController.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          // black video background
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // App content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                // App name
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _textController,
                    curve: Curves.easeIn,
                  ),
                  child: Text(
                    LocalizationService.of(context).translate("app_name"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Slogan animation
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _textController,
                    curve: Curves.easeIn,
                  ),
                  child: Text(
                    LocalizationService.of(context).translate("slogan"),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Language selection buttons at the bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => widget.onLocaleChange(const Locale('en')),
                  child: const Text(
                    'English',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => widget.onLocaleChange(const Locale('zh')),
                  child: const Text(
                    '中文',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () => widget.onLocaleChange(const Locale('es')),
                  child: const Text(
                    'Español',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
