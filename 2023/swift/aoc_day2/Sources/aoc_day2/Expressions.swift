
import Foundation

protocol Expression {
  func interpret(context: Context)
}

class BaseExpression: Expression {
  let phrase: String

  init(phrase: String) {
    self.phrase = phrase
  }

  open func interpret(context _: Context) {}
}

// Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
class GameExpression: BaseExpression {
  override func interpret(context: Context) {
    let gameComponent = phrase.components(separatedBy: ":")

    guard gameComponent.count == 2 else { return }

    let gameIdPhrase = gameComponent[0]
    let gameIdExpression = GameIdExpression(phrase: gameIdPhrase)

    let gameSetPhrase = gameComponent[1]
    let gameSetExpression = GameSetExpression(phrase: gameSetPhrase)

    gameIdExpression.interpret(context: context)
    gameSetExpression.interpret(context: context)
  }
}

// Game 2
class GameIdExpression: BaseExpression {
  override func interpret(context: Context) {
    let numStr = phrase.removingFirst("Game ".count)
    if let num = NumberFormatter().number(from: numStr)?.uintValue {
      context.setGameId(num)
    }
  }
}

// 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
class GameSetExpression: BaseExpression {
  override func interpret(context: Context) {
    phrase
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: ";")
      .enumerated()
      .forEach { _, phrase in
        SetDrawExpression(phrase: phrase).interpret(context: context)
      }
  }
}

// 3 green, 4 blue, 1 red
class SetDrawExpression: BaseExpression {
  override func interpret(context: Context) {
    phrase
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: ",")
      .enumerated()
      .forEach { _, phrase in
        SoloDrawExpression(phrase: phrase).interpret(context: context)
      }
  }
}

// 3 green
class SoloDrawExpression: BaseExpression {
  override func interpret(context: Context) {
    phrase
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: " ")
      .reversed()
      .enumerated()
      .forEach { index, phrase in
        switch index {
        case 0:
          ColorExpression(phrase: phrase).interpret(context: context)
        case 1:
          NumberExpression(phrase: phrase).interpret(context: context)
        default:
          print("Invalid Length")
        }
      }
  }
}

// 3 | any Integer
class NumberExpression: BaseExpression {
  override func interpret(context: Context) {
    if let count = NumberFormatter().number(from: phrase)?.uintValue {
      context.addCount(count)
    } else {
      context.setColor(.none) // Remove color context
      print("Invalid Count Number")
    }
  }
}

// green|blue|red
class ColorExpression: BaseExpression {
  override func interpret(context: Context) {
    switch phrase {
    case "red":
      context.setColor(.red)
    case "green":
      context.setColor(.green)
    case "blue":
      context.setColor(.blue)
    default:
      context.setColor(.none)
    }
  }
}

public extension String {
  func removingFirst(_ k: Int) -> String {
    var string = self
    string.removeFirst(k)
    return string
  }
}
