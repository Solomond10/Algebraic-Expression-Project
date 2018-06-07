TITLE			Lab08SubP
;Programmer:	Solomon Davis
;Due Date:		April 20, 2018
;Description:	This program will ask the user for an algebraic
;				expression. The user will enter an algebraic 
;				expression that will run through a program to
;				detect any mismatches or missing brackets, braces
;				and parenthesis. Each character from the expression
;				will be entered from the keyboard. After each entry
;				the user will be prompted to stop or keep going. If
;				they stop the the expression will be put through a
;				check. The check will see if there is are any
;				mismatches or missing symbols in the expression.
;				The code will push open symbols to the stack. 
;				When the code starts to see that closed symbols
; 				are appearing it will then pop the open symbols
;				from the stack and compare to see if they match. 

INCLUDE			PCMAC.INC
				.MODEL SMALL
				.386
;=================================
				.DATA
EXTRN			bracketCnt:BYTE
EXTRN			braceCnt:BYTE
EXTRN			pthesisCnt: BYTE
EXTRN			errorCnt:BYTE
EXTRN			validation:BYTE
EXTRN			mismatchError:BYTE
EXTRN			mismatchError2:BYTE
EXTRN			missingError:BYTE
EXTRN			missingError2:BYTE
EXTRN			mismatchErr1:BYTE
EXTRN			mismatchErr2:BYTE
EXTRN			mismatchErr3:BYTE
EXTRN			mismatchErr4:BYTE
EXTRN			mismatchErr5:BYTE
EXTRN			mismatchErr6:BYTE	
EXTRN			symbolCnt:BYTE			

;=================================
				.CODE
				EXTRN		PutStr : NEAR
				Public		DispErrors
DispErrors		PROC		NEAR	

				push		ax
				push		bx
				push		cx
				push		dx

SymbolCheck:	cmp			symbolCnt, 0					;Compares symbolCnt
															;to 0
				jne			IncErrorCnt						;Jumps if symbolCnt
															;is odd	
								
DispMsg:		xor			ax, ax							;Clears ax register
				cmp			errorCnt, 0						;Compares errorCnt to 0
				jg			DispInvalid						;Jumps to DispInvalid
															;if value is greater than
															;compared value
				je			DispValid						;Jumps to DispValid
															;if value is equal to
															;compared value											
				mov			al, pthesisCnt					;Moves pthesisCnt to al
				cmp			pthesisCnt, 0					;Compares pthesisCnt
															;to 0
				jl			DispMissingErr1					;Jumps to
															;DispMissingErr1
															;if value is less than
															;compared value
				jg			DispMissingErr2					;Jumps to 
															;DispMissingErr2
															;if value is greater than
															;compared value
				mov			al, bracketCnt					;Moves bracketCnt to al
				cmp			al, 0							;Compares value of al
															;to 0
				jl			DispMissingErr3					;Jumps to 
															;DispMissingErr3
															;if value is less than
															;compared value
				jg			DispMissingErr4					;Jumps to 
															;DispMissingErr4
															;if value is greater than
															;compared value
				mov			al, braceCnt					;Moves braceCnt to al
				cmp			al, 0							;Compares value of al
															;to 0
				jl			DispMissingErr5					;Jumps to 
															;DispMissingErr5
															;if value is less than
															;compared value
				jg			DispMissingErr6					;Jumps to 
															;DispMissingErr6
															;if value is greater than
															;compared value
				xor			ax, ax							;Clears ax register
				mov			al, mismatchErr1				;Moves mismatchErr1
															;into al
				cmp			al, 0							;Compares al value
															;to 0
				jg			DispMismatchErr1				;Jumps to 
															;DispMismatchErr1
															;if value is greater than
															;compared value
				mov			al, mismatchErr2				;Moves mismatchErr2
															;into al
				cmp			al, 0							;Compares al value to 0
				jg			DispMismatchErr2				;Jumps to 
															;DispMismatchErr2
															;if value is greater than
															;compared value
				mov			al, mismatchErr3				;Moves mismatchErr3
															;into al
				cmp			al, 0							;Compares al value to 0
				jg			DispMismatchErr3				;Jumps to 
															;DispMismatchErr3
															;if value is greater than
															;compared value
				mov			al, mismatchErr4				;Moves mismatchErr4
															;into al
				cmp			al, 0							;Compares al value to 0
				jg			DispMismatchErr4				;Jumps to 
															;DispMismatchErr4
															;if value is greater than
															;compared value
				mov			al, mismatchErr5				;Moves mismatchErr5
															;into al
				cmp			al, 0							;Compares al value to 0
				jg			DispMismatchErr5				;Jumps to DispMismatchErr5
															;if value is greater than
															;compared value
				mov			al, mismatchErr6				;Moves mismatchErr6
															;into al
				cmp			al, 0							;Compares al value to 0
				jg			DispMismatchErr6				;Jumps to 
															;DispMismatchErr6
															;if value is greater than
															;compared value

				pop			dx
				pop			cx
				pop			bx
				pop			ax

				ret
				
DispErrors		ENDP
;================================================
IncErrorCnt:	
				inc			errorCnt
				jmp			DispMsg
;================================================																	
DispMissingErr1:
			
				mov			dx, OFFSET missingError + 0		;Moves offset of
															;missingError
															;into dx
				mov			ah, 9h							;Moves 9h into ah
				int			21h								;Displays dx to screen
				inc			pthesisCnt						;Increments pthesisCnt
				jmp			DispMsg							;Jumps to DispMsg
							
;================================================
DispMissingErr2:
			
				mov			dx, OFFSET missingError + 11	;Moves offset of 
															;missingError
															;into dx
				mov			ah, 9h							;Moves 9h into ah
				int			21h								;Displays dx to screen
				dec			pthesisCnt						;Decrements pthesisCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMissingErr3:
				
				mov			dx, OFFSET missingError + 22	;Moves offset of 
															;missingError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				inc			bracketCnt						;Increments bracketCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMissingErr4:
				
				mov			dx, OFFSET missingError2 + 0	;Moves offset of
															;missingError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				dec			bracketCnt						;Decrements bracketCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMissingErr5:
				
				mov			dx, OFFSET missingError2 + 11	;Moves offset of 
															;missingError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				inc			braceCnt						;Increments braceCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMissingErr6:
										
				mov			dx, OFFSET missingError2 + 22	;Moves offset of 
															;missingError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				dec			braceCnt						;Decrements braceCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMismatchErr1:
				mov			dx, OFFSET mismatchError + 0	;Moves offset of
															;mismatchError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				dec			mismatchErr1					;Decrements 
															;mismatchErr1
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMismatchErr2:
				mov			dx, OFFSET mismatchError + 13	;Moves offset of 
															;mismatchError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				dec			mismatchErr2					;Decrements 
															;mismatchErr2
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMismatchErr3:
				mov			dx, OFFSET mismatchError + 26	;Moves offset of 
															;mismatchError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int 		21h								;Displays dx to screen
				dec			mismatchErr3					;Decrements 
															;mismatchErr3
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMismatchErr4:
				mov			dx, OFFSET mismatchError2 + 0	;Moves offset of 
															;mismatchError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				dec			mismatchErr4					;Decrements
															;mismatchErr4
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMismatchErr5:
				mov			dx, OFFSET mismatchError2 + 13	;Moves offset of
															;mismatchError
															;into dx
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				dec			mismatchErr5					;Decrements 
															;mismatchErr5
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispMismatchErr6:
				mov			dx, OFFSET mismatchError2 + 26	;Moves offset of
															;mismatchError
															;into dx
				mov			ah, 9h							;Moves 9h into ah
				int			21h								;Displays dx to screen
				dec			mismatchErr6					;Decrements
															;mismatchErr6
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispValid:
				_PutCh		13,10							;Displays next line
															;to screen
				mov			dx, OFFSET validation + 0		;Moves offset of
															;validation
															;in dx for display
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				mov			errorCnt, -1					;Moves -1 into errorCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================				
DispInvalid:
				_PutCh		13,10							;Displays next line
															;to screen
				mov			dx, OFFSET validation + 7		;Moves offset of
															;validation
															;in dx for display
				mov			ah, 9h							;Moves 9h into ah 
				int			21h								;Displays dx to screen
				mov			errorCnt, -1					;Moves -1 into errorCnt
				jmp			DispMsg							;Jumps to DispMsg
;================================================
				END					
					