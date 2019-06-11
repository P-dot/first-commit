[org 0x7c00]

;mov si, STR_O
;call printf

;mov si, STR_T
;call printf

;mov si, STR_TH
;call printf

mov al, 1
mov cl, 2
call readDisk
jmp test

jmp $

printf: 
  pusha
  str_loop:
    mov al, [si]
    cmp al, 0
    jne print_char 
    popa 
    ret

  print_char:
    mov ah, 0x0e
    int 0x10
    add si, 1
    jmp str_loop

readDisk: 
    pusha 
    mov ah, 0x02
    mov dl, 0x00
    mov ch, 0
    mov dh, 0
    ;mov al, 1
    ;lmov cl, 2

    push bx 
    mov bx, 0
    mov es, bx
    pop bx
    mov bx, 0x7c00 + 512

    int 0x13
    
    jc disk_err
    popa 
    ret

    disk_err:
      mov si, DISK_ERR_MSG
      call printf
      jmp $

;STR_O: db 'Loaded in 16 bit Real Mode to memory location 0x7c00.', 0x0a, 0x0d, 0
;STR_T: db 'These messages use the BIOS interrupt 0x10 with the ah register set to 0x0e.', 0x0a, 0x0d, 0
;STR_TH db 'Polimata test boot complete. Power off thsi machine and load a real OS, dummy.', 0
;only need 0 as this is the last sentence to be printed.
DISK_ERR_MSG: db 'Erro Loading Disk.', 0x0a, 0x0d, 0
TEST_STR: db 'You are in the second sector.', 0x0a, 0x0d, 0

;padding and magic number 
times 510 - ($-$$) db  0
dw 0xaa55

test:
mov si, TEST_STR
call printf

times 512 db 0 
