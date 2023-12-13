SOURCE_FILE = casm
OUTPUT_EXEC = casm
NASM_FLAGS = -f elf
LD_FLAGS = -m elf_i386

all: $(OUTPUT_EXEC)

$(SOURCE_FILE).o: $(SOURCE_FILE).asm
	nasm $(NASM_FLAGS) -o $@ $<
	
$(OUTPUT_EXEC): $(SOURCE_FILE).o
	ld $(LD_FLAGS) -o $@ $<

clean:
	rm -f $(OUTPUT_EXEC) $(SOURCE_FILE).o