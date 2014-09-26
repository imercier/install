#include <termios.h>
#include <fcntl.h>
#include <stdio.h>

#define SERIAL_DEFAULT "/dev/ttyUSB0"

int tty_fd;
char reboot = 'b';


int main(int argc,char** argv) {

	if (argc<2) {
		tty_fd = open(SERIAL_DEFAULT, O_RDWR | O_NONBLOCK);
	} else {
		tty_fd = open(argv[1], O_RDWR | O_NONBLOCK);
	}

	tcsendbreak(tty_fd, 0);
	write(tty_fd, &reboot, 1); 

	return 0;
}
