import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int CACHE_EXPIRY_DURATION = 48*60*60*1000;

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  final SharedPreferences sharedPreferences;

  CacheBloc({required this.sharedPreferences}) : super(CacheInitial());

  @override
  Stream<CacheState> mapEventToState(CacheEvent event) async* {
    if (event is LoadDataEvent) {
      try {
        // Load data and timestamp from cache
        final cachedData = sharedPreferences.getString('cached_data');
        final cachedTimestamp = sharedPreferences.getInt('cached_timestamp') ?? 0;
        final currentTime = DateTime.now().millisecondsSinceEpoch;

        if (cachedData != null && currentTime - cachedTimestamp < CACHE_EXPIRY_DURATION) {
          yield CacheLoaded(data: cachedData, timestamp: DateTime.fromMillisecondsSinceEpoch(cachedTimestamp));
        } else {
          yield CacheEmpty();
        }
      } catch (e) {
        yield CacheError(message: 'Error loading data from cache: $e');
      }
    } else if (event is SaveDataEvent) {
      try {
        // Save data and current timestamp to cache
        await sharedPreferences.setString('cached_data', event.data);
        await sharedPreferences.setInt('cached_timestamp', DateTime.now().millisecondsSinceEpoch);
        yield CacheLoaded(data: event.data, timestamp: DateTime.now());
      } catch (e) {
        yield CacheError(message: 'Error saving data to cache: $e');
      }
    } else if (event is InvalidateCacheEvent) {
// Invalidate the cache by clearing stored data and timestamp
      await sharedPreferences.remove('cached_data');
      await sharedPreferences.remove('cached_timestamp');
      yield CacheEmpty();
    }
  }
}

abstract class CacheEvent {}

class LoadDataEvent extends CacheEvent {}

abstract class CacheState {}

class CacheInitial extends CacheState {}

class CacheEmpty extends CacheState {}

class CacheLoaded extends CacheState {
  final String data;

  CacheLoaded({required this.data, required DateTime timestamp});
}

class CacheError extends CacheState {
  final String message;

  CacheError({required this.message});
}

class SaveDataEvent extends CacheEvent {
  final String data;

  SaveDataEvent({required this.data});
}

class InvalidateCacheEvent extends CacheEvent {}

// ...

