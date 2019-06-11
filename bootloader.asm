[org 0x7c00]

mov si, STR_0
call printf

mov si, STR_T
call printf

mov si, STR_TH
call printf

jmp $

printf:
  pusha
  str_loop:
    mov al, [si]
    cmp al, 0
    jne print_char
    popa
    ret

  print char:
    mov ah, 0x0e
    int 0x10
    add si, 1
    jmp str_loop

readDisk:
   pusha
   mov ah, 0x02
   mov dl, 0x0
   mov ch, 0
   mov dh, 0
   mov al, 1
   mov cl, 1

   push bx 
   mov bx, 0
   mov es, bx
   pop bx
   mov bc, 0x7c00 + 512

   jc disk_err
   popa
   ret

   disk_err:
     
    

STR_O: db 'Loaded in 16-bit real mode to memory location 0x7c00.' 0x0e, 0x0d, 0
STR_T: db 'These Messages use the BIOS interrupt 0x10 with the ah register set to 0x0e.' 0x0a, 0x0d, 0
STR_TH: db 'Polimata test boot complete. Power of this machine and load a real OS, dummy', 0
DISK_ERR_MSG: db 'Error loading Disk.'

times 510-($-$$) db 0
dw 0xaa55

