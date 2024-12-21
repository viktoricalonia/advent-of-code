
// UInterpret
// Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue

protocol Interpreter {
  func interpret(phrase: String)
}

enum Color {
  case none, green, red, blue
}

protocol Context {
  func setGameId(_ gameId: UInt)
  func setColor(_ color: Color)
  func addCount(_ count: UInt)
}

class GameInterpreter: Interpreter {
  var context: Context

  init(context: Context) {
    self.context = context
  }

  func interpret(phrase: String) {
    let expression = GameExpression(phrase: phrase)
    expression.interpret(context: context)
  }
}
