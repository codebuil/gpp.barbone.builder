section .data
    arquivo db 'hello.txt', 0 ; Nome do arquivo
    mensagem db 'hello world...', 0xA ; Mensagem a ser escrita no arquivo

section .text
    global _start

_start:
    ; Abrir ou criar o arquivo
    mov eax, 8          ; sys_creat (ou sys_open com O_CREAT | O_WRONLY | O_TRUNC)
    mov ebx, arquivo    ; nome do arquivo
    mov ecx, 0x641      ; O_CREAT | O_WRONLY | O_TRUNC (permissões 0644 em octal)
    int 0x80            ; chama a interrupção do sistema
    mov edx, eax        ; Salva o descritor de arquivo retornado

    ; Escrever a mensagem no arquivo
    mov eax, 4          ; sys_write
    mov ebx, edx        ; descritor de arquivo
    mov ecx, mensagem   ; endereço da mensagem
    mov edx, 15         ; tamanho da mensagem
    int 0x80            ; chama a interrupção do sistema

    ; Fechar o arquivo
    mov eax, 6          ; sys_close
    mov ebx, edx        ; descritor de arquivo
    int 0x80            ; chama a interrupção do sistema

    ; Finalização do programa
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; código de saída 0
    int 0x80            ; chama a interrupção do sistema

