#Para cambiar el repositorio
options(repos=structure(c(CRAN="https://cran.dcc.uchile.cl/"))) 

# Limpiar entorno
rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
rm() # limpiar un objeto específico

#si no tiene pacman, lo instala
if(!require(pacman)){install.packages("pacman")}

##### Instalar paquetes requeridos (OPCION PRINCIPAL)

if(!require(tidyverse)){install.packages("tidyverse")}
if(!require(psych)){install.packages("psych")}
if(!require(Hmisc)){install.packages("Hmisc")}
if(!require(googledrive)){install.packages("googledrive")}
if(!require(readxl)){install.packages("readxl")}
if(!require(arrow)){install.packages("arrow")} #manejo archivos Parquet
if(!require(summarytools)){install.packages("summarytools")} #heramienta para tablas resumen
if(!require(DataExplorer)){install.packages("DataExplorer")} #crea reporte de estructura de datos
if(!require(visdat)){install.packages("visdat")} #visualiza graficamente la estructura de datos
if(!require(gt)){install.packages("gt")}
if(!require(janitor)){install.packages("janitor")}
if(!require(gtsummary)){install.packages("gtsummary")}
if(!require(stringr)){install.packages("stringr")}


install.packages(c("rmarkdown", "knitr", "yaml"))


##### Cargar paquetes (OTRA ALTERNATIVA)
try(pacman::p_load(tidyverse,   # Probablemente el paquete conjunto de paquetes más últil que usarán en R
                   #foreign,         # Paquete import datos
                   Hmisc,           # Paquete con funciones variadas
                   psych,  # Paquete con algunas funciones comúnmente utilizadas (https://personality-project.org/r/psych/intro.pdf)
                   arrow, #manejo archivos Parquet
                   readxl,#manejo archivos excel
                   summarytools,
                   DataExplorer,
                   rmarkdown,
                   knitr,
                   yaml,
                   visdat,
                   gt,
                   janitor,
                   gtsummary,
                   stringr,
                   install = F))    # solo cargar, no instalar




#COnfigurar Git

install.packages("usethis")
library(usethis)

usethis::use_git_config(
  user.name = "sebastianpena-uchile",
  user.email = "sebastianpena@uchile.cl",
  github.user = "Sebastián Peña Frías"
)



