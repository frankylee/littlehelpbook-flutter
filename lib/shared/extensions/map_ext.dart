extension DefaultMap<K, V> on Map<K, V> {
  V getOrDefault(K key, V defaultValue) {
    if (containsKey(key)) {
      return this[key] ?? defaultValue;
    } else {
      return defaultValue;
    }
  }
}
