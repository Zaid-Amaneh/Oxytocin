import 'package:flutter/foundation.dart';
import 'favorite_service.dart';
import '../../../../core/Utils/services/secure_storage_service.dart';

class FavoriteManager extends ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();
  final SecureStorageService _secureStorageService = SecureStorageService();

  Set<int> _favoriteDoctorIds = {};
  bool _isInitialized = false;
  Map<int, int> _favoriteIdsMap = {};
  Set<int> get favoriteDoctorIds => _favoriteDoctorIds;
  bool get isInitialized => _isInitialized;
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }
    try {
      final token = await _secureStorageService.getAccessToken();
      if (token != null) {
        final favoriteDoctors = await _favoriteService.getFavoriteDoctors(
          token,
        );
        final favorites = await _favoriteService.getFavorites(token);
        _favoriteDoctorIds = favorites.map((fav) => fav.doctor.id).toSet();
        _favoriteIdsMap = {for (var fav in favorites) fav.doctor.id: fav.id};
      }
      _isInitialized = true;
      notifyListeners();
    } catch (e) {}
  }

  bool isFavorite(int doctorId) {
    final isFav = _favoriteDoctorIds.contains(doctorId);
    return isFav;
  }

  Future<bool> addFavorite(int doctorId) async {
    try {
      final token = await _secureStorageService.getAccessToken();
      if (token == null) {
        return false;
      }

      await _favoriteService.addFavorite(token, doctorId);
      _favoriteDoctorIds.add(doctorId);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFavorite(int doctorId) async {
    try {
      final token = await _secureStorageService.getAccessToken();
      if (token == null) return false;

      final favoriteId = _favoriteIdsMap[doctorId];

      if (favoriteId == null) return false;
      await _favoriteService.removeFavorite(token, favoriteId);
      _favoriteDoctorIds.remove(doctorId);
      _favoriteIdsMap.remove(doctorId);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> toggleFavorite(int doctorId) async {
    if (isFavorite(doctorId)) {
      return await removeFavorite(doctorId);
    } else {
      return await addFavorite(doctorId);
    }
  }

  Future<void> refreshFavorites() async {
    _isInitialized = false;
    await initialize();
  }

  void clearFavorites() {
    _favoriteDoctorIds.clear();
    _isInitialized = false;
    notifyListeners();
  }
}
