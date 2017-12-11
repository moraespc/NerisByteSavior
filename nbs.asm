
; Codigo Fonte - Jogo: "Neris Byte Savior - Space Station"
; Laboratorio de Arquiterura e Organizacao de Computadores 2
; Alunos: Anderson
;         Paulo Cesar de Moraes Filho 489247
;         Sergio Ricardo Hideki Nisikava
;Utilizacao da Biblioteca Irvine para arquitetura x86.

INCLUDE ..\Irvine32.inc

;Declaracao de estruturas


;Declaracao prototipos de funcoes
RenderScreen PROTO, addrAscii:DWORD, addrColors:DWORD

;Declaracao das variaveis
.data
	blankScreenAscii BYTE 600 DUP(20h)
	blankScreenColors DWORD 600 DUP(black+(yellow*16))
	
.code
main PROC
	;int 3
	
	INVOKE RenderScreen, ADDR blankScreenAscii, ADDR blankScreenColors
	mov eax, 10000
	call Delay
	
	call RestoreConsole
	
	exit
	
main ENDP

RenderScreen PROC USES edi esi eax ecx edx addrAscii:DWORD, addrColors:DWORD
			call Clrscr
					
			mov esi, addrAscii
			mov edi, addrColors
			mov dl, 0
			mov dh, 0
			call Gotoxy
			
			mov ecx, 20
ENDCOL:		push ecx

			mov ecx, 30			
		
ENDLINE:	
			;exemplo de alteracao
			mov eax, [edi]
			call SetTextColor
			
			mov al, [esi]
			call WriteChar
			
			inc esi
			add edi, 4
			loop ENDLINE
			
			call Crlf
			pop ecx
			loop ENDCOL
			
			ret
RenderScreen ENDP
			
			



RestoreConsole PROC
			mov eax, white+(black*16)
			call SetTextColor
			call Clrscr
			
			ret
RestoreConsole ENDP

END main
