#include "Game.h"
#include <string>

using namespace std;

Game::Game(int id, int redCount, int greenCount, int blueCount) : id(id), redCount(redCount), blueCount(blueCount), greenCount(greenCount) { }

string Game::toString() {
  return "Game(" + to_string(id) + ", " + to_string(redCount) + ", " + to_string(greenCount) + ", " + to_string(blueCount) + ")";
}

bool Game::isPossible(int redCount, int greenCount, int blueCount) {
  return  true;
}


