#include <algorithm>
#include <cstddef>
#include <string>
#include <map>
#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

string subjectArray[] = {
  "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
  "1", "2", "3", "4", "5", "6", "7", "8", "9",
};

string toDigitChar(string digitString) {
  map<string, string> numberMap;
  numberMap["one"] = "1";
  numberMap["two"] = "2";
  numberMap["three"] = "3";
  numberMap["four"] = "4";
  numberMap["five"] = "5";
  numberMap["six"] = "6";
  numberMap["seven"] = "7";
  numberMap["eight"] = "8";
  numberMap["nine"] = "9";
  map<string, string>::iterator it = numberMap.begin();
  while (it != numberMap.end()) {
    if (it->first == digitString)
      return it->second;
    ++it;
  }
  return "";
}

string findSubject(string line, int pos) {
  string find = "";
  size_t curPos = string::npos;
  for(auto it = begin(subjectArray); it != end(subjectArray); ++it) {
    size_t found = line.find(*it, pos);
    //cout << *it << "-" << found << "-" << curPos << ", ";
    if (found != string::npos && found < curPos) {
      curPos = found;
      find = *it;
    }
  }
  return find;
}

int lastDigit(string line) {
  int lastDigit = 0; 
  string lastNumber;
  for (int ci = 0; ci < line.size(); ci++) {
    string subject = findSubject(line, ci);
    if (subject != "") 
      lastNumber = subject;
  }
  if (lastNumber.size() == 1)  {
    lastDigit = stoi(lastNumber);
  } else {
    lastDigit = stoi(toDigitChar(lastNumber));
  }
  return lastDigit;
}

string rFindSubject(string line, int pos) {
  string find = "";
  size_t curpos = 0;
  for(auto it = begin(subjectArray); it != end(subjectArray); ++it) {
    size_t found = line.rfind(*it, pos);
    // cout << *it << "-" << found << "-" << curpos << ", ";
    if (found != string::npos && found >= curpos)  {
      curpos = found;
      find = *it;
    }
  }
  return find;
}

int firstDigit(string line) {
  int firstDigit = 0; 
  string firstNumber;
  for (int ci = line.size() - 1; ci >= 0; ci--) {
    string subject = rFindSubject(line, ci);
    if (subject != "")
      firstNumber = subject;
  }
  if (firstNumber.size() == 1)  {
    firstDigit = stoi(firstNumber);
  } else {
    firstDigit = stoi(toDigitChar(firstNumber));
  }
  return firstDigit;
}

int main (int argc, char *argv[]) {
  string line;
  // cout << "Input file: " << argv[1] << endl << endl;
  ifstream file(argv[1]);
  vector<string> lines;
  if (file.is_open()) {
    while (getline(file, line)) {
      lines.push_back(line);
      cout << line << ": " << firstDigit(line) * 10 + lastDigit(line) << endl;
    }
  }

  // cout << "Input: " << endl;
  // for (string line: lines) {
  //   cout << line << endl;
  // }

  //cout << "Output: " << endl << addFirstNumberAndLastNumber(lines) << endl;
  return 0;
}
