TITLE			Lab08SD
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
				.STACK 128
				
;================================================
				.DATA
Public			braceCnt
Public			bracketCnt
Public			pthesisCnt
Public			errorCnt
Public			validation
Public			mismatchError
Public 			mismatchError2
Public			missingError
Public 			missingError2
Public			mismatchErr1
Public			mismatchErr2
Public			mismatchErr3
Public			mismatchErr4
Public			mismatchErr5
Public			mismatchErr6
Public			symbolCnt	
userPrompt		DB		"Enter an algebraic expression: $", 13,10 
errorChoice		DB		13,10,"Please enter a valid choice", 13,10, "$"
question		DB		13,10,"Do you want to continue? (Y - Yes N - No): $", 13,10 
pthesisCnt		DB		?
errorCnt		DB		?
bracketCnt		DB		?
braceCnt		DB		?
missingError	DB		'Missing ( $', 'Missing ) $', 'Missing [ $'
missingError2	DB	    'Missing ] $','Missing { $', 'Missing } $'
mismatchError	DB		'Mismatch {) $', 'Mismatch [) $', 'Mismatch (] $'
mismatchError2	DB	    'Mismatch {] $', 'Mismatch (} $', 'Mismatch [} $'
validation		DB		'Valid $', 'Invalid: $'
mismatchErr1	DB		?
mismatchErr2	DB		?
mismatchErr3	DB		?
mismatchErr4	DB		?
mismatchErr5	DB		?
mismatchErr6	DB		?
userChoice		DB		?
symbolCnt		DB		?
;================================================
				.CODE
				EXTRN		PutStr : NEAR, GetCh :	NEAR, DispErrors : NEAR
				
Main			PROC		NEAR
				
				mov			ax, @Data
				mov			ds, ax
				
DisplayQPrompt:	mov			errorCnt, 0						;Clears errorCnt
				_PutStr		userPrompt						;Displays userPrompt
															;to screen


AskUserForExp:	_GetCh		al								;Gets char from
															;keyboard
				cmp			al, 13							;Compares char to
															;carriage
															;return
				jne			Process							;Jumps to process
															;if character is
															;not equal to
															;carriage return

GetErrors:		call		DispErrors						;Calls subroutine 
															;DispErrors
				
Retry:			_PutStr		question						;Displays question
															;to screen
				_GetCh		al								;Gets char from
															;keyboard
				mov			userChoice, al					;Moves al to userChoice
				_PutCh		13,10							;Displays next line to
															;screen
				mov			al, userChoice					;Moves userChoice to al
				cmp			al, 'Y'							;Compares al to char Y
				je			DisplayQPrompt					;Jumps to 
															;DisplayQPrompt
															;if value is equal to
															;compared value
				cmp			al, 'y'							;Compares al to char y
				je			DisplayQPrompt					;Jumps to 
															;DisplayQPrompt
															;if value is equal to
															;compared value
				cmp			al, 'N'							;Compares al to char N
				je			done							;Jumps to EndLoop
															;if value is equal to
															;compared value
				cmp			al, 'n'							;Compares al to char n
				je			done							;Jumps to EndLoop
															;if value is equal to
															;compared value
				_PutStr		errorChoice						;Displays errorChoice 
															;to screen
				jmp			Retry							;Jumps to Retry	
	
done:			mov			ax, 4c00h
				int			21h
				
ENDP			Main						
;===============================================
Process:		
				cmp			al, '('							;Compares al value to 
															;open parenthesis
				je			IncPthesisCnt					;Jump to IncPthesisCnt
															;if equal to compared
															;value
				cmp			al, '['							;Compares al value to
															;open bracket
				je			IncBracketCnt					;Jump to IncBracketCnt
															;if equal to compared
															;value
				cmp			al, '{'							;Compares al value to 
															;open brace
				je			IncBraceCnt						;Jump to IncBraceCnt
															;if equal to compared
															;value
				cmp			al, ')'							;Compares al value to 
															;closed parenthesis
				je			ClosedPthesisChk				;Jump to 
															;ClosedPthesisChk
															;if equal to compared
															;value 
				cmp			al, ']'							;Compares al value to 
															;closed bracket
				je			ClosedBracketChk				;Jump to 
															;ClosedBracketChk
															;if equal to compared
															;value
				cmp			al, '}'							;Compares al value to 
															;closed brace
				je			ClosedBraceChk					;Jump to ClosedBraceChk
															;if equal to compared
															;value
				jmp			AskUserForExp					;Jumps to AskUserForExp
;===============================================
IncPthesisCnt:
				inc			symbolCnt						;Increments symbolCnt
				inc			pthesisCnt						;Increments pthesisCnt
				push		ax								;Pushes ax value to 
															;stack
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
IncBracketCnt:
				inc			symbolCnt						;Increments symbolCnt
				inc			bracketCnt						;Increments bracketCnt
				push		ax								;Pushes ax value to
															;stack
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
IncBraceCnt:
				inc			symbolCnt						;Increments symbolCnt
				inc			braceCnt						;Increments braceCnt
				push		ax								;Pushes ax value to stack
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================	
ClosedPthesisChk:
				pop			ax								;Pops ax value to stack
				cmp			al, '('							;Compares al value to 
															;open parenthesis
				je			DecPthesisCnt					;Jumps to DecPthesisCnt
				cmp			al, '{'							;Compares al value to 
															;open brace
				je			MismactchErr1					;Jumps to MismactchErr1
															;if equal to compared
															;value
				cmp			al, '['							;Compares al value to 
															;open bracket
				je			MismactchErr2					;Jumps to MismactchErr2
															;if equal to compared
															;value
				jmp			DecPthesisCnt					;Jumps to DecPthesisCnt
;================================================
DecPthesisCnt:
				dec			symbolCnt						;Increments symbolCnt
				dec			pthesisCnt						;Decrements pthesisCnt
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
MismactchErr1:
				dec			symbolCnt						;Increments symbolCnt
				inc			errorCnt						;Increments errorCnt
				dec			braceCnt						;Decrements braceCnt
				inc			mismatchErr1					;Increments 
															;mismatchErr1
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
MismactchErr2:
				dec			symbolCnt						;Increments symbolCnt
				inc			errorCnt						;Increments errorCnt
				dec			bracketCnt						;Decrements braceCnt
				inc			mismatchErr2					;Increments 
															;mismatchErr2
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
ClosedBracketChk:
				pop			bx								;Pops value from
															;stack to bx
				cmp			bl, '['							;Compares al value to 
															;open bracket
				je			DecBracketCnt					;Jumps to 
															;DecBracketCnt if 
															;value is equal to compared
															;value
				cmp			bl, '('							;Compares al value to 
															;open parenthesis
				je			MismactchErr3					;Jumps to 
															;MismactchErr3 if 
															;value is equal to compared
															;value
				cmp			bl, '{'							;Compares al value to 
															;open brace
				je			MismactchErr4					;Jumps to 
															;MismactchErr4 if 
															;value is equal to compared
															;value
				jmp			DecBracketCnt					;Jumps to DecBracketCnt
;================================================
DecBracketCnt:
				dec			symbolCnt						;Increments symbolCnt
				dec			bracketCnt						;Decrements bracketCnt
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
MismactchErr3:
				dec			symbolCnt						;Increments symbolCnt
				inc			errorCnt						;Increments errorCnt
				dec			pthesisCnt						;Decrements pthesisCnt
				inc			mismatchErr3					;Increments
															;mismatchErr3
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
MismactchErr4:
				dec			symbolCnt						;Increments symbolCnt
				inc			errorCnt						;Increments errorCnt
				inc			mismatchErr4					;Increments
															;mismatchErr4
				dec			braceCnt						;Decrements braceCnt
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
ClosedBraceChk:
				pop			cx								;Pops value from 
															;stack to cx
				cmp			cl, '{'							;Compares al value to 
															;open brace
				je			DecBraceCnt						;Jumps to DecBraceCnt
															;if equal to compared
															;value
				cmp			cl, '('							;Compares al value to 
															;open parenthesis
				je			MismactchErr5					;Jumps to
															;MismactchErr5
															;if equal to compared
															;value
				cmp			cl, '['							;Compares al value to 
															;open bracket
				je			MismactchErr6					;Jumps to MismactchErr6
															;if value is equal to 
															;compared value
				jmp			DecBraceCnt						;Jumps to DecBraceCnt
;================================================
DecBraceCnt:
				dec			symbolCnt						;Increments symbolCnt
				dec			braceCnt						;Decrements braceCnt
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
MismactchErr5:
				dec			symbolCnt						;Increments symbolCnt
				inc			errorCnt						;Increments
															;errorCnt				
				inc			mismatchErr5					;Increments
															;mismatchErr5
				dec			pthesisCnt						;Decrements pthesisCnt
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
MismactchErr6:	
				dec			symbolCnt						;Increments symbolCnt
				inc			errorCnt						;Increments errorCnt
				inc			mismatchErr6					;Increments 
															;mismatchErr6
				dec			bracketCnt						;Decrements bracketCnt
				jmp			AskUserForExp					;Jumps to AskUserForExp
;================================================
END				Main
