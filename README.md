# LightTheCandle
Sistema digital de interruptores controlados por los pixeles de una fuente de video.

Sistema digital de interruptores controlados por los pixeles de una fuente de video.

Si tienes una fuente de video que envías a través de Spout, podrás conectar hasta 18 interruptores que reaccionan al brillo de los 18 pixeles que selecciones en el video. Dichos interruptores podrán encender y apagar todo tipo de dispositivos, ventiladores, lámparas, luces LED, televisores análogos, solo para dar una idea. Puedes experimentar como gustes, aunque este software se ofrece sin garantías.

Este prototipo cuenta con un programa de interfaz creado en processing, que captura la fuente de video en Spout y envía los comandos de encendido o apagado a un arduino que se encarga de gestionar el módulo de potencia. 

El módulo de potencia puede ser construido:
A partir del uso de transistores Tip 120 o equivalentes, para el uso cargas de baja potencia y de corriente directa, como cintas LEDs o pequeños motores. 
A partir del uso de Relevos que soportan cargas más altas, como para conectar electrodomésticos o afines (dependiendo las características de potencia de los relevos). os relevos traen consigo, la desventaja de no poder funcionar a altas frecuencias, pero aun asi es lo suficientemente rápido como para aplicaciones convencionales.

Los distintos planos de hardware estarán disponibles pronto para su descarga.



Esta es la primera versión, aún en desarrollo y tiene  varios pendientes, pero funciona de forma estable.

La documentación básica de uso estará pública en breve.

<img style="-webkit-user-select: none;margin: auto;cursor: zoom-in;" src="https://raw.githubusercontent.com/Carlos-Adrian-Serna/LightTheCandle/master/Captura%20de%20pantalla.png" width="793" height="587">


Los cuadros de marco verde sobre la imagen, corresponden a la posición donde se captará el brillo de los píxeles de la imagen para determinar si debe o no activarse el interruptor.

Actualmente debe ejecutarse con el arduino conectado y la fuente de video syphon abierta.
El puerto del arduino debe configurarse en la línea 101 del programa.

      String portName = Serial.list()[3];
