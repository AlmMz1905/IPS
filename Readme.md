# Consigna:

## Introducción

En esta materia se ha puesto énfasis en la utilización de la herramienta informática Octave como complemento del espacio de práctica, considerando que en primer término la misma brinda grandes ventajas en el aprendizaje de los temas de la materia, y en segundo término el manejo de la herramienta en sí misma es de provecho para un profesional vinculado al procesamiento de señales. Por otra parte, consideramos que la capacidad de presentar resultados de una manera ordenada, para que puedan ser interpretados por un tercero no debe ser ajena a la formación de todo profesional, y mucho menos de un profesional de la Ingeniería.

Este trabajo con utilitario se enfoca en la utilización de Octave como herramienta para el análisis y descripción de sistemas discretos, en particular de tipo lineal e invariante al desplazamiento (o en el tiempo). Para ello se provee una serie de funciones en archivos de tipo .m. Para consultar la ayuda de cada función, se puede escribir en la ventana de comandos: help <nombreArchivo>.

### Los archivos provistos son:
 • senial.m: Señal del Ejercicio 1, y sus correspondientes instantes. Para más información, escribir help senial.
 • hcanald.m: Respuesta impusional del canal discreto del Ejercicio 2. Para más información, escribir help hcanald.

### Los estudiantes deben resolver las consignas planteadas y entregar:
 • Un breve informe con los procedimientos utilizados (por ejemplo, listado de comandos), los resultados conseguidos (por ejemplo, gráficas de las señales) y las conclusiones obtenidas. Este informe debe ser entregado en formato digital, respetando la fecha límite. Ver condiciones de entrega debajo.
 • TODOS los scripts de Octave utilizados en la resolución, de manera que los resultados obtenidos puedan ser reproducidos por un tercero. Ver condiciones de entrega debajo.

## Condiciones de Entrega
El trabajo puede realizarse en grupos de hasta 2 (dos) personas. En caso de detectarse copias entre distintos trabajos, los mismos serán desaprobados. La entrega del informe y los scripts de Octave debe realizarse a través de la plataforma Moodle, subiendo los siguientes archivos:
 1. El informe en formato PDF. El nombre del archivo debe respetar la siguiente estructura: IPS- pu1-APELLIDOS.pdf.
 2. Un archivo comprimido (.zip o .7z) que contenga todos los scripts de Octave utilizados. Debe haber un script principal para que el ayudante que corrija el informe pueda ejecutar todos y cada uno de los incisos del laboratorio de manera simple y ordenada. El nombre del archivo debe respetar lo siguiente: IPS-pu1-scripts-APELLIDOS.zip.

Se creará una tarea dentro del aula virtual donde un estudiante de cada grupo deberá subir los archivos (el informe debe contener claramente los datos de cada integrante). Las fechas límite de entrega y devolución estarán publicadas en la tarea correspondiente dentro del aula virtual. Luego de una primera revisión, los grupos que deban realizar ajustes o correcciones dispondrán de una semana adicional para presentar la versión corregida.


## Entrega de Correcciones
En caso de ser necesarias correcciones en el informe y/o en los scripts, las versiones corregidas deberán subirse en una nueva tarea que estará disponible, respetando el formato en los nombres de los archivos ya consignado pero agregando al final de cada uno _Corregido. Los archivos correspondientes a la primera entrega deberán permanecer en la plataforma, para que los docentes puedan contrastarlos con las nuevas versiones y verificar las correcciones pertinentes. Cabe destacar que esta segunda entrega no tendrá devolución, por lo que la nota definitiva del laboratorio se dará en esa instancia.

### Consejo

Para insertar gráficos hechos con Octave en un editor de textos, un método rápido y relativamente seguro es el siguiente:
1. En Octave ingrese el comando:
``` print -f1 -dpng figurita ```
Esto generará en el directorio actual el archivo gráfico figurita.png. El número que sigue a la opción -f es el número de la figura de Octave que se exportará.
2. Desde el editor de texto que utilice, inserte la figura. En general es conveniente que la figura no flote sobre el texto.

## Ejercicio 1
La función senial.m retorna una señal de variable independiente discreta, y los instantes 𝑛 en los que está definida la misma.
1. Grafique esta señal. Obtenga una aproximación de la TFTD de la misma y grafíquela. ¿Qué componentes de frecuencia identifica? Se tienen cuatro sistemas descriptos por las siguientes ecuaciones en diferencias

$$
y[n] = \frac{1}{2}x[n] + \frac{1}{2}x[n-1]
$$

$$
y[n] = \frac{1}{2}x[n] - \frac{1}{2}x[n-1]
$$

$$
y[n] = \frac{1}{4}x[n] + \frac{1}{4}x[n-1] + \frac{1}{2}y[n-1]
$$

$$
y[n] = \frac{1}{4}x[n] - \frac{1}{4}x[n-1] - \frac{1}{2}y[n-1]
$$

Con los cuales se quiere procesar la señal anterior.
2. Obtenga la respuesta impulsional y la respuesta en frecuencia de cada uno de los sistemas (de manera analítica). Grafíquelas. ¿De qué tipo de sistemas se trata?
3. Codifique funciones que implementen cada uno de los sistemas. Como ejemplo, puede basarse en la función ```tri1``` que se muestra en el TP 1. Verifique que la respuesta impulsional de cada uno de los sistemas así implementados coincide con la obtenida analíticamente. Verifique que la TFTD de la respuesta impulsional coincida con la respuesta en frecuencia obtenida analíticamente.
4. Utilizando sus implementaciones del inciso anterior, obtenga la señal de salida para cada sistema, cuando se aplica a la entrada la señal del inciso 1. Grafique en cada caso.
5. Obtenga la TFTD de las salidas. ¿Qué componentes de frecuencia identifica? ¿Qué conclusiones puede sacar?

## Ejercicio 2
La señal ℎ𝐴[𝑛] retornada por la función hcanald.m representa la respuesta impulsional de un sistema SLID FIR que modela el comportamiento de un canal digital con dos ecos.
1. Grafique esta respuesta al impulso e interprete en qué consiste el modelo mencionado. Escriba la ecuación en diferencias que representa el sistema. ¿Qué puede decir acerca de la estabilidad del sistema?
2. Escriba en Octave una función que implemente un sistema con esta ecuación en diferencias. Verifique que este sistema tiene la misma respuesta impulsional que la obtenida en 1.
Por otra parte, el comando:
``` [x, fs] = audioread('audio.wav')```; permite cargar un archivo de audio (en este caso, el provisto entre los archivos de la presente práctica) en la variable x. La variable fs indica la frecuencia de muestreo de la señal, concepto que estudiaremos más adelante. Como cualquier otra variable, se puede graficar utilizando el comando ```plot(x)```, y es posible escuchar la señal mediante el comando: ```sound(x,fs)```;
3. Usando la función escrita en 2, halle la salida del sistema (que llamaremos y) cuando se aplica a su entrada la señal de audio x. ¿Cómo se escucha esta señal? Grafique la señal de entrada y de salida en el tiempo. Una forma de intentar corregir el efecto que introduce el canal consiste en colocar un filtro FIR en cascada con el canal intentando que la respuesta impulsional total se aproxime lo más posible a una única delta de Kronecker, ¿Por qué querríamos lograr esto?. Por ejemplo, si la respuesta impulsional del canal fuese ℎ𝑐[𝑛] = 𝛿[𝑛] + 𝛼1𝛿[𝑛 − 𝑛0], un filtro con una sóla rama de retardo sería de la forma 𝑦[𝑛] = 𝑥[𝑛] + 𝛽1𝑥[𝑛 − 𝑛1]. Analizando la respuesta impulsional de la cascada, ¿Qué efecto tiene este sistema? ¿Qué valores de 𝛽1 y 𝑛1 logran la mejor corrección? ¿Por qué la corrección no es perfecta? ¿Cómo añadiría una segunda rama de retardos que mejore esto?
4. Con esta idea implemente un sistema que intente corregir el efecto del canal. Genere un filtro con 2 ramas de retardo y otro con 3 ramas de retardo. En cada caso, explicite la ecuación en diferencias de los filtros y grafique la respuesta impulsional de la cascada (canal + filtro).
5. Filtre la señal y con estos sistemas y escuche como suena. Compare cada una de estas señales con la señal x original.