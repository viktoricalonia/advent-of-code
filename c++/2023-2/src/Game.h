
#include <string>

struct Game {
  int id, redCount, greenCount, blueCount;

  Game(int, int, int, int);

  bool isPossible(int, int, int);
  std::string toString();
};
