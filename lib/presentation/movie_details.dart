import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tema5/actions/index.dart';
import 'package:tema5/container/selected_movie_container.dart';
import 'package:tema5/container/user_container.dart';
import 'package:tema5/models/index.dart';
import 'package:tema5/presentation/user_avatar.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserContainer(
      builder: (BuildContext context, AppUser? user) {
        return SelectedMovieContainer(
          builder: (BuildContext context, Movie movie) {
            return Scaffold(
              appBar: AppBar(
                title: Text(movie.title),
                leading: const UserAvatar(),
              ),
              body: GestureDetector(
                child: Image.network(
                  movie.image,
                  width: MediaQuery.of(context).size.width / 2,
                ),
                onTap: () {
                  final Store<AppState> store = StoreProvider.of<AppState>(context);
                  final List<Movie> movies = store.state.movies.toList()..shuffle();
                  store.dispatch(SetSelectedMovie(movies.first.id));
                },
              ),
              floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(Icons.message_outlined),
                label: const Text('Review'),
                onPressed: () {
                  if (user == null) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    //show reviews page
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
