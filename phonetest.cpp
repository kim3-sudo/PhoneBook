#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

#include "phonebook.h"
#include "phoneentry.h"


using namespace std;

int main(){
  PhoneBook pb;
  vector<PhoneEntry> pbResults;

  cout << "Phone Book test program" << endl;

  string IDnum;
  cout << "Enter an ID number to delete";
  cin >> IDnum;
  pb.deleteEntry(IDnum);
  cout << "Attempted delete";
 
  return 0;
}
