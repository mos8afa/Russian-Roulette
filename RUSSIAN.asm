.model small
.stack 100h

.data

; ========= GUN (3 FRAMES) =========
Art0 db '      _  ________           ',13,10
     db '__  _| ||________|___/|___  ',13,10
     db '\ \/    | _______|    ___|  ',13,10
     db ' \/  ___| _______|____|     ',13,10
     db ' /   |\\ \________|         ',13,10
     db '|    \                      ',13,10
     db '|     \                     ',13,10
     db '|     |                     ',13,10
     db '|_____|                     ',13,10,0

Art1 db '      _  ________               ',13,10
     db '__  _| ||________|___/|___      ',13,10
     db '\ \/    | _______|    ___| ---- ',13,10
     db ' \/  ___| _______|____|         ',13,10
     db ' /   |\\ \________|             ',13,10
     db '|    \                          ',13,10
     db '|     \                         ',13,10
     db '|     |                         ',13,10
     db '|_____|                         ',13,10,0

; >>> You can replace Art2 with your custom kill art <<<
Art2 db '      _  ________                ',13,10
     db '__  _| ||________|___/|___    __ ',13,10
     db '\ \/    | _______|    ___| --|__|',13,10
     db ' \/  ___| _______|____|          ',13,10
     db ' /   |\\ \________|              ',13,10
     db '|    \               _____       ',13,10
     db '|     \             |     |      ',13,10
     db '|     |             |BOOM!|      ',13,10
     db '|_____|             |_____|      ',13,10,0

framePtrs    dw 3 dup(0)     ; [0]=Art0, [2]=Art1, [4]=Art2
artMaxW      db 0

; ========= HEAD (2 FRAMES) padded to 9 lines =========
HeadA db '    _____    ',13,10
      db '   /     \   ',13,10
      db '  |  O O  |  ',13,10
      db '  |   ^   |  ',13,10
      db '  |  ___  |  ',13,10
      db '   \_____/   ',13,10
      db '             ',13,10
      db '             ',13,10
      db '             ',13,10,0

HeadD db '    _____    ',13,10
      db '   /     \   ',13,10
      db '  |  X X  |  ',13,10
      db '  |   ^   |  ',13,10
      db '  |  ___  |  ',13,10
      db '   \_____/   ',13,10
      db '             ',13,10
      db '             ',13,10
      db '             ',13,10,0

; ========= UI POSITIONS =========
HDR_ROW      equ 1
HDR_COL      equ 2
SCORE_ROW    equ 2
SCORE_COL    equ 2
DICE_ROW     equ 3
DICE_COL     equ 2
SPIN_ROW     equ 4
SPIN_COL     equ 2

USER_ROW     equ 6
PC_ROW       equ 6

LOG_ROW      equ 22
LOG_COL      equ 2

userCol      db 2
pcCol        db 40

; ========= GAME VARS =========
roundCount   db 1
playerScore  db 0
pcScore      db 0

bulletPos    db 1
chPos        db 1

seed         dw 0
diceFinal    db 0

rfCol        db 0
mirrorFlag   db 0

targetSel    db 1       ; 0=USER victim, 1=PC victim

; ========= UI STRINGS =========
sTitle       db 'RUSSIAN ROULETTE (ONE GUN)',0
sUser        db 'USER',0
sPC          db 'PC',0
sRoundTxt    db 'ROUND: ',0

sScoreTxt1   db 'SCORE  USER:',0
sScoreTxt2   db '  PC:',0

sDice        db 'DICE : ',0
sPressRoll   db 'Press any key to ROLL dice (2-4)...',0
sSpin        db 'Spinning chamber...',0
sPickFirst   db 'Pick FIRST target: [1] SELF  [2] PC (then alternates)',0

sShotPC      db 'SHOT -> PC (press any key)...',0
sPCAutoShoot db 'PC shoots you...',0

sSafe        db 'Result: SAFE (click)',0
sBoomU       db 'Result: BOOM! PC is dead. USER wins round.',0
sBoomP       db 'Result: BOOM! USER is dead. PC wins round.',0

sBoomHold    db 'Press any key to continue...',0
sPlayAgain   db 'Play again? (Y/N): ',0

; ========= TUTORIAL =========
TutLogo db 13,10
        db '  ____  _   _ ____ ____ ___    _    _   _ ',13,10
        db ' |  _ \| | | / ___/ ___|_ _|  / \  | \ | |',13,10
        db ' | |_) | | | \___ \___ \| |  / _ \ |  \| |',13,10
        db ' |  _ <| |_| |___) |__) | | / ___ \| |\  |',13,10
        db ' |_| \_\\___/|____/____/___/_/   \_\_| \_|',13,10
        db '        R O U L E T T E',13,10,0

TutC1   db 'Copyright-2025:',0
TutC2   db 'Mostafa Rashwan',0
TutC3   db 'Mostafa Safi',0

Tut1    db 'Tutorial:',0
Tut2    db '1) Press any key to roll the dice (2-4 shots).',0
Tut3    db '2) Choose FIRST target:',0
Tut4    db '   [1] SELF  (PC auto-shoots after a delay)',0
Tut5    db '   [2] PC    (you shoot by pressing any key)',0
Tut6    db '3) After the first choice, targets ALTERNATE each shot.',0
Tut7    db '4) SAFE = click.  KILL = BOOM + dead head immediately.',0
Tut8    db 'Press any key to start...',0

; ========= END SCREENS (BIG ASCII) =========
WinLogo db 13,10
        db ' __   __  ___  _   _  __        __ ___ _   _ ',13,10
        db ' \ \ / / / _ \| | | | \ \      / /|_ _| \ | |',13,10
        db '  \ V / | | | | | | |  \ \ /\ / /  | ||  \| |',13,10
        db '   | |  | |_| | |_| |   \ V  V /   | || |\  |',13,10
        db '   |_|   \___/ \___/     \_/\_/   |___|_| \_|',13,10
        db 13,10,0

LoseLogo db 13,10
         db '   ____    _    __  __ _____    ___  __     _  _____  ____   ',13,10
         db '  / ___|  / \  |  \/  | ____|  / _ \ \ \   / /| ____||  _ \  ',13,10
         db ' | |  _  / _ \ | |\/| |  _|   | | | | \ \ / / |  _|  | |_) | ',13,10
         db ' | |_| |/ ___ \| |  | | |___  | |_| |  \ | /  | |___ |  _ <  ',13,10
         db '  \____/_/   \_\_|  |_|_____|  \___/    \_/   |_____||_| \_\ ',13,10
         db 13,10,0

tmpLine      db 260 dup(0)

.code

; =========================
; BIOS UTILS
; =========================
ClearScreen proc
    mov ax, 0003h
    int 10h
    ret
ClearScreen endp

GotoXY proc
    mov ah, 02h
    mov bh, 0
    int 10h
    ret
GotoXY endp

PrintZ proc
PZ_L1:
    lodsb
    cmp al, 0
    je PZ_Done
    mov ah, 0Eh
    mov bh, 0
    int 10h
    jmp PZ_L1
PZ_Done:
    ret
PrintZ endp

PrintZAt proc
    call GotoXY
    call PrintZ
    ret
PrintZAt endp

DelaySmall proc
    push cx
    push dx
    mov cx, 650
DS1:
    mov dx, 200
DS2:
    dec dx
    jnz DS2
    loop DS1
    pop dx
    pop cx
    ret
DelaySmall endp

; BIG delay for PC auto-shoot
DelayBig proc
    push cx
    mov cx, 18
DB_L:
    call DelaySmall
    loop DB_L
    pop cx
    ret
DelayBig endp

; Medium delay (used for spinning chamber)
DelayMed proc
    push cx
    mov cx, 8
DM_L:
    call DelaySmall
    loop DM_L
    pop cx
    ret
DelayMed endp

ClearLineAt proc
    push ax
    call GotoXY
    mov al, ' '
CL1:
    mov ah, 0Eh
    mov bh, 0
    int 10h
    loop CL1
    pop ax
    ret
ClearLineAt endp

; =========================
; RNG
; =========================
MixSeed proc
    push ax
    push bx
    push cx
    push dx

    mov ah, 00h
    int 1Ah
    mov ax, dx
    xor ax, cx

    in  al, 40h
    mov ah, al
    in  al, 40h
    xor ah, al

    mov bx, seed
    xor bx, ax
    rol bx, 1
    add bx, 0B400h
    mov seed, bx

    pop dx
    pop cx
    pop bx
    pop ax
    ret
MixSeed endp

WaitKey proc
    mov ah, 00h
    int 16h
    push ax
    call MixSeed
    pop ax
    push bx
    mov bx, seed
    xor bx, ax
    rol bx, 1
    mov seed, bx
    pop bx
    ret
WaitKey endp

InitRand proc
    call MixSeed
    call MixSeed
    call MixSeed
    ret
InitRand endp

Rand16 proc
    push bx
    push dx
    mov ax, seed
    mov bx, 25173
    mul bx
    add ax, 13849
    mov seed, ax
    pop dx
    pop bx
    ret
Rand16 endp

Rand1toN proc               ; BL=N, out AL=1..N
    push bx
    push dx
    xor bh, bh
    call Rand16
    xor dx, dx
    div bx
    mov al, dl
    inc al
    pop dx
    pop bx
    ret
Rand1toN endp

; =========================
; WIDTH CALC (for clipping)
; =========================
CalcFrameWidth proc         ; SI=frame, AL=max line len
    push bx
    xor bl, bl
    xor bh, bh
CFW1:
    mov al, [si]
    cmp al, 0
    je CFW_END
    cmp al, 13
    je CFW_NL
    cmp al, 10
    je CFW_NL
    inc bh
    inc si
    jmp CFW1
CFW_NL:
    mov al, bh
    cmp al, bl
    jbe CFW_RST
    mov bl, al
CFW_RST:
    xor bh, bh
    cmp byte ptr [si], 13
    jne CFW_SLF
    inc si
CFW_SLF:
    cmp byte ptr [si], 10
    jne CFW1
    inc si
    jmp CFW1
CFW_END:
    mov al, bh
    cmp al, bl
    jbe CFW_OUT
    mov bl, al
CFW_OUT:
    mov al, bl
    pop bx
    ret
CalcFrameWidth endp

CalcArtMaxWidth proc
    push si
    mov artMaxW, 0

    mov si, word ptr framePtrs[0]
    call CalcFrameWidth
    mov artMaxW, al

    mov si, word ptr framePtrs[2]
    call CalcFrameWidth
    cmp al, artMaxW
    jbe CAMW2
    mov artMaxW, al
CAMW2:
    mov si, word ptr framePtrs[4]
    call CalcFrameWidth
    cmp al, artMaxW
    jbe CAMW_DONE
    mov artMaxW, al
CAMW_DONE:
    pop si
    ret
CalcArtMaxWidth endp

; =========================
; MIRROR
; =========================
MirrorChar proc
    cmp al, '/'
    jne M2
    mov al, '\'
    ret
M2:
    cmp al, '\'
    jne M3
    mov al, '/'
M3:
    ret
MirrorChar endp

; =========================
; RenderFrame (clipped)
; =========================
RenderFrame proc            ; SI=frame, DH=row, DL=col, BH=mirror
    push ax
    push bx
    push cx
    push dx
    push di
    push si

    mov rfCol, dl
    mov mirrorFlag, bh

RF_LINE:
    mov al, [si]
    cmp al, 0
    jne RF_CONT
    jmp RF_DONE
RF_CONT:
    mov di, offset tmpLine
    xor cx, cx

RF_COLLECT:
    mov al, [si]
    cmp al, 0
    je RF_ENDCOL
    cmp al, 13
    je RF_ENDCOL
    cmp al, 10
    je RF_ENDCOL
    mov [di], al
    inc di
    inc si
    inc cx
    jmp RF_COLLECT

RF_ENDCOL:
    mov byte ptr [di], 0

    cmp byte ptr [si], 13
    jne RF_SKLF
    inc si
RF_SKLF:
    cmp byte ptr [si], 10
    jne RF_PRE
    inc si

RF_PRE:
    mov al, 80
    sub al, rfCol
    mov bl, al

    mov al, artMaxW
    cmp al, bl
    jbe RF_WOK
    mov al, bl
RF_WOK:
    xor ah, ah
    mov bx, ax

    mov dl, rfCol
    push cx
    mov cx, bx
    call ClearLineAt
    pop cx

    mov dl, rfCol
    call GotoXY

    mov al, mirrorFlag
    cmp al, 0
    jne RF_M
    jmp RF_N

RF_M:
    mov di, offset tmpLine
    add di, cx
RF_PAD:
    cmp cx, bx
    jae RF_PADOK
    mov byte ptr [di], ' '
    inc di
    inc cx
    jmp RF_PAD
RF_PADOK:
    mov byte ptr [di], 0

    lea di, tmpLine
    add di, bx
    dec di
    mov cx, bx
RF_MLOOP:
    mov al, [di]
    call MirrorChar
    mov ah, 0Eh
    mov bh, 0
    int 10h
    dec di
    loop RF_MLOOP
    jmp RF_NEXT

RF_N:
    mov di, offset tmpLine
    mov cx, bx
RF_NLOOP:
    cmp cx, 0
    je RF_NEXT
    mov al, [di]
    cmp al, 0
    je RF_NEXT
    mov ah, 0Eh
    mov bh, 0
    int 10h
    inc di
    dec cx
    jmp RF_NLOOP

RF_NEXT:
    inc dh
    jmp RF_LINE

RF_DONE:
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    ret
RenderFrame endp

; =========================
; LOG
; =========================
ClearLog proc
    push cx
    push dx
    mov dh, LOG_ROW
    mov dl, LOG_COL
    mov cx, 78
    call ClearLineAt
    mov dh, LOG_ROW+1
    mov dl, LOG_COL
    mov cx, 78
    call ClearLineAt
    pop dx
    pop cx
    ret
ClearLog endp

LogMsg proc
    call ClearLog
    mov dh, LOG_ROW
    mov dl, LOG_COL
    call PrintZAt
    ret
LogMsg endp

BoomHold proc
    push si
    mov si, offset sBoomHold
    call LogMsg
    pop si
    call WaitKey
    ret
BoomHold endp

; =========================
; TUTORIAL (shown once)
; =========================
ShowTutorial proc
    call ClearScreen

    mov dh, 1
    mov dl, 0
    mov si, offset TutLogo
    call PrintZAt

    mov dh, 8
    mov dl, 2
    mov si, offset TutC1
    call PrintZAt

    mov dh, 9
    mov dl, 2
    mov si, offset TutC2
    call PrintZAt

    mov dh, 10
    mov dl, 2
    mov si, offset TutC3
    call PrintZAt

    mov dh, 12
    mov dl, 2
    mov si, offset Tut1
    call PrintZAt

    mov dh, 13
    mov dl, 2
    mov si, offset Tut2
    call PrintZAt

    mov dh, 14
    mov dl, 2
    mov si, offset Tut3
    call PrintZAt

    mov dh, 15
    mov dl, 2
    mov si, offset Tut4
    call PrintZAt

    mov dh, 16
    mov dl, 2
    mov si, offset Tut5
    call PrintZAt

    mov dh, 17
    mov dl, 2
    mov si, offset Tut6
    call PrintZAt

    mov dh, 18
    mov dl, 2
    mov si, offset Tut7
    call PrintZAt

    mov dh, 20
    mov dl, 2
    mov si, offset Tut8
    call PrintZAt

    call WaitKey
    ret
ShowTutorial endp

; =========================
; DRAW HELPERS
; =========================
; ShowGun: AL=0/1/2, BL=side 0 user, 1 pc
ShowGun proc
    push si
    cmp al, 0
    je SG0
    cmp al, 1
    je SG1
    mov si, word ptr framePtrs[4]
    jmp SG_PTR
SG0:
    mov si, word ptr framePtrs[0]
    jmp SG_PTR
SG1:
    mov si, word ptr framePtrs[2]
SG_PTR:
    cmp bl, 0
    jne SG_PC
    mov dh, USER_ROW
    mov dl, userCol
    mov bh, 0
    call RenderFrame
    jmp SG_DONE
SG_PC:
    mov dh, PC_ROW
    mov dl, pcCol
    mov bh, 1
    call RenderFrame
SG_DONE:
    pop si
    ret
ShowGun endp

; ShowHead: AL=0 alive, AL=1 dead, BL=side
ShowHead proc
    push si
    cmp al, 0
    jne SHD
    mov si, offset HeadA
    jmp SH_PTR
SHD:
    mov si, offset HeadD
SH_PTR:
    cmp bl, 0
    jne SH_PC
    mov dh, USER_ROW
    mov dl, userCol
    mov bh, 0
    call RenderFrame
    jmp SH_DONE
SH_PC:
    mov dh, PC_ROW
    mov dl, pcCol
    mov bh, 0
    call RenderFrame
SH_DONE:
    pop si
    ret
ShowHead endp

; victim = targetSel, holder = victim^1
SetupShotView proc
    push ax
    push bx

    mov bl, targetSel
    xor bl, 1
    mov al, 0
    call ShowGun

    mov bl, targetSel
    mov al, 0
    call ShowHead

    pop bx
    pop ax
    ret
SetupShotView endp

ResetDefaultView proc
    mov targetSel, 1
    call SetupShotView
    ret
ResetDefaultView endp

; Show "Spinning chamber..." 
ShowSpin proc
    push cx
    push dx
    push si

    mov dh, SPIN_ROW
    mov dl, SPIN_COL
    mov cx, 78
    call ClearLineAt

    mov dh, SPIN_ROW
    mov dl, SPIN_COL
    mov si, offset sSpin
    call PrintZAt

    call DelayMed

    mov dh, SPIN_ROW
    mov dl, SPIN_COL
    mov cx, 78
    call ClearLineAt

    pop si
    pop dx
    pop cx
    ret
ShowSpin endp

; =========================
; UI (static)
; =========================
DrawStaticUI proc
    call ClearScreen
    mov dh, HDR_ROW
    mov dl, HDR_COL
    mov si, offset sTitle
    call PrintZAt

    mov dh, 5
    mov dl, userCol
    mov si, offset sUser
    call PrintZAt

    mov dh, 5
    mov dl, pcCol
    mov si, offset sPC
    call PrintZAt

    mov dh, SCORE_ROW
    mov dl, SCORE_COL
    mov si, offset sScoreTxt1
    call PrintZAt

    mov dh, SCORE_ROW
    mov dl, SCORE_COL+14
    mov si, offset sScoreTxt2
    call PrintZAt

    mov dh, DICE_ROW
    mov dl, DICE_COL
    mov si, offset sDice
    call PrintZAt

    mov dh, HDR_ROW
    mov dl, 45
    mov si, offset sRoundTxt
    call PrintZAt
    ret
DrawStaticUI endp

PrintDigitAt proc
    push ax
    push si
    mov si, offset tmpLine
    add al, '0'
    mov [si], al
    mov byte ptr [si+1], 0
    mov si, offset tmpLine
    call PrintZAt
    pop si
    pop ax
    ret
PrintDigitAt endp

UpdateHeader proc
    mov dh, SCORE_ROW
    mov dl, SCORE_COL+12
    mov al, playerScore
    call PrintDigitAt

    mov dh, SCORE_ROW
    mov dl, SCORE_COL+20
    mov al, pcScore
    call PrintDigitAt

    mov dh, HDR_ROW
    mov dl, 52
    mov al, roundCount
    call PrintDigitAt
    ret
UpdateHeader endp

; =========================
; CHAMBER
; =========================
SetupRoundChamber proc
    call MixSeed
    mov bl, 6
    call Rand1toN
    mov bulletPos, al
    mov bl, 6
    call Rand1toN
    mov chPos, al
    ret
SetupRoundChamber endp

AdvanceChamber proc
    mov al, chPos
    inc al
    cmp al, 7
    jb AC_OK
    mov al, 1
AC_OK:
    mov chPos, al
    ret
AdvanceChamber endp

AnimateDice proc            ; AL final 2..4
    push ax
    push bx
    push cx
    push dx
    call MixSeed
    mov diceFinal, al
    mov cx, 7
AD_L:
    mov bl, 3
    call Rand1toN
    inc al                 ; 2..4
    mov dh, DICE_ROW
    mov dl, DICE_COL+7
    call PrintDigitAt
    call DelaySmall
    loop AD_L
    mov al, diceFinal
    mov dh, DICE_ROW
    mov dl, DICE_COL+7
    call PrintDigitAt
    pop dx
    pop cx
    pop bx
    pop ax
    ret
AnimateDice endp

; =========================
; GAMEPLAY
; =========================
UserPlaysOneDice proc        
    call ResetDefaultView

    mov si, offset sPressRoll
    call LogMsg
    call WaitKey

    mov bl, 3
    call Rand1toN
    inc al                 ; 2..4
    call AnimateDice
    mov cl, al

    ; Show spinning chamber 
    call ShowSpin

PickLoop:
    mov si, offset sPickFirst
    call LogMsg
    call WaitKey
    cmp al, '1'
    je PickSelf
    cmp al, '2'
    je PickPC
    jmp PickLoop
PickSelf:
    mov targetSel, 0
    jmp StartShots
PickPC:
    mov targetSel, 1

StartShots:
    call SetupShotView

ShotLoop:
    cmp targetSel, 0
    jne UserShootsPC

    mov si, offset sPCAutoShoot
    call LogMsg
    call DelayBig
    jmp DoFire

UserShootsPC:
    mov si, offset sShotPC
    call LogMsg
    call WaitKey

DoFire:
    mov bl, targetSel
    xor bl, 1              ; holder = victim^1

    mov al, 1              ; SAFE/SHOT frame on holder before check
    call ShowGun
    call MixSeed

    mov al, chPos
    cmp al, bulletPos
    jne SafeShot

    ; KILL: BOOM art on killer + dead head on victim immediately
    mov al, 2
    call ShowGun

    mov bl, targetSel
    mov al, 1
    call ShowHead

    cmp targetSel, 1
    je PcDied

UserDied:
    mov si, offset sBoomP
    call LogMsg
    call BoomHold
    mov al, 1              ; winner = PC
    stc
    ret

PcDied:
    mov si, offset sBoomU
    call LogMsg
    call BoomHold
    mov al, 0              ; winner = USER
    stc
    ret

SafeShot:
    mov si, offset sSafe
    call LogMsg
    call AdvanceChamber
    call DelaySmall

    mov al, targetSel
    xor al, 1
    mov targetSel, al
    call SetupShotView

    ; ---- TASM-safe loop ----
    dec cl
    jnz SL_CONT
    jmp ShotDone
SL_CONT:
    jmp ShotLoop

ShotDone:
    call ResetDefaultView
    clc
    ret
UserPlaysOneDice endp

PlayRound proc              ; AL=0 user wins, AL=1 pc wins
PR_L:
    call UserPlaysOneDice
    jc PR_END
    jmp PR_L
PR_END:
    ret
PlayRound endp

; =========================
; GAME OVER / AGAIN
; =========================
CheckGameOver proc
    mov al, playerScore
    cmp al, 2
    je CGO_E
    mov al, pcScore
    cmp al, 2
    je CGO_E
    clc
    ret
CGO_E:
    stc
    ret
CheckGameOver endp

; End screen: big ASCII YOU WIN / GAME OVER
ShowEndScreen proc
    push si

    call ClearScreen

    ; If USER reached 2 => YOU WIN, else GAME OVER
    mov al, playerScore
    cmp al, 2
    jne SES_LOSE

    mov dh, 4
    mov dl, 0
    mov si, offset WinLogo
    call PrintZAt
    jmp SES_DONE

SES_LOSE:
    mov dh, 4
    mov dl, 0
    mov si, offset LoseLogo
    call PrintZAt

SES_DONE:
    pop si
    ret
ShowEndScreen endp

; Ask again under end screen (NOT using log)
AskPlayAgainEnd proc
APL_E:
    push cx
    push dx
    push si

    mov dh, 20
    mov dl, 2
    mov cx, 78
    call ClearLineAt

    mov dh, 20
    mov dl, 2
    mov si, offset sPlayAgain
    call PrintZAt

    call WaitKey

    pop si
    pop dx
    pop cx

    cmp al, 'Y'
    je APL_OK
    cmp al, 'y'
    je APL_OK
    cmp al, 'N'
    je APL_OK
    cmp al, 'n'
    jne APL_E
APL_OK:
    ret
AskPlayAgainEnd endp

LoadArt proc
    mov word ptr framePtrs[0], offset Art0
    mov word ptr framePtrs[2], offset Art1
    mov word ptr framePtrs[4], offset Art2
    call CalcArtMaxWidth

    mov al, 78
    sub al, artMaxW
    cmp al, 20
    jae LA_OK
    mov al, 20
LA_OK:
    mov pcCol, al
    ret
LoadArt endp

; =========================
; MAIN
; =========================
main proc
    mov ax, @data
    mov ds, ax

    call InitRand
    call LoadArt

    ; Tutorial once at startup
    call ShowTutorial

GameStart:
    call InitRand
    mov roundCount, 1
    mov playerScore, 0
    mov pcScore, 0

NextRound:
    call SetupRoundChamber
    call DrawStaticUI
    call UpdateHeader
    call ClearLog
    call ResetDefaultView

    call PlayRound

AfterRound:
    cmp al, 0
    jne PCWon
    inc playerScore
    jmp CheckEnd
PCWon:
    inc pcScore

CheckEnd:
    call DrawStaticUI
    call UpdateHeader
    call ClearLog
    call ResetDefaultView

    call CheckGameOver
    jnc ContinueGame

    ; End screen: big YOU WIN / GAME OVER + play again under it
    call ShowEndScreen
    call AskPlayAgainEnd

    cmp al, 'Y'
    je GameStart
    cmp al, 'y'
    je GameStart

    mov ah, 4Ch
    int 21h

ContinueGame:
    inc roundCount
    jmp NextRound
main endp

end main
