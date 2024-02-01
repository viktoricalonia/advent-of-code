
#include <cctype>
#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

int addFirstNumberAndLastNumber(vector<string> lines) {
  vector<int> numbers;
  vector<int> sums;
  vector<char> digitChars;
  for (int li = 0; li < lines.size(); li ++) {
    string line = lines[li];
    for (int ci = 0; ci < line.size(); ci++) {
      char c = line[ci];
      if (isdigit(c)) {
        digitChars.push_back(c);
      }
    }

    string strNumber = string() + digitChars[0] + digitChars[digitChars.size() - 1];
    int number = stoi(strNumber);
    // cout << "Number: " << number << " from: " <<  strNumber << endl;
    numbers.push_back(number);

    digitChars.clear();
  }

  int sum = 0;
  for (int i: numbers) {
    // cout << i << endl;
    sum += i;
  }
  return sum;
}

int main (int argc, char *argv[]) {
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

  cout << "Output: " << endl << addFirstNumberAndLastNumber(lines) << endl;
  return 0;
}
