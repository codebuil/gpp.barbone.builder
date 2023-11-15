;nasm -felf32 -o mkdir.o mkdir.asm
;gcc mkdir.o -o mkdir.elf -nostdlib
section .data
    comando db '/bin/ls', 0         ; Caminho do comando 'ls'
    argumentos dd comando, 0         ; Ponteiro para o caminho do comando
              dd 0                   ; Lista de argumentos terminada com NULL
    mensagem db 27,"c",27,"[43;30mrun....", 0xA
    tamanho equ $ - mensagem
section .text
    global _start

_start:
    mov eax, 4        ; syswrite
    mov ebx, 1        ; stdout
    mov ecx, mensagem ; endereço da mensagem
    mov edx, tamanho  ; tamanho da mensagem
    int 0x80          ; chama a interrupção do sistema
    ; Chama a syscall execve para executar o comando 'ls'
    mov eax, 11              ; syscall number para execve
    mov ebx, comando         ; ponteiro para o caminho do comando
    mov ecx, argumentos      ; ponteiro para a lista de argumentos
    mov edx, 0               ; ponteiro para o ambiente (NULL para usar o ambiente atual)
    int 0x80                 ; interrupção do sistema

    ; Verifica se ocorreu algum erro (o valor de retorno está em EAX)
    cmp eax, 0
    jl erro_ocorreu

    ; Se não houve erro, finaliza o programa
    mov eax, 1               ; syscall number para exit
    xor ebx, ebx             ; código de saída 0
    int 0x80                 ; interrupção do sistema

erro_ocorreu:
    ; Ocorreu um erro ao chamar execve
    ; O código de erro está em eax
    ; Adicione o código de manipulação de erro conforme necessário

    ; Finaliza o programa
    mov eax, 1               ; syscall number para exit
    xor ebx, ebx             ; código de saída 0
    int 0x80                 ; interrupção do sistema

