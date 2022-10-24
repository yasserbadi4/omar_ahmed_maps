import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:omar_ahmed_maps/data/models/place_suggestions.dart';
import 'package:omar_ahmed_maps/data/repository/maps_repository.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;

  MapsCubit(this.mapsRepository) : super(MapsInitial());

  void emitPlacesSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }
}
