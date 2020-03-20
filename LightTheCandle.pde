//TODO: Hacer paleta de colores para la interfaz
//Unificar la biblioteca de interfaz que se usara, en este caso se ha usado 4gp porque habia funcionado bien en proyectos previos pero tiene un problema con el sistema de render P2D y no funcionan los slidrs y eventos de click al usar este sistema de render
//En cambio la biblioteca controlP5 si funciona bien en los eventos pero hay cosas que no tiene implementadas como el cambio del cursor en cajas de texto
//Hacer que el load/save sea por interfaz grafica

//Serial
import processing.serial.*;

//Syphon
import codeanticode.syphon.*;
import java.util.Iterator;
import java.util.Map;

//Serial
Serial myPort;  // Create object from Serial class
int port;        // Data received from the serial port

//Interfaz
import java.awt.Rectangle;


import g4p_controls.*;    //TODO: g4p_controls tiene incompatibilidades
                          //con el render P2D que necesita Syphon. Cambiar por ControlP5
int N_LIGHTS=16;

GTextField txBoxH[]=new GTextField[N_LIGHTS];
GTextField txBoxL[]=new GTextField[N_LIGHTS];
GLabel lblBox[]=new GLabel[N_LIGHTS];

/////////////////////////////////////////
import controlP5.*;

ControlP5 cp5;
DropdownList guiClients;
Slider sdrT;

int MARGIN=20;

ArrayList<Rectangle> sections = new ArrayList<Rectangle> ();

int wDisplay = 640;
int hDisplay = 480;

//Syphon
PGraphics[] canvas;
SyphonClient[] clients;

int nClients;
int targetIndex;
String [] syphonNames;

//Luces
light[] lights;
int lightSize=20;

float threshold;

void settings() {
  size(840, 600, P2D);
  PJOGL.profile=1;
}


void setup() {

  HashMap<String, String>[] allServers = SyphonClient.listServers();

  int nServers = allServers.length;

  canvas = new PGraphics[nServers];
  clients = new SyphonClient[nServers];

  syphonNames=new String[allServers.length];

  targetIndex = 0;

  for (int i = 0; i < allServers.length; i++) {

    String appName = allServers[i].get("AppName");
    String serverName = allServers[i].get("ServerName");

    syphonNames[i]=appName+": "+serverName;

    clients[i] = new SyphonClient(this, appName, serverName);
  }

  nClients = nServers;

  //Interfaz
  cp5 = new ControlP5(this);

  createOutGui("Send Data",wDisplay, 0, width-wDisplay, height);
  createControlGui("Control",0,hDisplay,wDisplay,height-hDisplay);
  //Luces
  lights=new light[N_LIGHTS];
  for (int i = 0; i < lights.length; i++) {
    lights[i] = new light(20+i*lightSize, 20, lightSize, lights,i);
  }

  //Serial TODO: hacer que se pueda escoger el puerto y la velocidad desde la interfaz y poder inicializarlos desde alli
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 57600);

  load("test");
}

void draw() {

  background(0);

  if(nClients>targetIndex){
    SyphonClient targetClient = clients[targetIndex];

    if (targetClient.newFrame()) {
      canvas[targetIndex] = targetClient.getGraphics(canvas[targetIndex]);
      image(canvas[targetIndex], 0, 0, wDisplay, hDisplay);
    }

    //Interfaz
    drawGUI();

    //Luces
    for (int i = 0; i < lights.length; i++) {
      lights[i].update(canvas[targetIndex]);
      lights[i].draw();
    }
  }else if(nClients==0){
    text("No hay clientes Syphone activos",10,100);
    text("Cierra el programa y vuelve a abrirlo al tener un cliente syphon activo",10,130);
  }


  //println (frameRate);
}

//Eventos
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  }
  else if (theEvent.isController()) {
    if(theEvent.getName()=="SyphonClient"){
      targetIndex=int(theEvent.getController().getValue());
    }else if(theEvent.getName()=="Threshold")
    {
      threshold=theEvent.getValue();
    }
  }
}

void keyPressed() {
  switch(key) {
    case('s'):
      save("test");
      break;
    case('l'):
      load("test");
      break;

  }
}

void mouseReleased()  {
  for (int i = 0; i < lights.length; i++) {
    lights[i].releaseEvent();
  }
}

// Interfaz
void createGuiSyphon(int x, int y, int w,String[] clientsNames){

  if(nClients>targetIndex){
    guiClients = cp5.addDropdownList("SyphonClient").setPosition(x, y).setWidth(w);
    for (int i=0; i<clientsNames.length; i++) {
      guiClients.addItem(clientsNames[i],i);
    }
  }
}

public void createOutGui(String tittle,int x, int y, int w, int h){
  createSection(tittle, x, y, w, h);
  int size=20;
  int border=30;
  for(int i=0; i<N_LIGHTS;i++)
  {
    int yBox=int(y+border+i*(h-border)/float(N_LIGHTS));
    lblBox[i] = new GLabel(this, x+10, yBox, size, size);
    lblBox[i].setText(str(i));
    lblBox[i].setLocalColorScheme(1);
    txBoxH[i] = new GTextField(this, x+10+border, yBox, size, size);
    txBoxL[i] = new GTextField(this, x+10+2*border, yBox, size, size);
  }
}

public void createControlGui(String tittle,int x, int y, int w, int h){
  int sizeW=200;
  createSection(tittle, x, y, w, h);

  createGuiSyphon(x+MARGIN,y+2*MARGIN, sizeW, syphonNames);
  sdrT=cp5.addSlider("Threshold")
     .setSize(200,20)
     .setPosition(x+2*MARGIN+sizeW,y+2*MARGIN)
     .setRange(0,255)
     ;
  threshold=sdrT.getValue();
}

public void createSection(String tittle,int x, int y, int w, int h){
  // Store picture frame
  sections.add(new Rectangle(x, y, w-1, h-1));
  // Set inner frame position
  x += 1;
  y += 1;
  w -= 2;
  h -= 2;
  GLabel title = new GLabel(this, x, y, w, 20);
  title.setText(tittle, GAlign.LEFT, GAlign.MIDDLE);
  title.setOpaque(true);
  title.setTextBold();
}

public void drawGUI(){
  showSections();
}

public void showSections() {
  for (Rectangle r : sections){
    noFill();
    stroke(color(255));
    rect(r.x, r.y, r.width, r.height);
  }
}

//**************************************
//Load/Save
void load(String name){
  Table table = loadTable(name+".csv", "header");

  // You can access iterate over all the rows in a table
  int rowCount = 0;
  int id;
  for (TableRow row : table.rows()) {
    id=row.getInt("idLight");
    lights[id].x = row.getInt("posX");
    lights[id].y = row.getInt("posY");
    txBoxH[id].setText(row.getString("outH"));
    txBoxL[id].setText(row.getString("outL"));

    if(rowCount==0){
      threshold=row.getFloat("threshold");
      sdrT.setValue(threshold);
    }
    rowCount++;
  }
}

void save(String name){
  //Crear nueva fila
  Table tableNew = new Table();
  tableNew.addColumn("idLight");
  tableNew.addColumn("posX");
  tableNew.addColumn("posY");
  tableNew.addColumn("outH");
  tableNew.addColumn("outL");
  tableNew.addColumn("threshold");

  TableRow row;
  for(light iLight: lights){
    row = tableNew.addRow();
    row.setInt("idLight", iLight.id);
    row.setInt("posX", iLight.x);
    row.setInt("posY", iLight.y);
    row.setString("outH", txBoxH[iLight.id].getText());
    row.setString("outL", txBoxL[iLight.id].getText());

    if(iLight.id==0){
      row.setFloat("threshold", threshold);
    }
  }
  saveTable(tableNew, "data/"+name+".csv");
}

//**************************************
class light{
  int x,y,size;
  boolean press, over,locked;
  light[] others;
  boolean otherslocked;
  int id;
  boolean stateChange, oldState, sendMsgH, sendMsgL;

  light(int x, int y, int size, light[] others, int id){
    this.x=x;
    this.y=y;
    this.size=size;
    press=false;
    over=false;
    locked=false;
    this.others=others;
    otherslocked = false;
    this.id=id;
    stateChange=true;
    sendMsgH=false;
    sendMsgL=false;
  }

  void update(PGraphics canvas){

    for (int i=0; i<others.length; i++) {
      if (others[i].locked == true) {
        otherslocked = true;
        break;
      } else {
        otherslocked = false;
      }
    }

    if (otherslocked == false) {

      overEvent();
      pressEvent();
    }

    if(press){
      if(mouseX>0 && mouseX < wDisplay
          && mouseY>0 && mouseY < hDisplay){
            x=mouseX;
            y=mouseY;
      }
    }

    //Analizar imagen
    if(canvas!=null){
      int pixelX = int(x*canvas.width/float(wDisplay));
      int pixelY = int(y*canvas.height/float(hDisplay));

      color cPixel=canvas.get(pixelX,pixelY);
      if(brightness(cPixel)<threshold){
        if(!oldState)stateChange=true;
        oldState=true;
      }else{
        if(oldState)stateChange=true;
        oldState=false;
      }
      if(stateChange){
        stateChange=false;
        String msg="";
        if(oldState){
          msg=txBoxH[id].getText();
          sendMsgH=true;
        }
        else {
          msg=txBoxL[id].getText();
          sendMsgL=true;
        }

        myPort.write(msg);

        //println(msg);
      }
    }
  }

  void draw(){

    if(sendMsgH||sendMsgL){
      if(sendMsgH)fill(255,0,0,128);
      if(sendMsgL)fill(0,0,255,128);
      sendMsgH=false;
      sendMsgL=false;
    }else{
      if(over)fill(0,255,0,128);
      else fill(255,255,255,128);
    }
    stroke(0,255,0);
    int offset=size/2;
    rect(x-offset, y-offset, size, size);
    textAlign(CENTER, CENTER);
    text(id,x,y);
  }

  boolean overRect() {
    int offset=size/2;
    if (mouseX >= x-offset && mouseX <= x+offset &&
        mouseY >= y-offset && mouseY <= y+offset) {
      return true;
    } else {
      return false;
    }
  }

  void overEvent() {
    if (overRect()) {
      over = true;
    } else {

      over = false;
    }
  }
  void pressEvent() {
    if (over && mousePressed || locked) {
      press = true;
      locked = true;
    } else {
      press = false;
    }
  }
  void releaseEvent() {
    locked = false;
  }
}
