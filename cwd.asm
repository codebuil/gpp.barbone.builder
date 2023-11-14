;nasm -felf32 -o cwd.o cwd.asm
;gcc cwd.o -o cwd.elf -nostdlib


section .data
    hello db 27,'c',27,'[43;30m'
    buffer resb 255 ; buffer para armazenar o diretório

section .text
    global _start

_start:
    ; Chama a syscall getcwd
    mov eax, 183       ; syscall number para getcwd
    mov ebx, buffer    ; ponteiro para o buffer
    mov ecx, 255       ; tamanho máximo do buffer
    int 0x80           ; interrupção do sistema

    ; Verifica se houve erro (o valor de retorno está em EAX)
    cmp eax, 0
    jl erro_ocorreu

    ; Imprime o diretório atual
    mov eax, 10        ; write
    clc
    add ecx,eax
    mov eax, 4         ; syscall number para write
    mov ebx, 1         ; stdout
    mov edx, ecx       ; tamanho da string
    mov ecx, hello    ; ponteiro para a string
    int 0x80           ; interrupção do sistema

    jmp fim

erro_ocorreu:
    ; Ocorreu um erro ao chamar getcwd
    ; O código de erro está em eax
    ; Adicione o código de manipulação de erro conforme necessário

fim:
    ; Finaliza o programa
    mov eax, 1         ; syscall number para exit
    xor ebx, ebx       ; código de saída 0
    int 0x80           ; interrupção do sistema

