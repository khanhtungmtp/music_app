import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/data/models/song.dart';
import 'package:music_app/ui/discovery/discovery.dart';
import 'package:music_app/ui/home/ViewModels.dart';
import 'package:music_app/ui/setting/setting.dart';
import 'package:music_app/ui/user/user.dart';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<Widget> _tabs = [
    const HomePageTab(),
    const DiscoveryTab(),
    const AccountTab(),
    const SettingTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Music App')),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.album),
              label: 'Discovery',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Acount'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return _tabs[index];
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Home Tab')));
  }
}

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  final List<Song> songs = [];
  late MusicAppViewModel _model;

  @override
  void initState() {
    _model = MusicAppViewModel();
    _model.loadSongs();
    _model.songStream.stream.listen((songList) {
      setState(() {
        songs.clear();
        songs.addAll(songList);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  @override
  void dispose() {
    _model.songStream.close();
    super.dispose();
  }

  Widget getBody() {
    bool isLoading = songs.isEmpty;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.separated(
        itemBuilder: (context, position) => Center(
          child: _songItemSection(parent: this, song: songs[position]),
        ),
        separatorBuilder: (context, position) => const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        ),
        itemCount: songs.length,
        shrinkWrap: true,
      );
    }
  }
}

class _songItemSection extends StatelessWidget {
  final _HomePageTabState parent;
  final Song song;
  const _songItemSection({required this.parent, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 24, right: 8),
      title: Text(song.title),
      subtitle: Text(song.artist),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/itunes.png',
          image: song.image,
          width: 32,
          height: 32,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/itunes.png', width: 32, height: 32);
          },
        ),
      ),
      trailing: IconButton(onPressed: () => {}, icon: Icon(Icons.more_horiz)),
    );
  }
}
