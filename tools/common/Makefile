# Compiler settings
CC     = g++
CFLAGS = -Wall
RFLAGS = -O3
DFLAGS = -g

# Custom include paths and library names (space separated)
INC  = 
LIBS = 

# Path settings
SRC_ROOT = .
OUTFILE  = $(shell basename `pwd`)

# Debugger settings
DBG = insight

# Automagically find all source files, header files, include directories, and object files
SRC_C=$(shell find -L ${SRC_ROOT} -name '*.cpp' -type f)
SRC_H=$(shell find -L ${SRC_ROOT} -name '*.h' -type f)
DIR_H=$(sort ${foreach FILE_H,${SRC_H},$(dir ${FILE_H})})
OBJ  =$(SRC_C:%.cpp=%.o)

# Create the include and library strings
INC_STR=$(addprefix -I,${INC} $(DIR_H))
LIB_STR=$(addprefix -l,$(LIBS))

# Set release flags as default
CFLAGS += $(RFLAGS)

# Compile target (default)
${OUTFILE}: ${SRC_H} ${OBJ} Makefile
	${CC} -o ${OUTFILE} ${CFLAGS} ${LIB_STR} ${INC_STR} ${OBJ}

%.o: %.cpp ${SRC_H} Makefile
	${CC} ${CFLAGS} ${INC_STR} -c $< -o $@

# Execution target
.PHONY: run
run: ${OUTFILE}
	@./${OUTFILE}

# Debug target
.PHONY: debug
debug: CFLAGS := $(subst $(RFLAGS),$(DFLAGS),$(CFLAGS))
debug: clean ${OUTFILE}
	${DBG} ${OUTFILE}
	make clean

# Clean target
.PHONY: clean
clean:
	rm -f ${OUTFILE} ${OBJ}

