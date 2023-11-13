   section .data
    arquivo db 'hello.txt', 0 ; Nome do arquivo
    buffer resb 64            ; Buffer para armazenar a mensagem lida do arquivo
    tamanho_buffer equ 64      ; Tamanho do buffer

section .text
    global _start

_start:
    ; Abrir o arquivo
    mov eax, 5          ; sys_open
    mov ebx, arquivo    ; nome do arquivo
    mov ecx, 0          ; O_RDONLY (abrir apenas para leitura)
    int 0x80            ; chama a interrupção do sistema
    mov edx, eax        ; Salva o descritor de arquivo retornado

    ; Ler o conteúdo do arquivo
    mov eax, 3          ; sys_read
    mov ebx, edx        ; descritor de arquivo
    mov ecx, buffer     ; buffer para armazenar a mensagem
    mov edx, tamanho_buffer ; tamanho do buffer
    int 0x80            ; chama a interrupção do sistema

    ; Escrever a mensagem no console
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, buffer     ; endereço da mensagem
    mov edx, tamanho_buffer ; tamanho da mensagem lida
    int 0x80            ; chama a interrupção do sistema

    ; Fechar o arquivo
    mov eax, 6          ; sys_close
    mov ebx, edx        ; descritor de arquivo
    int 0x80            ; chama a interrupção do sistema

    ; Finalização do programa
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; código de saída 0
    int 0x80            ; chama a interrupção do sistema
