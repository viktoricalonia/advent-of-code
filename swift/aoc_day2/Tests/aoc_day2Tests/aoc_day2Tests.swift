import XCTest
@testable import aoc_day2

final class aoc_day2Tests: XCTestCase {
  func testNumberExpression() {
    let numberExp = NumberExpression(phrase: "3")
    let game = NullGame()

    numberExp.interpret(context: game)

    XCTAssertEqual(game.called, [.addCount(count: 3)])
  }

  func testNumberExpressionNotNumber() {
    let numberExp = NumberExpression(phrase: "a")
    let game = NullGame()

    numberExp.interpret(context: game)

    XCTAssertEqual(game.called, [.setColor(color: .none)])
  }

  func testColorExpression() {
    var numberExp = ColorExpression(phrase: "red")
    var game = NullGame()

    numberExp.interpret(context: game)

    XCTAssertEqual(game.called, [.setColor(color: .red)])
    XCTAssertEqual(game.lastColorContext, .red)

    numberExp = ColorExpression(phrase: "green")
    game = NullGame()

    numberExp.interpret(context: game)

    XCTAssertEqual(game.called, [.setColor(color: .green)])
    XCTAssertEqual(game.lastColorContext, .green)

    numberExp = ColorExpression(phrase: "blue")
    game = NullGame()

    numberExp.interpret(context: game)

    XCTAssertEqual(game.called, [.setColor(color: .blue)])
    XCTAssertEqual(game.lastColorContext, .blue)
  }

  func testColorExpressionNotRGB() {
    let numberExp = ColorExpression(phrase: "orange")
    let game = NullGame()

    numberExp.interpret(context: game)

    XCTAssertEqual(game.called, [.setColor(color: .none)])
  }

  func testSoloDrawExpression() {
    let soloDrawExp = SoloDrawExpression(phrase: "3 green")
    let game = NullGame()

    soloDrawExp.interpret(context: game)

    XCTAssertEqual(game.called, [.setColor(color: .green), .addCount(count: 3)])
    XCTAssertEqual(game.redCounts, [])
    XCTAssertEqual(game.greenCounts, [3])
    XCTAssertEqual(game.blueCounts, [])
  }

  func testSetDrawExpression() {
    let game = NullGame()

    SetDrawExpression(phrase: "3 green, 4 blue, 1 red").interpret(context: game)

    XCTAssertEqual(game.called, [
      .setColor(color: .green), .addCount(count: 3),
      .setColor(color: .blue), .addCount(count: 4),
      .setColor(color: .red), .addCount(count: 1),
    ])
    XCTAssertEqual(game.redCounts, [1])
    XCTAssertEqual(game.greenCounts, [3])
    XCTAssertEqual(game.blueCounts, [4])
  }

  func testGameSetDrawExpression() {
    let game = NullGame()

    GameSetExpression(phrase: "1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")
      .interpret(context: game)

    XCTAssertEqual(game.called, [
      .setColor(color: .blue), .addCount(count: 1),
      .setColor(color: .green), .addCount(count: 2),

      .setColor(color: .green), .addCount(count: 3),
      .setColor(color: .blue), .addCount(count: 4),
      .setColor(color: .red), .addCount(count: 1),

      .setColor(color: .green), .addCount(count: 1),
      .setColor(color: .blue), .addCount(count: 1),
    ])
    XCTAssertEqual(game.redCounts, [1])
    XCTAssertEqual(game.greenCounts, [2, 3, 1])
    XCTAssertEqual(game.blueCounts, [1, 4, 1])
  }

  func testGameIdExpression() {
    let game = NullGame()

    GameIdExpression(phrase: "Game 22").interpret(context: game)

    XCTAssertEqual(game.called, [.setGameId(gameId: 22)])
    XCTAssertEqual(game.gameId, 22)
  }

  func testGameIsNotPossible() {
    let game = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
    let gameContext = NullGame()

    GameInterpreter(context: gameContext).interpret(phrase: game)

    XCTAssertEqual(gameContext.gameId, 3)
    XCTAssertEqual(gameContext.redCounts, [20, 4, 1])
    XCTAssertEqual(gameContext.greenCounts, [8, 13, 5])
    XCTAssertEqual(gameContext.blueCounts, [6, 5])

    XCTAssertFalse(gameContext.isPossible(redCount: 12, greenCount: 13, blueCount: 14))
  }

  func testGameIsPossible() {
    let game = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    """

    let gameContext = NullGame()

    GameInterpreter(context: gameContext).interpret(phrase: game)

    XCTAssertEqual(gameContext.gameId, 1)
    XCTAssertEqual(gameContext.redCounts, [4, 1])
    XCTAssertEqual(gameContext.greenCounts, [2, 2])
    XCTAssertEqual(gameContext.blueCounts, [3, 6])

    XCTAssertTrue(gameContext.isPossible(redCount: 12, greenCount: 13, blueCount: 14))
  }

  func testGameExpression() {
    let input = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    let sum = input
      .components(separatedBy: .newlines)
      .compactMap { makeGame(line: $0) }
      .filter { $0.isPossible(redCount: 12, greenCount: 13, blueCount: 14) }
      .compactMap { $0.gameId }
      .reduce(0, +)

    XCTAssertEqual(sum, 8)
  }

  func testGamePower() {
    let game = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    """

    let gameContext = NullGame()
    GameInterpreter(context: gameContext).interpret(phrase: game)

    XCTAssertEqual(gameContext.power, 48)
  }
}

class NullGame: Game {
  enum Method: Equatable {
    case getGameId
    case setColor(color: Color)
    case setGameId(gameId: UInt)
    case addCount(count: UInt)
    case isPossible(redCount: UInt, greenCount: UInt, blueCount: UInt)
  }

  var called: [Method] = []

  override var gameId: UInt {
    get {
      called.append(.getGameId)
      return super.gameId
    }
    set {
      super.gameId = newValue
    }
  }

  override func setColor(_ color: Color) {
    super.setColor(color)
    called.append(.setColor(color: color))
  }

  override func setGameId(_ gameId: UInt) {
    super.setGameId(gameId)
    called.append(.setGameId(gameId: gameId))
  }

  override func addCount(_ count: UInt) {
    super.addCount(count)
    called.append(.addCount(count: count))
  }

  override func isPossible(redCount: UInt, greenCount: UInt, blueCount: UInt) -> Bool {
    let isPossible = super.isPossible(
      redCount: redCount,
      greenCount: greenCount,
      blueCount: blueCount
    )
    called.append(.isPossible(redCount: redCount, greenCount: greenCount, blueCount: blueCount))
    return isPossible
  }
}
