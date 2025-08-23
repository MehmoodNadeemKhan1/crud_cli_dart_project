import 'implementation_interface.dart';
import 'user_details_model.dart';

class UserDetailsFileRepository implements IRepository<UserDetails>{
  @override
  Future<void> create(UserDetails item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<UserDetails?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<List<UserDetails>>? list() {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, UserDetails updatedItem) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}