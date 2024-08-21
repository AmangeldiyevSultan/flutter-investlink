/// Persistent storage for theme mode.
abstract class ITokenStorage<T> {
  /// Returns auth token pair.
  Future<T?> read();

  /// Save auth token pair.
  Future<void> write(T token);

  /// Delete auth token pair.
  Future<void> delete();
}
