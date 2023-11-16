// SALIDA DEL PROGRAMA DEL PIN 3 AL 10
const byte pulsador = 2;
unsigned int contador = 0;
unsigned int statusLed = 0;
unsigned int direction1=0;
unsigned int direction2=0;
unsigned int shiftInt=1;
unsigned int option=0;
void setup() {
  Serial.begin(9600);
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  // put your setup code here, to run once:
  DDRD = 255;
  PORTD = 1<<3;
  pinMode(pulsador, INPUT);
  attachInterrupt(digitalPinToInterrupt(pulsador),modeActive,RISING);
 }

void modeActive(){
  if(option<4){
    option++;
    Serial.println(option);
    
  }else{
    option=0;
  }
  contador = 0;
  statusLed = 0;
  direction1=0;
  direction2=0;
  shiftInt=1;
}

void count(){
  
    contador++;
    PORTD=contador<<3;
    PORTB=contador>>5;
  
  }

void blink(){
  statusLed=!statusLed;
  PORTD=statusLed<<3;
}

void shift(){
   if(direction1<7){
       direction1++;
       shiftInt=shiftInt<< 1;
       PORTD = (shiftInt << 3);
       PORTB=shiftInt>>5;
       }
       else{
         shiftInt=shiftInt>> 1;
          PORTD = (shiftInt << 3);
          PORTB=shiftInt>>5;
         direction2++;
          if(direction2==7){
            direction1=0;
            direction2=0;
          }
       }
}

void bateria(){
  if(direction1<7){
       direction1++;
       shiftInt=shiftInt<< 1;
       shiftInt=shiftInt+1;
       PORTD = (shiftInt << 3);
       PORTB=shiftInt>>5;
       }
    else{
          shiftInt=shiftInt--;
          shiftInt=shiftInt>> 1;
          PORTD = (shiftInt << 3);
          PORTB=shiftInt>>5;
         direction2++;
          if(direction2==7){
            direction1=0;
            direction2=0;
          }
       }
}

void par_impar(){
  if(direction1<3){
       direction1++;
       shiftInt=shiftInt<< 2;
       PORTD = (shiftInt << 3);
       PORTB=shiftInt>>5;
       }
       else{
         if(direction2==0){
          
          shiftInt=2;
          PORTD = (shiftInt << 3);
          PORTB=shiftInt>>5;
          delay(150);
         }
         
         shiftInt=shiftInt<< 2;
          PORTD = (shiftInt << 3);
          PORTB=shiftInt>>5;
         direction2++;
          if(direction2==3){
            shiftInt=1;
            direction1=0;
            direction2=0;
          }
       }
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(500);
  
    switch (option) {
    case 0:
      blink();
  
      break;
    case 1:
      count();
      break;
    case 2:
      shift();
      break;
     case 3:
      bateria();
      break;
     case 4:
      par_impar();
      break;
     
   
  }
    
  

}
