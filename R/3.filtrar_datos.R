

# 1. Cargar datos ---------------------------------------------------------




load("data/raw/datos_excel_listo_respaldo.Rdata")




# 2. Filtrar datos --------------------------------------------------------

#Conocer columnas

names(datos_excel_listo)

#Se filtrarán los datos para hospitales de la columna "TipoEstablecimiento" 

#1. Alta complejidad
#2. Mediana comlejidad
#3. Hospital no SNSS



# # 2.1 Conocer valores unicos de columna "TipoEstablecimiento"------------


unique(datos_excel_listo$TipoEstablecimiento)


# # 2.2 Copiar el dato de hospital para filtar ----------------------------


#Filtar por:

# "Establecimiento Alta Complejidad"
# "Establecimiento Mediana Complejidad"
# "Hospital (No perteneciente al SNSS)"



# # 2.3 Filtrar datos de acuerdo a "TipoEstablecimiento" ------------------


categorias_deseadas <- c(
  "Establecimiento Alta Complejidad",
  "Establecimiento Mediana Complejidad",
  "Hospital (No perteneciente al SNSS)"
)

# Filtra y escribe directo da data/clean


datos_etica_analisis <- datos_excel_listo %>% 
  filter(TipoEstablecimiento %in% categorias_deseadas)





# 3. Guardar datos --------------------------------------------------------



save(datos_etica_analisis, file = "data/clean/datos_etica_analisis.Rdata")



# 4. Limpiar entorno ------------------------------------------------------



rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
#rm() # limpiar un objeto específico






 

