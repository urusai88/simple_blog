class Persistent {
  final Map<String, dynamic> _store = {};

  void persist(String key, dynamic obj) {
    _store[key] = obj;
  }

  T fetch<T>(String key) {
    if (!_store.containsKey(key)) {
      throw 'object not found';
    }

    return _store[key];
  }
}
