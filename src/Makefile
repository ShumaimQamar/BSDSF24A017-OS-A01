all: ../$(OBJ_DIR)/mystrfunctions.o ../$(OBJ_DIR)/myfilefunctions.o ../$(OBJ_DIR)/main.o

../$(OBJ_DIR)/mystrfunctions.o: mystrfunctions.c ../include/mystrfunctions.h
	$(CC) $(CFLAGS) -c mystrfunctions.c -o ../$(OBJ_DIR)/mystrfunctions.o

../$(OBJ_DIR)/myfilefunctions.o: myfilefunctions.c ../include/myfilefunctions.h
	$(CC) $(CFLAGS) -c myfilefunctions.c -o ../$(OBJ_DIR)/myfilefunctions.o

../$(OBJ_DIR)/main.o: main.c ../include/mystrfunctions.h ../include/myfilefunctions.h
	$(CC) $(CFLAGS) -c main.c -o ../$(OBJ_DIR)/main.o

clean:
	rm -f ../$(OBJ_DIR)/*.o

.PHONY: all clean
