import 'package:flutter/material.dart';
import 'package:oxytocin/core/Utils/helpers/helper.dart';
import 'package:oxytocin/features/home/presentation/cubit/home_cubit.dart';
import 'package:provider/provider.dart';
import '../widgets/doctor_card.dart';
import '../../data/models/favorite_response.dart';
import '../../data/services/favorite_service.dart';
import '../../data/services/favorite_manager.dart';
import '../../../../core/Utils/services/secure_storage_service.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteService _favoriteService = FavoriteService();
  final SecureStorageService _secureStorageService = SecureStorageService();

  List<FavoriteDoctor> _favorites = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _onDoctorCardTap(int doctorIndex) {
    final cubit = context.read<HomeCubit>();
    cubit.onDoctorCardTap(doctorIndex);
  }

  Future<void> _loadFavorites() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final token = await _secureStorageService.getAccessToken();
      if (token == null) {
        setState(() {
          _error = 'يرجى تسجيل الدخول أولاً';
          _isLoading = false;
        });
        return;
      }

      await _favoriteService.cleanDuplicateFavorites(token);
      final favorites = await _favoriteService.getFavorites(token);

      setState(() {
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ في تحميل المفضلة: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(FavoriteDoctor favoriteDoctor) async {
    try {
      final token = await _secureStorageService.getAccessToken();
      if (token == null) return;

      final favoriteId = favoriteDoctor.id;

      await _favoriteService.removeFavorite(token, favoriteId);

      setState(() {
        _favorites.removeWhere((fav) => fav.id == favoriteDoctor.id);
      });

      context.read<FavoriteManager>().refreshFavorites();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // 'الأطباء المفضلون'
          context.tr.favoriteDoctors,
          style: TextStyle(
            fontFamily: 'AlmaraiBold',
            fontSize: isTablet ? 20.0 : 18.0,
          ),
        ),
        backgroundColor: const Color(0xFF0A1A4A),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              _error!,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadFavorites,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    if (_favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              // 'لا يوجد أطباء مفضلين'
              context.tr.noFavoriteDoctors,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadFavorites,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final favoriteDoctor = _favorites[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DoctorCard(
              doctor: favoriteDoctor.doctor,
              isFavorite: true,
              onTap: () => _onDoctorCardTap(index),
              onFavoriteTap: () => _removeFavorite(favoriteDoctor),
            ),
          );
        },
      ),
    );
  }
}
