
# 1. Cargar datos ---------------------------------------------------------



#datos de comitpe de bioética
datos_excel<-read_excel("data/raw/comites_bioetica_samuel_140926.xlsx")






#datos de tipologpia de análisis
datos_tipologias<-read_excel("data/raw/perfiles_base.xlsx")



# 2. Guardar datos --------------------------------------------------------




save(datos_excel, datos_tipologias, file = "data/raw/datos_excel.Rdata")
save(datos_tipologias, file = "data/clean/datos_tipologias_cea_cec.Rdata")





# 3. Limpiar entorno ------------------------------------------------------



rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
#rm() # limpiar un objeto específico


