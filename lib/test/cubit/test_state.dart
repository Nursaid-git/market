part of 'test_cubit.dart';

@immutable
sealed class TestState {}

final class TestInitial extends TestState {}

final class TestLoading extends TestState {}

final class TestSuccess extends TestState {
  final List<TestModel> data;
  TestSuccess(this.data);
}

final class TestError extends TestState {
  final String message;
  TestError({required this.message});
}
