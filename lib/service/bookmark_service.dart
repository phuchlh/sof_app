import 'package:get_storage/get_storage.dart';

class BookmarkService {
  static const String _storageKey = 'bookmarked_users';
  final GetStorage _storage = GetStorage();

  List<int> get bookmarkedUserIds {
    final rawList = _storage.read<List>(_storageKey);
    return rawList?.cast<int>() ?? [];
  }

  bool isBookmarked(int userId) {
    return bookmarkedUserIds.contains(userId);
  }

  void toggleBookmark(int userId) {
    final current = bookmarkedUserIds;
    if (current.contains(userId)) {
      current.remove(userId);
    } else {
      current.add(userId);
    }
    _storage.write(_storageKey, current);
  }

  void addBookmark(int userId) {
    final current = bookmarkedUserIds;
    if (!current.contains(userId)) {
      current.add(userId);
      _storage.write(_storageKey, current);
    }
  }

  void removeBookmark(int userId) {
    final current = bookmarkedUserIds;
    if (current.contains(userId)) {
      current.remove(userId);
      _storage.write(_storageKey, current);
    }
  }

  void clearBookmarks() {
    _storage.remove(_storageKey);
  }
}
