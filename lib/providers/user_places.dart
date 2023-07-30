import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';

// notifier classes managed by RiverPod
// STATE MANAGED BY RIVERPOD SHOULD NOT BE MUTATED
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);
    // adding new place but with the other state
    state = [newPlace, ...state];
  }
}

// angle bracker to statenotifier
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
