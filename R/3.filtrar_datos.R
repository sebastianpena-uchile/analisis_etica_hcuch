

# 1. Cargar datos PARQUET -----------------------------------------------------

#no asustarse porque los datos quedan en memoria como
#<Object containing active binding>
datos_etica_parquet <- open_dataset("data/raw/datos.etica.parquet")





# 2. Filtrar datos --------------------------------------------------------



#Se filtrarán los datos para hospitales

#1. Alta complejidad
#2. Mediana comlejidad
#3. Hospital no SNSS



# # 2.1 Conocer valores unicos de columna "TipoEstablecimiento"------------


valores_unicos <- datos_etica_parquet %>%
  distinct(TipoEstablecimiento) %>%
  collect() %>%
  pull(TipoEstablecimiento)

# Ver el resultado
print(valores_unicos)



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
datos_etica_parquet %>%
  filter(TipoEstablecimiento %in% categorias_deseadas) %>%
  write_parquet("data/clean/datos_etica_filtrados.parquet")

