import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tema5/actions/index.dart';
import 'package:tema5/container/is_loading_container.dart';
import 'package:tema5/container/movies_container.dart';
import 'package:tema5/models/index.dart';
import 'package:tema5/presentation/user_avatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final bool isLoading = StoreProvider.of<AppState>(context).state.isLoading;
    final double max = _controller.position.maxScrollExtent;
    final double offset = _controller.offset;
    final double delta = max - offset;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double threshold = screenHeight * 0.2;

    if (delta < threshold && !isLoading) {
      StoreProvider.of<AppState>(context).dispatch(const GetMoviesStart());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MovieContainer(
      builder: (BuildContext context, List<Movie> movies) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Movies'),
            leading: const UserAvatar(),
            actions: <Widget>[
              IsLoadingContainer(
                builder: (BuildContext context, bool isLoading) {
                  if (isLoading) {
                    print('intra');
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  return IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      final Store<AppState> store = StoreProvider.of<AppState>(context);
                      store.dispatch(const GetMovies());
                    },
                  );
                },
              ), //refresh
            ],
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .69,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            ),
            controller: _controller,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final Movie movie = movies[index];

              return GestureDetector(
                onTap: () {
                  StoreProvider.of<AppState>(context).dispatch(SetSelectedMovie(movie.id));
                  Navigator.pushNamed(context, '/details');
                },
                child: GridTile(
                  child: Image.network(
                    movie.image,
                    fit: BoxFit.cover,
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black38,
                    title: Text('$index. ${movie.title}'),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
