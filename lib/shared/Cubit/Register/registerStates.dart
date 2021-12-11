abstract class RegisterStates{}

class InitialState extends RegisterStates{}

class ChangeIcon extends RegisterStates{}

class SucessState extends RegisterStates{
  final registerModel;

  SucessState(this.registerModel);
}
class ErrorState extends RegisterStates{
  final Error;

  ErrorState(this.Error);
}
class LoadingState extends RegisterStates{}
