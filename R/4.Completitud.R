
# 1. Cargar datos ---------------------------------------------------------

load("data/clean/datos_etica_analisis.Rdata")







# 2. Explorar datos -------------------------------------------------------


#Para todos los datos

create_report(
  data = datos_etica_analisis_todos,
  output_file = "reporte_etica_todos.html",
  output_dir = "analyses/report" # reporte queda guardato en /analyses
)





#Solo CEC



create_report(
  data = datos_etica_analisis_CEC,
  output_file = "reporte_etica_CEC.html",
  output_dir = "analyses/report" # reporte queda guardato en /analyses
)





#Solo CEA


create_report(
  data = datos_etica_analisis_CEA,
  output_file = "reporte_etica_CEA.html",
  output_dir = "analyses/report" # reporte queda guardato en /analyses
)





#Missing data por variable

# [5] "CEC_Información de las funciones del cómite de ética cientifico en la página web del establecimiento"
# [6] "CEC_Integrantes del Comité de Ética Cientifico en la página web del establecimiento"                                
# [7] "CEC_Disponibilidad del documento del reglamento de Comité de Ética Científico en la página web del establecimiento" 
# [8] "CEC_Disponibilidad del documento de presentación de caso en la página web del establecimiento"  
#7,14%

# [9] "CEA_Información de las funciones del Cómite de Ética Asistencial en la página web del establecimiento"              
# [10] "CEA_Integrantes del Comité de Ética Asistencial en la página web del establecimiento"  
#20.63%

# [11] "CEA_Disponibilidad del documento del reglamento de Comité de Ética Asistencial en la página web del establecimiento"
# [12] "CEA_Disponibilidad del documento de presentación de caso en la página web del establecimiento"
#21,43%


#visualiza la extructura gráfica de los missing


install.packages("visdat")
library(visdat)

# Heatmap binario directo: presente vs. NA
vis_miss(datos_etica_analisis_todos) 


#9.2% de missing data total





# 3. Limpiar entorno ------------------------------------------------------



rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
#rm() # limpiar un objeto específico







