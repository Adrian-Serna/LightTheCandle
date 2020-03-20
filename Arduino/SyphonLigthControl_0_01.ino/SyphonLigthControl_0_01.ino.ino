boolean L1=true;
boolean L2=true;
boolean L3=true;
boolean L4=true;
boolean L5=true;
boolean L6=true;
boolean L7=true;
boolean L8=true;
boolean L9=true;
boolean L10=true;
boolean L11=true;
boolean L12=true;
boolean L13=true;
boolean L14=true;
boolean L15=true;
boolean L16=true;

//Lectura de datos
int inByte = 0;
void setup() {
  Serial.begin(57600); 
  pinMode(2,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT); 
  pinMode(6,OUTPUT);
  pinMode(7,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
  pinMode(A0,OUTPUT);
  pinMode(A1,OUTPUT);
  pinMode(A2,OUTPUT);
  pinMode(A3,OUTPUT);
}

void loop() {
  //***************************************************************
  //Leer Datos recibidos
  inByte = Serial.read();
  if(inByte=='q')
  {
    digitalWrite(2,true);
    Serial.println("q");
  }else if(inByte=='w')
  {
    digitalWrite(3,true);
    Serial.println("w");
  }else if(inByte=='e')
  {
    digitalWrite(4,true);
    Serial.println("e");
  }else if(inByte=='r')
  {
    digitalWrite(5,true);
    Serial.println("r");
  }else if(inByte=='t')
  {
    digitalWrite(6,true);
    Serial.println("t");
  }else if(inByte=='y')
  {
    digitalWrite(7,true);
    Serial.println("y");
  }else if(inByte=='u')
  {
    digitalWrite(8,true);
    Serial.println("u");
  }else if(inByte=='i')
  {
    digitalWrite(9,true);
    Serial.println("i");
  }else if(inByte=='o')
  {
    digitalWrite(10,true);
    Serial.println("o");
  }else if(inByte=='p')
  {
    digitalWrite(11,true);
    Serial.println("p");
  }else if(inByte=='a')
  {
    digitalWrite(12,true);
    Serial.println("a");
  }else if(inByte=='s')
  {
    digitalWrite(13,true);
    Serial.println("s");
  }else if(inByte=='d')
  {
    digitalWrite(A0,true);
    Serial.println("d");
  }else if(inByte=='f')
  {
    digitalWrite(A1,true);
    Serial.println("f");
  }else if(inByte=='g')
  {
    digitalWrite(A2,true);
    Serial.println("g");
  }else if(inByte=='h')
  {
    digitalWrite(A3,true);
    Serial.println("h");
  }else if(inByte=='Q')
  {
    digitalWrite(2,false);
    Serial.println("Q");
  }else if(inByte=='W')
  {
    digitalWrite(3,false);
    Serial.println("W");
  }else if(inByte=='E')
  {
    digitalWrite(4,false);
    Serial.println("E");
  }else if(inByte=='R')
  {
    digitalWrite(5,false);
    Serial.println("R");
  }else if(inByte=='T')
  {
    digitalWrite(6,false);
    Serial.println("T");
  }else if(inByte=='Y')
  {
    digitalWrite(7,false);
    Serial.println("Y");
  }else if(inByte=='U')
  {
    digitalWrite(8,false);
    Serial.println("U");
  }else if(inByte=='I')
  {
    digitalWrite(9,false);
    Serial.println("I");
  }else if(inByte=='O')
  {
    digitalWrite(10,false);
    Serial.println("O");
  }else if(inByte=='P')
  {
    digitalWrite(11,false);
    Serial.println("P");
  }else if(inByte=='A')
  {
    digitalWrite(12,false);
    Serial.println("A");
  }else if(inByte=='S')
  {
    digitalWrite(13,false);
    Serial.println("S");
  }else if(inByte=='D')
  {
    digitalWrite(A0,false);
    Serial.println("D");
  }else if(inByte=='F')
  {
    digitalWrite(A1,false);
    Serial.println("F");
  }else if(inByte=='G')
  {
    digitalWrite(A2,false);
    Serial.println("G");
  }else if(inByte=='H')
  {
    digitalWrite(A3,false);
    Serial.println("H");
  }
}
