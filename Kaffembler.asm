; Thermometer aktivieren
;
;             ---- DQ
;             |--- CLK
;             ||-- RST
;             |||
MOV P3, #00000001b

; LEDs ausschalten
MOV P2, #01111111b



LOOP:
  
  CALL CHECK_READY
  ;CALL CHECK_COLD
  
  JMP LOOP

CHECK_READY:
  MOV A, P0
  ANL A, #00000100b

  CJNE A, #00000000b, READY_ON
  ;CJNE A, #00000001b, READY_OFF ;abbrechen
  JMP CHECK_READY
  ;RET

CHECK_COLD:
  MOV A, P0
  ANL A, #00000010b

  CJNE A, #00000000b, COLD_ON
  ;CJNE A, #00000010b, COLD_OFF
  JMP CHECK_COLD
  ;RET

COLD_ON:
  CLR P2.7
  SETB P2.6
  JMP CHECK_READY
  ;RET

;COLD_OFF:
;  ANL P2, #01111111b

;  RET



READY_ON:
  CLR P2.6
  SETB P2.7
  ;ANL P2, #01111111b
  
  JMP CHECK_COLD
  ;RET

;READY_OFF:
;  ORL P2, #01000000b
  
;  RET