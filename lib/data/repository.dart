import '../domain/entities/entity.dart';

/// Base abstract class for all repositories
/// Demonstrates: Encapsulation + common interface for Data Layer
/// Pattern: Repository Pattern for data access abstraction
abstract class Repository<T extends Entity> {
  /// Get all entities
  List<T> getAll();

  /// Get entity by ID
  T? getById(String id);

  /// Create new entity
  T create(T entity);

  /// Update existing entity
  void update(T entity);

  /// Delete entity by ID
  void delete(String id);

  /// Load entities from persistence
  void loadFromFile();

  /// Save entities to persistence
  void saveToFile();
}
