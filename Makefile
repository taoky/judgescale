CC=gcc
TARGET1=judgescale
TARGET2=prog

all: $(TARGET1) $(TARGET2)

$(TARGET1): $(TARGET1).c
	$(CC) $(TARGET1).c -lcgroup -lm -Wall -o $(TARGET1)

$(TARGET2): $(TARGET2).c
	$(CC) $(TARGET2).c -Wall -o $(TARGET2)

clean:
	rm -f $(TARGET1) $(TARGET2)