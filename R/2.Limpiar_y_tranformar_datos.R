

# 1. Cargar datos RAW -----------------------------------------------------



load("data/raw/datos_excel.Rdata")





# 2. Limpiar --------------------------------------------------------------






# # 2.1 Cambiar nombre columnas -------------------------------------------

#Debido a la configuracion del archivo excel, la identificación de las variables
#se perdió, quedando en las filas
# 1 = identificación de los comites
# 2 = nombre de variables (sin identificar a que comité pertenecen)

#se cambia nombre de columnas para comités científico y ético para manejo


# ## 2.1.1 En FILA 1 quedaron el nombre de los comités --------------------

#Se identificará de la siguiente forma cada comité

#COMITÉ DE ETICA CIENTIFICO = CEC
#COMITÉ DE ÉTICA ASISTENCIAL = CEA

#CEC o CEA antecede el nombre de la variable (columna) respectiva


# ## 2.1.1 Conocer datos FILA 2 ----------------------------

#para copiar y pegar el dato de la fila que corresponde a identificador variable

as.list(datos_excel[2, ])




# ## 2.1.2 Agregar CEC o CEA a variable respectiva ------------------------


datos_excel <- datos_excel %>%
  mutate(
    across(5:8,  ~ if_else(row_number() == 2, paste0("CEC_", .x), as.character(.x))),
    across(9:12, ~ if_else(row_number() == 2, paste0("CEA_", .x), as.character(.x)))
  )



# # 2.2 Pasar datos FILA 2 para nombre variable ------------------------


colnames(datos_excel) <- as.character(datos_excel[2, ])




# # 2.3 Eliminar FILA 1 y FILA 2 ------------------------------------------

#Como poseen datos de indentificación de variable se eliminan

datos_excel_listo <- datos_excel %>% 
  slice(-(1:2))






# # 2.4 Transformar los datos a PARQUET -----------------------------------



#guardado en data/raw
write_parquet(datos_excel_listo, "data/raw/datos.etica.parquet")




# 3. Guardar EXCEL como Rdata como respaldo -------------------------------

#se guarda en RAW ya que no se han filtrado las filas



save(datos_excel_listo, file = "data/raw/datos_excel_listo_respaldo.Rdata")





# 4. Limpiar entorno ------------------------------------------------------



rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
#rm() # limpiar un objeto específico






