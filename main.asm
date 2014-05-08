#INCLUDE<P16F84A.INC>
        __CONFIG    _XT_OSC
        CBLOCK  OCH
        CROW
        BUT
        PTR
        ORG     00H
CONF:   BSF     STATUS,RP0
        BCF     OPTION_REG,NOT_RBPU
        MOVLW   0F0H
        MOVWF   PORTB
        CLRF    PORTA
        BCF     STATUS,RP0
START:  CLRF    CROW
        CLRF    BUT
        MOVLW   04H
        MOVWF   PRT
CICLO1: MOVF    CROW,0
        CALL    ROWS
        MOVWF   PORTB
        CALL    RROW
        INCF    BUT
        INCF    PRT
        MOVF    CROW,0
        SUBLW   O3H
        BTFSC   Z
        GOTO    START
        INCF    CROW
        GOTO    CICLO1
RROW:   BTFSC   PORTB,PRT
        RETURN
        BTFSC   PORTB,PTR
        GOTO    $-1
        CALL    NUM
        RETURN
NUM:    MOVF    BUT,0
        MOVWF   PORTA
        RETURN
ROWS:   ADDWF   PCL,1
        RETLW   10H
        RETLW   20H
        RETLW   40H
        RETLW   80H
        END
