
# 1.Cargar datos ------------------------------------------------------------

load("data/clean/datos_etica_analisis.Rdata")
load("data/clean/datos_tipologias_cea_cec.Rdata")









# 2. Adaptar columnas -----------------------------------------------------




# #2.1 CEA ----------------------------------------------------------------


#Ver nombre de columnas archivo de tipologias

names(datos_tipologias)


#[1] "Cód. Perfil"                   "Funciones (1)"                 "Integrantes (2)"              
#[4] "Reglamento (3)"                "Presentación (4)"              "Score (0-4)"                  
#[7] "Nivel Comité"                  "Tipología / Nombre del Perfil" "Descripción Operativa"    



#Cambiar nombre de columnas de archivo analisis CEA de cuerdo a nombre columnas tipologia


nuevos_nombres <- c("Funciones (1)", "Integrantes (2)", "Reglamento (3)", "Presentación (4)")

# Reemplaza los nombres de las 4 columnas que inician con CEA
names(datos_etica_analisis_CEA)[grepl("^CEA", names(datos_etica_analisis_CEA))] <- nuevos_nombres


#left joint de acuerdo a las tipologias



# 1. Definir las cuatro columnas de cruce
claves_cruce <- c("Funciones (1)", "Integrantes (2)", "Reglamento (3)", "Presentación (4)")

# 2. Asegurar que ambas bases tengan el mismo tipo de dato en las claves (ej. numérico)
datos_etica_analisis_CEA <- datos_etica_analisis_CEA |> 
  mutate(across(all_of(claves_cruce), as.numeric))

datos_tipologias <- datos_tipologias |> 
  mutate(across(all_of(claves_cruce), as.numeric))

# 3. Unir por la coincidencia exacta de las 4 columnas
datos_CEA_con_tipologia <- datos_etica_analisis_CEA |> 
  left_join(datos_tipologias, by = claves_cruce)


# #2.1 CEC ----------------------------------------------------------------


#Ver nombre de columnas archivo de tipologias

names(datos_tipologias)


#[1] "Cód. Perfil"                   "Funciones (1)"                 "Integrantes (2)"              
#[4] "Reglamento (3)"                "Presentación (4)"              "Score (0-4)"                  
#[7] "Nivel Comité"                  "Tipología / Nombre del Perfil" "Descripción Operativa"    



#Cambiar nombre de columnas de archivo analisis CEA de cuerdo a nombre columnas tipologia


nuevos_nombres <- c("Funciones (1)", "Integrantes (2)", "Reglamento (3)", "Presentación (4)")

# Reemplaza los nombres de las 4 columnas que inician con CEA
names(datos_etica_analisis_CEC)[grepl("^CEC", names(datos_etica_analisis_CEC))] <- nuevos_nombres


#left joint de acuerdo a las tipologias



# 1. Definir las cuatro columnas de cruce
claves_cruce <- c("Funciones (1)", "Integrantes (2)", "Reglamento (3)", "Presentación (4)")

# 2. Asegurar que ambas bases tengan el mismo tipo de dato en las claves (ej. numérico)
datos_etica_analisis_CEC <- datos_etica_analisis_CEC |> 
  mutate(across(all_of(claves_cruce), as.numeric))

datos_tipologias <- datos_tipologias |> 
  mutate(across(all_of(claves_cruce), as.numeric))

# 3. Unir por la coincidencia exacta de las 4 columnas
datos_CEC_con_tipologia <- datos_etica_analisis_CEC |> 
  left_join(datos_tipologias, by = claves_cruce)








# Orden geográfico oficial de Norte a Sur (29 Servicios de Salud del SNSS)
orden_ss_norte_sur <- c(
  "Servicio de Salud Arica",
  "Servicio de Salud Iquique",
  "Servicio de Salud Antofagasta",
  "Servicio de Salud Atacama",
  "Servicio de Salud Coquimbo",
  "Servicio de Salud Valparaíso San Antonio",
  "Servicio de Salud Viña del Mar Quillota",
  "Servicio de Salud Aconcagua",
  "Servicio de Salud Metropolitano Norte",
  "Servicio de Salud Metropolitano Occidente",
  "Servicio de Salud Metropolitano Central",
  "Servicio de Salud Metropolitano Oriente",
  "Servicio de Salud Metropolitano Sur",
  "Servicio de Salud Metropolitano Sur Oriente",
  "Servicio de Salud Del Libertador B.O'Higgins",
  "Servicio de Salud Del Maule",
  "Servicio de Salud Ñuble",
  "Servicio de Salud Concepción",
  "Servicio de Salud Talcahuano",
  "Servicio de Salud Biobío",
  "Servicio de Salud Arauco",
  "Servicio de Salud Araucanía Norte",
  "Servicio de Salud Araucanía Sur",
  "Servicio de Salud Valdivia",
  "Servicio de Salud Osorno",
  "Servicio de Salud Del Reloncaví",
  "Servicio de Salud Chiloé",
  "Servicio de Salud Aisén",
  "Servicio de Salud Magallanes"
)

# Orden jerárquico de tipologías (de la más completa a la más incompleta)
orden_tipologias <- c(
  "Transparencia y Disponibilidad Total",
  "Institucional con Tramitación",
  "Institucional con Normativa",
  "Informativo y Normativo",
  "Normativo y Procedimental",
  "Informativo y Trámite",
  "Transparencia Institucional Básica",
  "Solo Trámite / Presentación",
  "Informativo Básico",
  "Ausente / Sin Información"
)


# ==============================================================================
# 1. TABLA: DISTRIBUCIÓN DE TIPOLOGÍAS CEA SEGÚN SERVICIO DE SALUD
# ==============================================================================
tabla_tipologia_ss <- datos_CEA_con_tipologia |> 
  # Excluir registros de SEREMIs para centrar el análisis en los SS
  filter(!str_detect(`SEREMI / Servicio de Salud`, "SEREMI")) |> 
  select(
    ServicioSalud = `SEREMI / Servicio de Salud`,
    Tipologia = `Tipología / Nombre del Perfil`
  ) |> 
  # Calcular cantidad total de hospitales analizados por cada Servicio de Salud
  group_by(ServicioSalud) |> 
  mutate(Hospitales_Analizados = n()) |> 
  ungroup() |> 
  # Tabular conteos cruzados por Servicio de Salud y Tipología
  count(ServicioSalud, Hospitales_Analizados, Tipologia, name = "n") |> 
  # Pivotar: cada Tipología se convierte en una columna
  pivot_wider(
    id_cols = c(ServicioSalud, Hospitales_Analizados),
    names_from = Tipologia,
    values_from = n,
    values_fill = 0
  ) |> 
  # Asegurar presencia y orden de todas las categorías de tipología existentes en los datos
  relocate(any_of(orden_tipologias), .after = Hospitales_Analizados) |> 
  # Ordenar geográficamente de Norte a Sur
  mutate(ServicioSalud = factor(ServicioSalud, levels = orden_ss_norte_sur)) |> 
  arrange(ServicioSalud) |> 
  mutate(ServicioSalud = as.character(ServicioSalud))

# Extraer nombres de las columnas de tipologías que quedaron presentes en el dataframe
cols_tipologias_presentes <- setdiff(names(tabla_tipologia_ss), c("ServicioSalud", "Hospitales_Analizados"))

# Construir y dar formato a la tabla con gt
tabla_tipologias_gt <- tabla_tipologia_ss |> 
  gt(rowname_col = "ServicioSalud") |> 
  tab_header(
    title = "Distribución de Tipologías de Información de Comités de Ética Asistencial (CEA) en Web",
    subtitle = "Frecuencia de perfiles en Hospitales de Alta y Mediana Complejidad según Servicio de Salud (Norte a Sur)"
  ) |> 
  cols_label(
    Hospitales_Analizados = "Hospitales Analizados (N)"
  ) |> 
  tab_stubhead(label = "Servicio de Salud (SNSS)") |> 
  cols_align(
    align = "center",
    columns = c(Hospitales_Analizados, all_of(cols_tipologias_presentes))
  ) |> 
  # Agrupar las tipologías ordenadas de más a menos completa bajo un spanner superior
  tab_spanner(
    label = "Tipología / Perfil de Transparencia CEA (De más completo a más incompleto) (N°)",
    columns = all_of(cols_tipologias_presentes)
  ) |> 
  # Fila final de Total acumulado
  grand_summary_rows(
    columns = c(Hospitales_Analizados, all_of(cols_tipologias_presentes)),
    fns = list(label = "Total", id = "tot_tipologias", fn = "sum"),
    fmt = list(~ fmt_integer(.))
  ) |> 
  tab_style(
    style = cell_text(weight = "bold"),
    locations = list(
      cells_grand_summary(),
      cells_stub_grand_summary()
    )
  ) |> 
  opt_stylize(style = 6, color = "blue")

# Mostrar tabla final
tabla_tipologias_gt