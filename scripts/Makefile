# Compiler settings
CC     = g++
CFLAGS = -Wall -O3

# Custom include paths and library names (space separated)
INC    = 
LIBS   = 

# Path settings
SRC_ROOT = .
OUTFILE  = $(shell basename `pwd`)

# Automagically find all source files, header files, and include directories
SRC_C=$(shell find ${SRC_ROOT} -name *cpp -type f)
SRC_H=$(shell find ${SRC_ROOT} -name *h -type f)
DIR_H=$(sort ${foreach FILE_H,${SRC_H},$(dir ${FILE_H})})

# Create the include and library strings
INC_STR=$(addprefix -I,${INC} $(DIR_H))
LIB_STR=$(addprefix -l,$(LIBS))

# Compile target
${OUTFILE}: ${SRC_C} ${SRC_H}
	${CC} -o ${OUTFILE} ${CFLAGS} ${LIB_STR} ${INC_STR} ${SRC_C}

# Execution target
run: ${OUTFILE}
	@./${OUTFILE}

# Clean target
.PHONY: clean
clean:
	rm -f ${OUTFILE}

