TARGET = cantest

CC = gcc
CFLAGS = -Wall #-Wextra

OUTDIR = ./src_py
SUBDIR = ./src
DIR_OBJ = ./obj
# SDL2_DIR = $(EXTERN_DIR)/SDL2
# SDL2_INCLUDE_DIR = $(SDL2_DIR)/x86_64-w64-mingw32/include
# SDL2_LIB_DIR = $(SDL2_DIR)/x86_64-w64-mingw32/lib
# SDL2_INCLUDE_DIR = $(SDL2_DIR)/i686-w64-mingw32/include
# SDL2_LIB_DIR = $(SDL2_DIR)/i686-w64-mingw32/lib
# SOURCES = source/main.c
# -s  -lmingw32 -lSDL2main -lSDL2.dll -luser32 -lgdi32 -lwinmm -ldxguid -mwindows
# INCS = $(wildcard *.h $(foreach fd, $(SUBDIR), $(fd)/*.h))
SRCS = $(wildcard *.c $(foreach fd, $(SUBDIR), $(fd)/*.c))
OBJS = $(addprefix $(DIR_OBJ)/, $(SRCS:c=o))
INC_DIRS = -I./ $(addprefix -I, $(SUBDIR))
LDFLAGS =

LIBS = $(addprefix -l, mingw32)
LIB_DIRS = #$(addprefix -L, $(SDL2_LIB_DIR))

__FLAGS = #-w -Wl,-subsystem,windows

$(TARGET): $(OBJS)
	$(CC) $(OBJS) $(CFLAGS) $(LIB_DIRS) -s $(LIBS) $(LDFLAGS) -o $(OUTDIR)/$@

$(DIR_OBJ)/%.o: %.c $(INCS)
	mkdir -p $(@D)
	$(CC) -o $@ $(CFLAGS) -c $< $(INC_DIRS)

print::
	@echo "INC files: $(INCS)"
	@echo "SRC files: $(SRCS)"
	@echo "OBJ files: $(OBJS)"
	@echo "LIB files: $(LIBS)"
	@echo "INC DIR: $(INC_DIRS)"
	@echo "LIB DIR: $(LIB_DIRS)"
