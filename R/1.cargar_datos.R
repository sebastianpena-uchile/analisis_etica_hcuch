
# 1. Cargar datos ---------------------------------------------------------




datos_excel<-read_excel("data/raw/comites_bioetica_samuel_140926.xlsx")




# 2. Guardar datos --------------------------------------------------------




save(datos_excel, file = "data/raw/datos_excel.Rdata")






# 3. Limpiar entorno ------------------------------------------------------



rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
#rm() # limpiar un objeto específico


