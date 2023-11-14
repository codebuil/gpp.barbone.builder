;nasm -felf32 -o timer.o timer.asm
;gcc timer.o -o timer.elf -nostdlib
section .data
    timer resd 1  ; Variável para armazenar o timer
    delay equ 12  ; Delay desejado em segundos
    mensagem db 27,"c",27,"[43;30mwait....", 0xA
    tamanho equ $ - mensagem

section .text
    global _start

_start:
    mov eax, 4        ; syswrite
    mov ebx, 1        ; stdout
    mov ecx, mensagem ; endereço da mensagem
    mov edx, tamanho  ; tamanho da mensagem
    int 0x80          ; chama a interrupção do sistema
    
    ; Chama a syscall time para obter o tempo atual
    mov edx,0
    mov ecx,0
    mov ebx,0
    mov eax, 13        ; syscall number para time
    int 0x80           ; interrupção do sistema
    mov edx,12
    add edx, eax
    ; Salva o resultado (tempo atual) em 'timer'
    mov [timer], eax

verifica_timer:
    ; Chama a syscall time novamente para obter o tempo atual
    mov eax, 13        ; syscall number para time
    int 0x80           ; interrupção do sistema

    ; Adiciona o delay desejado ao valor atual do timer

    ; Compara com o valor salvo anteriormente
    cmp eax, edx

    ; Se ainda não passaram 12 segundos, continua o loop
    jl verifica_timer

    ; Se passaram 12 segundos, saia do loop e finalize o programa
    jmp fim

fim:
    ; Finaliza o programa
    mov eax, 1         ; syscall number para exit
    xor ebx, ebx       ; código de saída 0
    int 0x80           ; interrupção do sistema

