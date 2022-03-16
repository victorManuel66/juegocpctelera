.module principal

.include "cpctelera.h.s"
.include "Player.h.s"
.include "laser.h.s"
.include "enemy.h.s"
.include "laserColision.h.s"
.include "enemy_colision.h.s"
.include "destruyePlayer.h.s"
.include "mensajes.h.s"
.include "menu.h.s"
.include "destroyEnemy.h.s"
.include "datos.h.s"

.area _DATA
.area _CODE

.globl _tileset
.globl _fondo
.globl _Newexplo
.globl _spr




paleta:
   .db 20,20,29,24,12,28,11,2,0,14,0,0,19,10,0,27

_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm
   ;; Cambiamos a modo de video 0
   ld  c, #0x00
   call cpct_setVideoMode_asm
   ;; Asignamos colores a la paleta
   ld hl, #paleta
   ld de, #0x10
   call cpct_setPalette_asm
   ;; Inicializar sonidos SFX
   ld de, #_Newexplo
   call cpct_akp_SFXInit_asm
   ld de, #_Newexplo
   call cpct_akp_musicInit_asm

   call menu

newGame:
   ;; Dibujar la pantalla
   ld hl, #_tileset
   call cpct_etm_setTileset2x4_asm
   ld hl, #_fondo
   push hl
   ld hl, #0xC000
   push hl
   ld bc, #0x0000
   ld de, #0x3228
   ld  a, #0x28
   call cpct_etm_drawTileBox2x4_asm

   ;; Marcador
   ld hl, #0x0002
   call cpct_setDrawCharM0_asm                                    ;; Colores del texto

   ld de, #0xC000
   ld bc, #0x143B
   call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   ld iy, #new
   call cpct_drawStringM0_asm
   ld de, #0xC000
   ld bc, #0x1B37
   call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   ld iy, #escore
   call cpct_drawStringM0_asm
   ld de, #0xC000
   ld bc, #0x4E37
   call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   ld iy, #escore
   call cpct_drawStringM0_asm
   ld de, #0xC000
   ld bc, #0x8A37
   call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   ld iy, #lives                                                  
   call cpct_drawStringM0_asm                                     ;; Escribe vidas
   ld de, #0xC000
   ld bc, #0x5C37
   call cpct_getScreenPtr_asm
   ld iy, #puntos
   call cpct_drawStringM0_asm                                    ;; Dibuja los puntos

   ;; dibujar las naves en el marcador
   ld bc, #0xA637                                                 ;; En B coordenada Y en C coordenada X
   ld  a, #0x03                                                   ;; El número de naves a dibujar
nextShip:
   push af                                                        ;; Preservo A por que las llamadas a cpctelera lo corrompen
   push bc                                                        ;; Lo mismo para BC
   ld de, #0xC000
   call cpct_getScreenPtr_asm                                     ;; Posición de pantalla donde escribir
   ex de, hl                                                      ;; Necesario por cpct_drawSprite
   ld hl, #_spr                                                   ;; Dirección donde esta el sprite
   ld bc, #0x0605                                                 ;; B alto y C ancho del sprite
   call cpct_drawSprite_asm                                       ;; dibuja el sprite
   pop bc
   ld  a, #0x07
   add a, c
   ld  c,a
   pop af
   dec  a
   jr nz, nextShip

   

   ld ix, #enemy
   call calXenemy                                        ;; Pide una coordenada X para enemy
   ld ix, #enemy2
   call calXenemy                                        ;; Pide una coordenada X para enemy2
   ld ix, #enemy3                       
   call calXenemy                                        ;; Pide una coordenada X para enemy3

   main_loop:
      ld ix, #Player                                     ;; IX contiene el inicio de los datos del Player    
      call erase_player                                  ;; Borra el sprite de la posición actual
      ld ix, #enemy                                      ;; IX ahora apunta al inicio de los datos enemigo
      call erase_enemy                                   ;; Borra al enemigo

      ld ix, #Player                                     ;; IX contiene el inicio de los datos del Player
      call update_player                                 ;; Calcula la nueva posición
      ld ix, #enemy                                      ;; IX ahora apunta al inicio de los datos enemigo
      call update_enemy                                  ;; Calcula la nueva posición del enemigo
      ld ix, #enemy                                      ;; IX contiene el inicio de los datos del enemy
      call colision_enemy                                ;; Ver si los enemigos colisionan
   

      ld ix, #Player                                     ;; IX contiene inicio de los datos del Player
      call draw_player                                   ;; Dibuja el sprite en la nueva posición
      ld ix, #enemy                                      ;; IX ahora apunta al inicio de los datos del enemigo
      call draw_enemy                                    ;; Dibuja al enemigo
  

      call disparando                                    ;; Comprobar si esta disparando
      ld  a, (hl)
      cp #0x01                                           ;; Si esta a uno es que tiene que disparar
      jr nz, nodisparar

      call erase_laser                                   ;; Borra el disparo
      call update_laser                                  ;; Actualiza el disparo
      call draw_laser                                    ;; Dibuja el disparo
      ld ix, #enemy
      call laser_colision                                ;; Ver si laser colision

nodisparar::
      call cpct_waitVSYNC_asm                            ;; Sincronización
      call cpct_akp_musicPlay_asm                        ;; Tocar música para usar los efectos de sonidoa

      ld ix, #Player  
      ld  a, 6(ix)                                       ;; El número de vidas restantes
      cp  #0x00                                          ;; Ver si estan a cero las vidas
      jr nz, main_loop                                   ;; Continua mientras haya vidas


      ld hl, #0x0004
      call cpct_setDrawCharM0_asm

      ld de, #0xC000                                     ;; Inicio de la memoria de video
      ld bc, #0x640A                                     ;; Coordenadas X y Y donde escribir
      call cpct_getScreenPtr_asm                         ;; Obtener dirección de momoria de video
      
      ld iy, #gameover
      call cpct_drawStringM0_asm                         ;; Excribe el mensaje

      call cpct_akp_stop_asm                             ;; Para el sonido

espera:
      call cpct_scanKeyboard_asm                         ;; Escanear al teclado
      call cpct_isAnyKeyPressed_asm                      ;; Ver si se pulso una tecla
      cp #0x00                                           ;; Si en A hay un cero es que no se pulso una tecla
      jr  z, espera                                      ;; vuelve a espera hasta que se pulse una tecla

      call menu

      ld ix, #Player                                     ;; Puntero al inicio de datos del jugador
      ld 6(ix), #0x03                                    ;; Número de vidas de nuevo a tres


      jp newGame                                         ;; Jugar de nuevo