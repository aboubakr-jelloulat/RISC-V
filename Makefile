
All: compile startqemu  

compile: main.s main.ld
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tmain.ld main.s -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

printbinary: main.bin
	xxd -e -c 4 -g 4  main.bin  


startqemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -gdb tcp::1234 

connectgdb : main.elf
	gdb-multiarch main.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" -q

clean:
	rm -rf *.out *.bin *.elf .gdb_history



.PHONY: machinecode printbinary startqemu connectgdb clean 