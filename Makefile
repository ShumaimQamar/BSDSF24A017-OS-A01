CC = gcc
CFLAGS =  -Iinclude
BIN_DIR = bin
OBJ_DIR = obj
SRC_DIR = src
TARGET = $(BIN_DIR)/client

export CC CFLAGS OBJ_DIR

all: $(TARGET)

$(TARGET):
	mkdir -p $(BIN_DIR) $(OBJ_DIR)
	$(MAKE) -C $(SRC_DIR)
	$(CC) $(OBJ_DIR)/*.o -o $(TARGET)

clean:
	$(MAKE) -C $(SRC_DIR) clean
	rm -rf $(BIN_DIR) $(OBJ_DIR)

.PHONY: all clean
