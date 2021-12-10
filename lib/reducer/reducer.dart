//Action + State => State

import 'package:redux/redux.dart';
import 'package:tema5/actions/index.dart';
import 'package:tema5/models/index.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  //test
  (AppState state, dynamic action) {
    print(action);
    return state;
  },
  //final test

  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, GetMoviesStart>(_getMovies),
  TypedReducer<AppState, SetSelectedMovie>(_setSelectedMovie),
  TypedReducer<AppState, RegisterSuccessful>(_registerSuccessful),
  TypedReducer<AppState, InitializeAppSuccessful>(_initializeAppSuccessful),
  TypedReducer<AppState, SignOutSuccessful>(_signOutSuccessful),
]);

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..movies.addAll(action.movies)
      ..isLoading = false
      ..page = state.page + 1;
    print('reducer_suc');
  });
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) {
    b
      ..isLoading = false
      ..error = action.error.toString();
    print('reducer_er');
  });
}

AppState _getMovies(AppState state, GetMoviesStart action) {
  return state.rebuild((AppStateBuilder b) {
    b.isLoading = true;
    print('reducer_?');
  });
}

AppState _setSelectedMovie(AppState state, SetSelectedMovie action) {
  return state.rebuild((AppStateBuilder b) {
    b.selectedMovie = action.movieId;
  });
}

AppState _registerSuccessful(AppState state, RegisterSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = action.user.toBuilder();
  });
}

AppState _initializeAppSuccessful(AppState state, InitializeAppSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = action.user?.toBuilder();
  });
}

AppState _signOutSuccessful(AppState state, SignOutSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = null;
  });
}
