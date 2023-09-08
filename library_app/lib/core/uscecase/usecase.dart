abstract class UseCase<T, P> {
  Future<T> call({P p});
}

abstract class UseCaseGEO<T, P> {}
