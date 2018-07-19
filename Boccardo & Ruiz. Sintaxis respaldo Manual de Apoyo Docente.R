# SINTAXIS DE RESPALDO 

# Boccardo, Giorgio y Ruiz, Felipe (2018). Uso de RStudio para Estadística Univariada en Ciencias Sociales. Manual de apoyo docente para la asignatura Estadística Descriptiva. Santiago: Departamento de Sociología, Facultad de Ciencias Sociales, Universidad de Chile (primera edición).

# ---- 0. INSTRUCCIONES

# Esta sintaxis constituye el respaldo de todas las operaciones de R efectuadas en el material de apoyo docente ya referenciado.
# Sigue el mismo orden, y está diseñada pensando en que funcione como un complemento a tal documento, sobre todo para quienes quieran replicar los análisis en R.

install.packages(c("readxl","installr","updateR","haven","modeest",
                   "FinCal","PropCIs","Publish","ggplot2", "summarytools"))

# ---- EJERCICIO 1 ----

#Asignación del valor "10" al objeto "X"
X <- 10
X

#Cambiar el valor de X: cambiar el "10" por un "5"
X <- 5
X

# ---- EJERCICIO 2 ----

#Asignación del valor "5" al objeto "Y"
5 -> Y
Y

#Concatenar valores para crear un vector de más de un sólo valor
edad <- c(15, 12, 27, 55, 63, 63, 24,21, 70)

#Tabla de frecuencias simples
table(edad)

# ---- EJERCICIO 3 ----

#Vector numérico (función concatenar)
a <- c(4, 3, 5) 

#Vector numérico (función concatenar)
b <- c(1.1, 4.67, 5.1, 6.8) 

#Vector alfanumérico (función concatenar)
letras <- c("hombre", "mujer", "no sabe/no responde")

# ---- EJERCICIO 4 ----

#Creación de las variables: todas tienen la misma cantidad de casos

genero <- c(1,1,0,1,0,0,0,1,0)

ingreso <- c(100000,300000,500000,340000,300000,500000,650000,410000,750000)

acuerdo <- c(1,1,3,2,4,1,5,3,2)

#Creación de base de datos a partir de variables previamente creadas
#Se asigna el resultado al objeto "aborto"
aborto <- data.frame(genero, ingreso, acuerdo) 

#Comando para visualizar base vía sintaxis (o hacer click en entorno)
View(aborto) 

#Se indica primero el objeto a guardar y luego el nombre del archivo, entre comillas
save(aborto, file = "aborto.RData")

#Comando para eliminar elementos especificos, aquí se elimina 
#la base creada.
remove(aborto) 

#Comando para limpiar todos los objetos del entorno de trabajo.
rm(list = ls()) 

# ---- EJERCICIO 5 ----

#Descarga e instala el paquete readxl.
install.packages("readxl")

#Carga el paquete descargado a la sesión de trabajo de R.
library(readxl)

#Actualizar R
install.packages("installr")

library(installr)

updateR()

#Actualizar paquetes instalados
update.packages()

# ---- EJERCICIO 6 ----

#Descargar e instalar paquete haven.
install.packages("haven")

#Debemos asegurarnos de que el paquete a ejecutar está cargado en la sesión de Rtudio.
library(haven) 

#Importación de base de datos en formato SPSS
CEP <- read_spss("CEP_sep-oct_2017.sav")

# ---- EJERCICIO 7 ----

#Descarga e instalación del paquete readxl.
install.packages("readxl") 

#Cargar paquete en sesión de trabajo de R
library(readxl) 

#Leer libro excel
CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx") 

#indica posición de hoja en el libro de trabajo.
CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx", sheet = 2) 

#indica nombre de hoja en libro de trabajo.
CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx", sheet = "DATOS") 

#Indica posición de la hoja en el libro de trabajo.
CEP_excel  <- read_excel("CEP_sep-oct_2017.xlsx", sheet = 2. skip = 1)

#Leer archivo CSV con configuración por defecto
CEP_csv  <- read.csv("CEP_sep-oct_2017.csv")

#Leer archivo CSV indicando separador de valores
CEP_csv  <- read.csv("CEP_sep-oct_2017.csv", sep = ";")

#Leer archivo CSV con función configurada para notación latinoamericana
CEP_csv2 <- read.csv2("CEP_sep-oct_2017.csv")

#Limpiar entorno de trabajo
remove(CEP_csv2, CEP_excel)

# ---- EJERCICIO 8 ----

#Cargar paquete, si no está cargado desde antes.
library(dplyr) 

#Se indica base de datos, el nombre de variable a crear y los datos que la compondrán.
CEP <- select(CEP_csv, pond = POND, sexo = SEXO, region = REGION, edad = DS_P2_EXACTA,
              satisfaccion_vida = SV_1, satisfaccion_chilenos = SV_2, eval_econ = MB_P2)

#Visualización de la base
View(CEP) 

#Guardar base en formato R
save(CEP, file = "seleccion_CEP.RData")

# Dejar en cero entorno de trabajo
rm(list = ls())

# ---- EJERCICIO 9 ----

#Cargar base de datos para posteriores ejercicios
load("seleccion_CEP.RData")

#Visualizar nombres de columnas
names(CEP)

#Dimensión base de datos
dim(CEP)

#Estadísticos descriptivos
summary(CEP)

# ---- EJERCICIO 10 ----

#Características variables sexo
table(CEP$sexo)
class(CEP$sexo)

#Recodificación sexo a vector character y luego a vector factor
CEP <- mutate(CEP, sexo_chr = recode(CEP$sexo, "1" = "hombre", "2" = "mujer"))
table(CEP$sexo_chr)
class(CEP$sexo_chr)
CEP <- mutate(CEP, sexo_factor = factor(CEP$sexo, 
                                        labels = c("Hombre", "Mujer")))

# ---- EJERCICIO 11 ----

#Explorar variable región
table(CEP$region)
class(CEP$region)

#Transformar a una variable distinta, categorías "Otras regiones" y "Región Metropolitana".
CEP <- mutate(CEP, region_factor = car::recode(CEP$region, "1:12 = 1; 13 = 2; 14:15 = 1"))

#Sobreescribir variable con resultado de convertir a factor incorporando etiquetas
CEP$region_factor <- factor(CEP$region_factor, 
                            labels = c("Otras regiones", "Región Metropolitana"))

#Se sigue manteniendo la estuctura de casos, aunque Cambia el formato del objeto.
table(CEP$region_factor) 
class(CEP$region_factor) 

# ---- EJERCICIO 12 ----

#Explorar variable "satisfacción con la propia vida"
class(CEP$satisfaccion_vida)
table(CEP$satisfaccion_vida)
summary(CEP$satisfaccion_vida)

#Explorar variable "percepción de la satisfacción que los chilenos tienen con su vida"
class(CEP$satisfaccion_chilenos)
table(CEP$satisfaccion_chilenos)
summary(CEP$satisfaccion_chilenos)

#Asignar NA a casos con valor 88 y 99
CEP$satisfaccion_vida[CEP$satisfaccion_vida==88]<- NA 
CEP$satisfaccion_vida[CEP$satisfaccion_vida==99]<- NA

#Ver resultado de codificación
table(CEP$satisfaccion_vida) 
summary(CEP$satisfaccion_vida)

CEP$satisfaccion_chilenos[CEP$satisfaccion_chilenos==88]<- NA
CEP$satisfaccion_chilenos[CEP$satisfaccion_chilenos==99]<- NA
table(CEP$satisfaccion_chilenos)
summary(CEP$satisfaccion_chilenos)

# ---- EJERCICIO 13 ----

#Explorar variable "evaluación de la economía"
class(CEP$eval_econ)
table(CEP$eval_econ)
summary(CEP$eval_econ)

#Recodificar variable a 3 tramos: positiva, neutra, negativa
#Valores perdidos se asignan en la misma codificación, con argumento else ("todos los demás valores")
CEP <- mutate(CEP, eval_econ_factor = 
                car::recode(CEP$eval_econ, 
                            "1:2 = 1; 3 = 2; 4:5 = 3; else = NA"))

#Transformar a vector tipo factor para etiquetar
CEP$eval_econ_factor <- factor(CEP$eval_econ_factor, 
                               labels = c("Positiva", "Neutra", "Negativa"))

#Ver resultado codificación
table(CEP$eval_econ_factor)
summary(CEP$eval_econ_factor)

# ---- EJERCICIO 14 ----

#Media simple y media recortada
mean.default(CEP$satisfaccion_vida, na.rm = TRUE)
mean.default(CEP$satisfaccion_vida, na.rm = TRUE, trim = 0.025)

#Mediana
median.default(CEP$satisfaccion_vida, na.rm = TRUE)

#Moda
install.packages("modeest")
library(modeest)
mfv(CEP$edad) 

# ---- EJERCICIO 15 ----

#Frecuencias absolutas
tabla <- table(CEP$eval_econ_factor)
tabla

#Frecuencias relativas (proporciones)
tabla_prop <- prop.table(tabla)
tabla_prop

#Frecuencias relativas (porcentajes)
tabla_porcentaje <- ((tabla_prop)*100)
tabla_porcentaje

# ---- EJERCICIO 16 ----

#Exportar tablas de frecuencias a formato planilla
write.csv2(tabla, file = "Tabla 1.csv")
write.csv2(tabla_prop, file= "Tabla 2.csv")
write.csv2(tabla_porcentaje, file= "Tabla 3.csv")

# ---- EJERCICIO 17 ----

#Cuantiles
quantile(CEP$satisfaccion_chilenos, prob = c(0.25, 0.5, 0.75), na.rm = TRUE)

# ---- EJERCICIO 18 ----

#Rango
range(CEP$edad, na.rm = TRUE)
min(CEP$edad, na.rm = TRUE)
max(CEP$edad, na.rm = TRUE)

#Varianza y desviación estándar
var(CEP$satisfaccion_chilenos, na.rm = TRUE)
sd(CEP$satisfaccion_chilenos, na.rm = TRUE)

#Coeficiente de variación
sd(CEP$edad)/mean(CEP$edad)

#Asegurarse de ejecutar previamente el comando "install.packages("FinCal")"
library(FinCal)
coefficient.variation(sd=sd(CEP$edad), avg = mean(CEP$edad))

# ---- EJERCICIO 19 ----

#Estadísticos muestrales
summary(CEP$satisfaccion_vida)

#Guardar summary como objeto
descriptivos <- summary(CEP$satisfaccion_vida)

#Ver nombres y valores del objeto
names(descriptivos)
as.numeric(descriptivos)

#Configurar como matriz de datos
descr_sat_vida <- as.data.frame(rbind(names(descriptivos), as.numeric(descriptivos)))
View(descr_sat_vida)

#Exportar matriz a archivo CSV
write.csv2(descr_sat_vida, file = "Tabla 4.csv")

# ---- EJERCICIO 20 ----

#Cálculo simple de estadíticos descriptivos
min <- min(CEP$satisfaccion_vida, na.rm = TRUE)
q1 <- quantile(CEP$satisfaccion_vida, probs = 0.25, na.rm = TRUE)
media <- mean.default(CEP$satisfaccion_vida, na.rm = TRUE)
media_rec <- mean.default(CEP$satisfaccion_vida, trim = 0.025, na.rm = TRUE)
mediana <- median.default(CEP$satisfaccion_vida, na.rm = TRUE)
moda <- mfv(CEP$satisfaccion_vida)
var <- var(CEP$satisfaccion_vida, na.rm = TRUE)
desvest <- sd(CEP$satisfaccion_vida, na.rm = TRUE)
q3 <- quantile(CEP$satisfaccion_vida, probs = 0.75, na.rm = TRUE)
max <- max(CEP$satisfaccion_vida, na.rm = TRUE)

#Valores de estadísticos como vector
descriptivos_satvida <- as.numeric(c(min, q1, media, media_rec, mediana, moda,
                                     var, desvest, q3, max))

#Encabezados de cada estadístico como un vector
nombres <- c("Mínimo", "Q1", "Media", "Media recortada", "Mediana", "Moda",
             "Varianza", "Desviación Estándar", "Q3", "Máximo")

descr2 <- as.data.frame(rbind(nombres,descriptivos_satvida))

write.csv2(descr2, file = "Tabla 5.csv")

# ---- EJERCICIO 21 ----

#Intervalos de confianza para proporciones
install.packages("PropCIs")
library(PropCIs)
table(CEP$eval_econ_factor)
nrow(CEP)
exactci(x = 730, n = 1424, conf.level = 0.95)

# ---- EJERCICIO 22 ----
#Intervalos de confianza para medias
install.packages("Publish")
library(Publish)
#Nivel de confianza por defecto.
ci.mean(CEP$satisfaccion_vida)
#Definición manual del nivel de confianza.
ci.mean(CEP$satisfaccion_vida, alpha = 0.2)

# ---- EJERCICIO 23 ----

#Intervalos de confianza de medias, para diferentes grupos
ci.mean(satisfaccion_vida~sexo_factor, data=CEP) 

# ---- EJERCICIO 24 ----
# Transformar variable sexo a factor (contar con valores y etiquetas)
CEP <- mutate(CEP, sexo_factor = factor(CEP$sexo, 
                                        labels = c("Hombre", "Mujer")))

# ---- EJERCICIO 25 ----
#Limitaciones de la función hist
hist(CEP$sexo)
hist(CEP$sexo_chr)
hist(CEP$sexo_factor)

#Gráfico de barras
plot(CEP$sexo_factor, main = "Gráfico de barras 1",
     xlab = "Género", ylab = "Frecuencia")

# ---- EJERCICIO 26 ----

#Valores que dividirán el gráfico
porcentajes <- as.numeric(round(((prop.table(table(CEP$eval_econ_factor)))*100),2))
porcentajes

#Etiquetas para el gráfico
etiquetas <- c("Positiva", "Neutra", "Negativa")
etiquetas
etiquetas <- paste(etiquetas, porcentajes)
etiquetas
etiquetas <- paste(etiquetas, "%", sep = "")
etiquetas

#Gráfico de torta
pie(porcentajes, etiquetas,
    main = "Gráfico de torta 1",
    sub = "Evaluación de la situación económica")

# ---- EJERCICIO 27 ----
#Histograma de frecuencias
hist(CEP$edad, main = "Histograma de frecuencias 1",
     xlab = "Edad (años cumplidos)",
     ylab = "Frecuencia",
     col = "red",
     border = "black",
     xlim = c(18, 97),
     ylim = c(0, 150))

#Histograma de densidad
densidad_edad <- density(CEP$edad)
plot(densidad_edad, 
     main = "Histograma de densidad 1",
     xlab = "Edad (años cumplidos)",
     ylab = "Densidad")


# ---- EJERCICIO 28 ----

#Gráfico de cajas
boxplot(CEP$edad, main = "Gráfico de cajas 1",
        outline = TRUE)

# ---- EJERCICIO 29 ----

#Cargar paquete ggplot2
library(ggplot2)

#Gráfico de barras 2: sexo en frecuencias absolutas
ggplot(CEP, aes(x = sexo_factor)) +
  geom_bar(width = 0.4,  fill=rgb(0.1,1,0.5,0.7)) +
  scale_x_discrete("Sexo") +     # configuración eje X (etiqueta del eje)
  scale_y_continuous("Frecuencia") +
  labs(title = "Gráfico de barras 2",
       subtitle = "Frecuencia absoluta de la variable sexo")

#Gráfico de barras 3: sexo en frecuencias relativas (porcentaje)
ggplot(CEP, aes(x = sexo_factor)) +
  geom_bar(width = 0.4, fill=rgb(0.1,0.3,0.5,0.7), aes(y = (..count..)/sum(..count..))) +
  scale_x_discrete("Sexo") +     # configuración eje X (etiqueta del eje)
  scale_y_continuous("Porcentaje",labels=scales::percent) + #Configuración eje y
  labs(title = "Gráfico de barras 3",
       subtitle = "Frecuencia relativa de la variable sexo")

#Histograma de frecuencias
ggplot(CEP, aes(x = as.numeric(edad))) +
  geom_histogram(binwidth = 0.6) +
  scale_x_continuous("Edad (años cumplidos)") + 
  scale_y_continuous("Frecuencia") +
  labs(title = "Histograma de frecuencias 2",
       subtitle = "Frecuencia absoluta de la variable edad")

#Histograma de densidad

ggplot(CEP, aes(x = edad)) +
  geom_density() +
  scale_y_continuous("Densidad") +
  scale_x_continuous("Edad") +
  labs(title = "Histograma de densidad 2",
       subtitle = "Forma de la distribución de la variable edad")











