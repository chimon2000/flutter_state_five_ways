extension ImmutableList<T> on List<T> {
  List<T> concat(T item) => List<T>.from(<T>[...this, item]);
}
