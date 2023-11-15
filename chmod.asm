;nasm -felf32 -o mkdir.o mkdir.asm
;gcc mkdir.o -o mkdir.elf -nostdlib
section .data
    nome_arquivo db 'meu_arquivo.txt', 0  ; Nome do arquivo
    permissao     equ 777                  ; Permissões octais (rwxrwxrwx)
    mensagem db 27,"c",27,"[43;30mchmod....", 0xA
    tamanho equ $ - mensagem

section .text
    global _start

_start:
    mov eax, 4        ; syswrite
    mov ebx, 1        ; stdout
    mov ecx, mensagem ; endereço da mensagem
    mov edx, tamanho  ; tamanho da mensagem
    int 0x80          ; chama a interrupção do sistema
    ; Chama a syscall chmod para alterar os atributos do arquivo
    mov eax, 15               ; syscall number para chmod
    mov ebx, nome_arquivo     ; ponteiro para o nome do arquivo
    mov ecx, permissao        ; permissões octais
    int 0x80                  ; interrupção do sistema

    ; Verifica se ocorreu algum erro (o valor de retorno está em EAX)
    cmp eax, 0
    jl erro_ocorreu

    ; Se não houve erro, finaliza o programa
    mov eax, 1                ; syscall number para exit
    xor ebx, ebx              ; código de saída 0
    int 0x80                  ; interrupção do sistema

erro_ocorreu:
    ; Ocorreu um erro ao chamar chmod
    ; O código de erro está em eax
    ; Adicione o código de manipulação de erro conforme necessário

    ; Finaliza o programa
    mov eax, 1                ; syscall number para exit
    xor ebx, ebx              ; código de saída 0
    int 0x80                  ; interrupção do sistema

