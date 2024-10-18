MCU=msp430fr6989

MSP_TOOLS_HOME=/home/rellow/Downloads/msp430-gcc-9.3.1.11-source-full/install/usr/local/bin
MSP_SUPPORT_HOME=/home/rellow/Downloads/msp430-gcc-support-files

INC_DIR=$(MSP_SUPPORT_HOME)/include
IFLAGS=-I$(INC_DIR) -T $(MCU).ld
LIB_DIR=$(MSP_SUPPORT_HOME)/include
LFLAGS=-L $(LIB_DIR) -T $(MCU).ld

CC=$(MSP_TOOLS_HOME)/msp430-elf-gcc
CFLAGS=-Wall -g -O0 -mmcu=$(MCU)

OBJS=blink.o
ELF=blink.elf

all: $(OBJS)
	@echo "Linking OBJ..." 
	$(CC) $(CFLAGS) $(LFLAGS) $? -o $(ELF)

%.o: %.c
	@echo "Building OBJ..."
	$(CC) $(CFLAGS) $(IFLAGS) -c $<

clean:
	rm -r $(OBJS) $(ELF)
