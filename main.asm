;With this program we are print a character to the screen
;that permit us to know that we have succesfully loaded our boot sector
;1st move the commands that moves your courso forward to ah register
;allows the lateral printing of characters
;2nd move into al our character
;3rd we will use the bios interrupt to print it to the screen
mov ah, 0x0e
mov al, 'X'
int 0x10
;and then we will jump to an infinite loop
;that jump to our current location
jmp $
;boot sector 512 bytes
;Add everything, we don't write of this portion with zeros
;padding 510's zero minus current location(in memory or in boot location)
;minus the start location of the boot sector 
;Then, we want 510 minus the segment of code
;or minus the segment that we have writen in MBR
;Because our current location, minus the start location is the
;total amount of the stuff that weǘe written
times 510-($-$$) db 0
;padding magic number 
;signature, last two reminder bytes of the first sector 
;then bios will try booting the system 
;if it is not found you'll get an error message 
;0b1010101001010101(little-endian)
dw 0xaa55





