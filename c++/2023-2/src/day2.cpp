

#include <cstring>
#include <fstream>
#include <iostream>
#include <string.h>
#include <string>
#include <vector>

#include "Game.h"

using namespace std;

vector<Game> getGames(vector<string>);

int sumOfPossibleGameIds(vector<Game>);

int sumOfPossibleGameIds(vector<string>);

int getGameId(string);

int getGameNumber(string);

vector<Game> getGames(string);

Game toGame(string);

vector<string> split(vector<Game>, string);

vector<string> split(string, string);

int main(int argc, char *argv[]) {
  string line;
  // cout << "Input file: " << argv[1] << endl << endl;
  ifstream file(argv[1]);
  vector<string> lines;
  if (file.is_open()) {
    while (getline(file, line)) {
      lines.push_back(line);
    }
  }

  // cout << "Input: " << endl;
  // for (string line: lines) {
  //   cout << line << endl;
  // }

  cout << "Output: " << endl << sumOfPossibleGameIds(lines) << endl;

  return 0;
}

int sumOfPossibleGameIds(vector<Game> games) {
  int sum = 0;
  return sum;
}

int sumOfPossibleGameIds(vector<string> lines) {
  vector<Game> games = getGames(lines);
  for (string line : lines) {
    Game game = toGame(line);
    games.push_back(game);
  }
  return sumOfPossibleGameIds(games);
}

vector<Game> getGames(vector<string> lines) {
  vector<Game> games;
  return games;
}

Game toGame(string line) {
  int gameNo = getGameId(line);
  return Game(1, 2, 3, 3);
}

int getGameId(string line) {
  vector<string> composition = split(line, ": ");
  string game = composition[0];
  string snumber = split(game, "")[1];
  int number = stoi(snumber);
  return number;
}

vector<Game> getGames(string line) {
  vector<Game> games;
  vector<string> composition = split(line, ": ");
  string setGamesString = composition[1];

  vector<string> sgames = split(games, ";");

  return games;
}

vector<string> split(vector<Game> games, string delimeter) {
  vector<string> vtoken;
  for (Game game : games) {
    string sgame = game.toString();
    vtoken.push_back(sgame);
  }
  return vtoken;
}

vector<string> split(string subject, string delimeter) {
  vector<string> vtoken;

  char *cSubject = new char[subject.length() + 1];
  strcpy(cSubject, subject.c_str());

  char *cDelimiter = new char[delimeter.length() + 1];
  strcpy(cDelimiter, delimeter.c_str());

  char *token = strtok(cSubject, cDelimiter);

  while (token != NULL) {
    string stoken(token);
    vtoken.push_back(stoken);
    token = strtok(NULL, cDelimiter);
  }

  return vtoken;
}
