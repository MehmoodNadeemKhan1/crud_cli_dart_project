abstract interface class IRepository<T>{
  Future<void> create(T item);
  Future<T?> findById(String id);
  Future<List<T>>? list();
  Future<void> update(String id , T updatedItem );
  Future<void> delete(String id);
  Future<void> deleteAll();
}