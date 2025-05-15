List<T> castJsonList<T>(dynamic json) {
  if(json == null) {
    return [];
  }
  return (json as List<dynamic>).cast<T>();
}
