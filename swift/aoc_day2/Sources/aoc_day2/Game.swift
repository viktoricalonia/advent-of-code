import Foundation

protocol GameProtocol: Context {
  var gameId: UInt { get }
  var power: UInt { get }
  func isPossible(redCount: UInt, greenCount: UInt, blueCount: UInt) -> Bool
}

class Game: GameProtocol {
  var gameId: UInt = 0

  private(set) var lastColorContext: Color = .none

  private(set) var redCounts: [UInt] = []
  private(set) var greenCounts: [UInt] = []
  private(set) var blueCounts: [UInt] = []

  var power: UInt {
    (redCounts.max() ?? 0) * (greenCounts.max() ?? 0) * (blueCounts.max() ?? 0)
  }

  func isPossible(redCount: UInt, greenCount: UInt, blueCount: UInt) -> Bool {
    (redCounts.max() ?? 0) <= redCount &&
      (greenCounts.max() ?? 0) <= greenCount &&
      (blueCounts.max() ?? 0) <= blueCount
  }

  func setGameId(_ gameId: UInt) {
    self.gameId = gameId
  }

  func setColor(_ color: Color) {
    lastColorContext = color
  }

  func addCount(_ count: UInt) {
    switch lastColorContext {
    case .red:
      redCounts.append(count)
    case .green:
      greenCounts.append(count)
    case .blue:
      blueCounts.append(count)
    default:
      print("Invalid State")
    }
  }
}
