# AO Animación por Ordenador
Prácticas de Animación por Ordenador (AO), Grado en Ingeniería Informática, UGR 2017-2018.

## Descripción de las prácticas
### Práctica 1: Animación por claves.

Con esta primera práctica se pretende tomar contacto con el proceso de animación por claves utilizando la herramienta Autodesk 3DS Max.

En clase se preparará unas escenas sencillas sobre las que se plantearán una serie de ejercicios de animación simples para comprender el concepto de animación por claves.

Control de peso: realizar una animación donde una pelota choca con una caja y rebota, y otra donde la pelota arrastra o hace caer a la caja.
Materiales: realizar dos animaciones para mostrar la caida desde cierta altura de una pelota de goma y de una bola de bolos
Péndulo: realizar una animación donde se muestre el efecto de un péndulo

### Práctica 2: Introducción a las curvas de movimiento.

Con estos ejercicios presentaremos el uso de curvas de función para controlar nuestras animaciones.

### Práctica 3: Interacción entre objetos, trayectorias y timing.

#### Ejercicio 1. Interacción entre objetos.

Animar el salto de un objeto colocado en un extremo de en un trampolín, cuando otro objeto salta al otro extremo. El objeto que salta al principio lo hace desde una plataforma y el que sale lanzado debe caer en la otra plataforma. Emplear algún tipo de técnica de animación para enfatizar la acción.

#### Ejercicio 2. Trayectorias.

Animar durante 10 segundos un vuelo rasante de un vehiculo aereo alrededor de una serie de bloques que simulen la distribución de unos edificios en una manzana. Modificar la altura del vuelo para pasar sobre algún edificio con menos altura o algún obstáculo. Definir el movimiento inicial mediante el uso de trayectorias.

#### Ejercicio 3. Animación de parámetros. Control de 'timing'.

En una escena con tres cubos y tres luces focales iluminándolos como en la figura, realizar una animación en la que las luces se enciendan de forma intermitente y siguiendo la siguiente secuencia:

- Primero se enciende y apaga la luz del cubo A, después la del B y después la del C.
- Después se encienden a la vez las de A y B, y después las de B y C.
- Por último, se encienden y se apagan las tres a la vez en dos ocasiones.

### Práctica 4. Animación con restricciones y animación procedural

#### Animación con restricciones (1ª sesión)

En esta primera parte vamos a practicar las limitaciones de movimientos mediante restricciones.
Practicaremos en clase los distintos tipos de restricciones que 3DS Max  permite y realizaremos unos ejercicios sencillos con ellos:
- Cambio de mano de una espada utilizando restricciones de enlace (link constraint)
- Cambio de mano de una espada utilizando restricciones de posición (position constraint)
- Cámara restringida a un camino cuyo punto de atención siempre es otro objeto que está en movimiento (path constraint + lookat constraint)
- Conexión de parametros (Wire Parameters): hacer que las ruedas de un coche giren de forma correcta en función del movimiento de un volante.

#### Animación procedural (2ª sesión)

Comenzaremos con algunos ejemplos sencillos de creación de 'scripts' con 3DS Max mediante la herramienta MaxScript.
- Ejemplo sencillo de animación de objetos
- Ejemplo de interpolación lineal
Implementaremos controles de animación de un objeto mediante código:
- Animar secuencialmente varios objetos, de forma que cada uno realice el mismo movimiento pero con cierto retraso o alteración, por ejemplo, en función de posición o distancias.
- Restricción de posicionamiento de un objeto respecto a otros: dado uno o varios objetos con animación en una escena, controlar mediante código la animación de otro objeto con alguna restricción de posicionamiento respecto a uno o varios de los anteriores.
- Implementación de interpolación cuadrática entre dos puntos, con un punto de control que define la pendiente de salida y entrada.
- Implementación de interpolación cúbica entre dos puntos, con definición de pendiente distinta para cada punto.

### Práctica 5. Animación procedural 2

Implementación de control automático de animación mediante interpolación cuadrática: utilizando los scripts de ejemplo entregados, crear un nuevo script que permita seleccionar un objeto y utilizarlo para, usando la interpolación cuadrática implementada en la sesión anterior, controlar su movimiento de forma procedural (saltos entre varias posiciones en la escena, movimiento suave interpolando posiciones, etc...). Incluir en el script la creación de claves de manera procedural para modificar automáticamente algún comportamiento del modelo (anticipación, squash & stretch, orientación a lo largo de la animación, etc...)

### Práctica 6. Orientación de objetos usando Cuaternios

En esta nueva práctica vamos a trabajar un poco más el control de animación programado.

Volveremos a controlar mediante un script la creación de una animación en la que una pelota rodará de forma realista sobre una superficie cualquiera.

Partiremos de una animación inicial predefinida en la que la posición de la pelota está definida mediante algún método (keyframes, restricción de posición, restricción de seguimiento de camino, ...), y controlaremos mediante el uso de cuaternios la orientación de la misma al rodar sobre su centro, para después hacer que se adapte a la superficie sobre la que queremos que se desplace (ver vídeo adjunto).

### Práctica 7. Animación con modelos jerárquicos

1. Crear un personaje con cubos (pose neutra)

2. Colocar el modelo anterior en una pose (usando jerarquías)

3. Utilización de cinemática directa e inversa

- Desde la pose 'base' del modelo, animar el personaje:
- Moviendo un brazo diciendo 'adios'
- Limpiando una mesa con la mano

### Práctica 8. Rigging de modelo sencillo

A partir de los conceptos vistos en clase y de los tutoriales enlazados en el tema 5, construir un rig sencillo que permita controlar una grúa de construcción.
