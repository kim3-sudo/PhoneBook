#MakeFile to build and deploy the phonebook data using ajax
# For SCMP 318 Software Development

# Put your user name below:
USER= kim3

CC= g++

#For Optimization
#CFLAGS= -O2
#For debugging
CFLAGS= -std=c++14  -Wno-deprecated-declarations

RM= /bin/rm -f

all: phonetest phoneapp PutHTML PutCGI

phoneentry.o: phoneentry.cpp phoneentry.h
	$(CC) -c $(CFLAGS) phoneentry.cpp

phonebook.o: phonebook.cpp phonebook.h
	$(CC) -c $(CFLAGS) -I/usr/include/cppconn phonebook.cpp

phonetest.o: phonetest.cpp phoneentry.h	phonebook.h
	$(CC) -c $(CFLAGS) phonetest.cpp

phonetest: phonetest.o phonebook.o phoneentry.o
	$(CC) phonetest.o phonebook.o phoneentry.o -L/usr/lib -o phonetest -L/usr/local/lib -lcgicc -lmysqlcppconn

phoneapp.o: phoneapp.cpp
	$(CC) -c $(CFLAGS) phoneapp.cpp

phoneapp: phoneapp.o phonebook.o phoneentry.o
	$(CC) phoneapp.o phonebook.o phoneentry.o -o phoneapp -L/usr/local/lib -lcgicc -lmysqlcppconn

PutCGI: phoneapp
	chmod 757 phoneapp
	cp phoneapp /usr/lib/cgi-bin/$(USER)_phoneappcomplete.cgi

	echo "Current contents of your cgi-bin directory: "
	ls -l /usr/lib/cgi-bin/

PutHTML:
	cp html/index.html /var/www/html/class/softdev/$(USER)/PhoneBook
	cp html/script.js /var/www/html/class/softdev/$(USER)/PhoneBook
	cp html/style.css /var/www/html/class/softdev/$(USER)/PhoneBook


	echo "Current contents of your HTML directory: "
	ls -l /var/www/html/class/softdev/$(USER)/PhoneBook/html

clean:
	rm -f *.o phonetest phoneapp
