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
DBG = ddd

# Automagically find all source files, header files, and include directories
SRC_C=$(shell find -L ${SRC_ROOT} \( -name '*.c' -o -name '*.cpp' \) -type f)
SRC_H=$(shell find -L ${SRC_ROOT} -name '*.h' -type f)
DIR_H=$(sort ${foreach FILE_H,${SRC_H},$(dir ${FILE_H})})

# Create the include and library strings
INC_STR=$(addprefix -I,${INC} $(DIR_H))
LIB_STR=$(addprefix -l,$(LIBS))

# Set release flags as default
CFLAGS += $(RFLAGS)

# Compile target (default)
${OUTFILE}: ${SRC_C} ${SRC_H}
	${CC} -o ${OUTFILE} ${CFLAGS} ${LIB_STR} ${INC_STR} ${SRC_C}

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
	rm -f ${OUTFILE}

