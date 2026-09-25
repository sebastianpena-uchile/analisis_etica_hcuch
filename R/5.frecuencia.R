
# 1. Cargar datos ---------------------------------------------------------

load("data/clean/datos_etica_analisis.Rdata")







# 2. Tablas datos ---------------------------------------------------------



#Número de observaciones por SEREMI / SNSS


datos_etica_analisis |> 
  count(`SEREMI / Servicio de Salud`, name = "N_Observaciones", sort = TRUE) |> 
  mutate(Porcentaje = (N_Observaciones / sum(N_Observaciones)) * 100) |> 
  # Agrega la fila 'Total' directamente a las columnas existentes:
  adorn_totals(where = "row", fill = "-", name = "Total") |> 
  gt() |> 
  tab_header(
    title = "Número de obsrvaciones por SEREMI / SNSS",
    subtitle = "Conteo total por SEREMI / SNSS"
  ) |> 
  cols_label(
    `SEREMI / Servicio de Salud` = "SEREMI/SNSS",
    N_Observaciones = "N°",
    Porcentaje = "% del Total"
  ) |> 
  fmt_number(
    columns = Porcentaje,
    decimals = 1,
    pattern = "{x}%"
  ) |> 
  # Opcional: poner en negrita la última fila (el Total)
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(rows = `SEREMI / Servicio de Salud` == "Total")
  ) |> 
  opt_stylize(style = 6, color = "blue")


#Número de observaciones por Tipo de Establecimiento


datos_etica_analisis |> 
  count(TipoEstablecimiento, name = "N_Observaciones", sort = TRUE) |> 
  mutate(Porcentaje = (N_Observaciones / sum(N_Observaciones)) * 100) |> 
  # Agrega la fila 'Total' directamente a las columnas existentes:
  adorn_totals(where = "row", fill = "-", name = "Total") |> 
  gt() |> 
  tab_header(
    title = "Número de obsrvaciones por Tipo de Establecimiento",
    subtitle = "Conteo total por Tipo de Establecimiento"
  ) |> 
  cols_label(
    `TipoEstablecimiento` = "Tipo de Establecimiento",
    N_Observaciones = "N°",
    Porcentaje = "% del Total"
  ) |> 
  fmt_number(
    columns = Porcentaje,
    decimals = 1,
    pattern = "{x}%"
  ) |> 
  # Opcional: poner en negrita la última fila (el Total)
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(rows = `TipoEstablecimiento` == "Total")
  ) |> 
  opt_stylize(style = 6, color = "blue")


#Disponibilidad dimensiones CEC por Tipo de Establecimiento

datos_etica_analisis_todos |> 
  select(
    TipoEstablecimiento,
    `CEC_Información de las funciones del cómite de ética cientifico en la página web del establecimiento`,
    `CEC_Integrantes del Comité de Ética Cientifico en la página web del establecimiento`,
    `CEC_Disponibilidad del documento del reglamento de Comité de Ética Científico en la página web del establecimiento`,
    `CEC_Disponibilidad del documento de presentación de caso en la página web del establecimiento`
  ) |> 
  tbl_summary(
    by = TipoEstablecimiento,
    type = everything() ~ "dichotomous",       # <- Sintaxis correcta con fórmula
    value = everything() ~ "si",              # <- Si en tu base dice "Sí", cámbialo a "Sí"
    missing = "no",
    label = list(
      `CEC_Información de las funciones del cómite de ética cientifico en la página web del establecimiento` ~ "Funciones del CEC en web",
      `CEC_Integrantes del Comité de Ética Cientifico en la página web del establecimiento` ~ "Integrantes del CEC en web",
      `CEC_Disponibilidad del documento del reglamento de Comité de Ética Científico en la página web del establecimiento` ~ "Reglamento disponible en web",
      `CEC_Disponibilidad del documento de presentación de caso en la página web del establecimiento` ~ "Pauta/Formulario de presentación en web"
    )
  ) |> 
  add_overall(last = TRUE, col_label = "**Total**") |> 
  gtsummary::as_gt() |> 
  tab_header(
    title = "Disponibilidad de Información de Comité de Ética Científico en Sitios Web",
    subtitle = "Indicadores con presencia efectiva ('Sí') según Tipo de Establecimiento"
  ) |> 
  opt_stylize(style = 6, color = "blue")




#Disponibilidad dimensiones CEA por Tipo de Establecimiento


datos_etica_analisis_todos |> 
  select(
    TipoEstablecimiento,
    `CEA_Información de las funciones del Cómite de Ética Asistencial en la página web del establecimiento`,
    `CEA_Integrantes del Comité de Ética Asistencial en la página web del establecimiento`,
    `CEA_Disponibilidad del documento del reglamento de Comité de Ética Asistencial en la página web del establecimiento`,
    `CEA_Disponibilidad del documento de presentación de caso en la página web del establecimiento`
  ) |> 
  tbl_summary(
    by = TipoEstablecimiento,
    type = everything() ~ "dichotomous",       # <- Sintaxis correcta con fórmula
    value = everything() ~ "si",              # <- Si en tu base dice "Sí", cámbialo a "Sí"
    missing = "no",
    label = list(
      `CEA_Información de las funciones del Cómite de Ética Asistencial en la página web del establecimiento` ~ "Funciones del CEA en web",
      `CEA_Integrantes del Comité de Ética Asistencial en la página web del establecimiento` ~ "Integrantes del CEA en web",
      `CEA_Disponibilidad del documento del reglamento de Comité de Ética Asistencial en la página web del establecimiento` ~ "Reglamento disponible en web",
      `CEA_Disponibilidad del documento de presentación de caso en la página web del establecimiento` ~ "Pauta/Formulario de presentación en web"
    )
  ) |> 
  add_overall(last = TRUE, col_label = "**Total**") |> 
  gtsummary::as_gt() |> 
  tab_header(
    title = "Disponibilidad de Información de Comité de Ética Asistencial en Sitios Web",
    subtitle = "Indicadores con presencia efectiva ('Sí') según Tipo de Establecimiento"
  ) |> 
  opt_stylize(style = 6, color = "blue")





















#Disponibilidad de información CEA y CEC en páginas web




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


# ==============================================================================
# 1. TABLA: COMITÉS DE ÉTICA ASISTENCIAL (CEA)
# ==============================================================================
tabla_cea <- datos_etica_analisis_todos |> 
  filter(!str_detect(`SEREMI / Servicio de Salud`, "SEREMI")) |> 
  select(
    ServicioSalud = `SEREMI / Servicio de Salud`,
    `Funciones CEA` = `CEA_Información de las funciones del Cómite de Ética Asistencial en la página web del establecimiento`,
    `Integrantes CEA` = `CEA_Integrantes del Comité de Ética Asistencial en la página web del establecimiento`,
    `Reglamento CEA` = `CEA_Disponibilidad del documento del reglamento de Comité de Ética Asistencial en la página web del establecimiento`,
    `Presentación Casos` = `CEA_Disponibilidad del documento de presentación de caso en la página web del establecimiento`
  ) |> 
  # Calcular cantidad de hospitales analizados por Servicio de Salud
  group_by(ServicioSalud) |> 
  mutate(Hospitales_Analizados = n()) |> 
  ungroup() |> 
  pivot_longer(
    cols = c(`Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`),
    names_to = "Indicador",
    values_to = "Valor"
  ) |> 
  group_by(ServicioSalud, Hospitales_Analizados, Indicador) |> 
  summarise(
    n_si = sum(str_to_lower(str_trim(Valor)) %in% c("si", "sí", "1", "true"), na.rm = TRUE),
    .groups = "drop"
  ) |> 
  pivot_wider(
    id_cols = c(ServicioSalud, Hospitales_Analizados),
    names_from = Indicador,
    values_from = n_si
  ) |> 
  mutate(ServicioSalud = factor(ServicioSalud, levels = orden_ss_norte_sur)) |> 
  arrange(ServicioSalud) |> 
  mutate(ServicioSalud = as.character(ServicioSalud)) |> 
  gt(rowname_col = "ServicioSalud") |> 
  tab_header(
    title = "Disponibilidad de Información de Comité de Ética Asistencial (CEA) en Web",
    subtitle = "Presencia de indicadores en Hospitales de Alta y Mediana Complejidad según Servicio de Salud (Norte a Sur)"
  ) |> 
  cols_label(
    Hospitales_Analizados = "Hospitales Analizados (N)",
    `Funciones CEA` = "Funciones del CEA en web",
    `Integrantes CEA` = "Integrantes del CEA en web",
    `Reglamento CEA` = "Reglamento disponible en web",
    `Presentación Casos` = "Pauta/Formulario de presentación en web"
  ) |> 
  tab_stubhead(label = "Servicio de Salud (SNSS)") |> 
  cols_align(
    align = "center",
    columns = c(Hospitales_Analizados, `Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`)
  ) |> 
  tab_spanner(
    label = "Indicadores CEA en Sitios Web (N°)",
    columns = c(`Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`)
  ) |> 
  grand_summary_rows(
    columns = c(Hospitales_Analizados, `Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`),
    fns = list(label = "Total", id = "tot_cea", fn = "sum"),
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

tabla_cea
















# ==============================================================================
# 2. TABLA: COMITÉS DE ÉTICA CIENTÍFICO (CEC)
# ==============================================================================
tabla_cec <- datos_etica_analisis_todos |> 
  filter(!str_detect(`SEREMI / Servicio de Salud`, "SEREMI")) |> 
  select(
    ServicioSalud = `SEREMI / Servicio de Salud`,
    `Funciones CEC` = `CEC_Información de las funciones del cómite de ética cientifico en la página web del establecimiento`,
    `Integrantes CEC` = `CEC_Integrantes del Comité de Ética Cientifico en la página web del establecimiento`,
    `Reglamento CEC` = `CEC_Disponibilidad del documento del reglamento de Comité de Ética Científico en la página web del establecimiento`,
    `Presentación Casos` = `CEC_Disponibilidad del documento de presentación de caso en la página web del establecimiento`
  ) |> 
  # Calcular cantidad de hospitales analizados por Servicio de Salud
  group_by(ServicioSalud) |> 
  mutate(Hospitales_Analizados = n()) |> 
  ungroup() |> 
  pivot_longer(
    cols = c(`Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`),
    names_to = "Indicador",
    values_to = "Valor"
  ) |> 
  group_by(ServicioSalud, Hospitales_Analizados, Indicador) |> 
  summarise(
    n_si = sum(str_to_lower(str_trim(Valor)) %in% c("si", "sí", "1", "true"), na.rm = TRUE),
    .groups = "drop"
  ) |> 
  pivot_wider(
    id_cols = c(ServicioSalud, Hospitales_Analizados),
    names_from = Indicador,
    values_from = n_si
  ) |> 
  mutate(ServicioSalud = factor(ServicioSalud, levels = orden_ss_norte_sur)) |> 
  arrange(ServicioSalud) |> 
  mutate(ServicioSalud = as.character(ServicioSalud)) |> 
  gt(rowname_col = "ServicioSalud") |> 
  tab_header(
    title = "Disponibilidad de Información de Comité de Ética Científico (CEC) en Web",
    subtitle = "Presencia de indicadores en Hospitales de Alta y Mediana Complejidad según Servicio de Salud (Norte a Sur)"
  ) |> 
  cols_label(
    Hospitales_Analizados = "Hospitales Analizados (N)",
    `Funciones CEC` = "Funciones del CEC en web",
    `Integrantes CEC` = "Integrantes del CEC en web",
    `Reglamento CEC` = "Reglamento disponible en web",
    `Presentación Casos` = "Pauta/Formulario de presentación en web"
  ) |> 
  tab_stubhead(label = "Servicio de Salud (SNSS)") |> 
  cols_align(
    align = "center",
    columns = c(Hospitales_Analizados, `Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`)
  ) |> 
  tab_spanner(
    label = "Indicadores CEC en Sitios Web (N°)",
    columns = c(`Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`)
  ) |> 
  grand_summary_rows(
    columns = c(Hospitales_Analizados, `Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`),
    fns = list(label = "Total", id = "tot_cec", fn = "sum"),
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

tabla_cec















#
# Vector con las SEREMIs de salud presentes en el dataset ordenadas de Norte a Sur
orden_seremi_norte_sur <- c(
  "SEREMI De Arica y Parinacota",
  "SEREMI De Antofagasta",
  "SEREMI De Valparaíso",
  "SEREMI Metropolitana de Santiago",
  "SEREMI Del Libertador Gral. B. O'Higgins",
  "SEREMI Del Biobío",
  "SEREMI De La Araucanía",
  "SEREMI De Magallanes y la Antártica Chilena"
)


# ==============================================================================
# 1. TABLA SEREMI: COMITÉS DE ÉTICA ASISTENCIAL (CEA)
# ==============================================================================
tabla_cea_seremi <- datos_etica_analisis_todos |> 
  # Filtrar ÚNICAMENTE los registros de SEREMI
  filter(str_detect(`SEREMI / Servicio de Salud`, "SEREMI")) |> 
  select(
    Seremi = `SEREMI / Servicio de Salud`,
    `Funciones CEA` = `CEA_Información de las funciones del Cómite de Ética Asistencial en la página web del establecimiento`,
    `Integrantes CEA` = `CEA_Integrantes del Comité de Ética Asistencial en la página web del establecimiento`,
    `Reglamento CEA` = `CEA_Disponibilidad del documento del reglamento de Comité de Ética Asistencial en la página web del establecimiento`,
    `Presentación Casos` = `CEA_Disponibilidad del documento de presentación de caso en la página web del establecimiento`
  ) |> 
  # Conteo de hospitales no pertenecientes al SNSS evaluados por jurisdicción SEREMI
  group_by(Seremi) |> 
  mutate(Hospitales_Analizados = n()) |> 
  ungroup() |> 
  # Reestructuración a formato largo para consolidar conteos de cumplimiento
  pivot_longer(
    cols = c(`Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`),
    names_to = "Indicador",
    values_to = "Valor"
  ) |> 
  group_by(Seremi, Hospitales_Analizados, Indicador) |> 
  summarise(
    n_si = sum(str_to_lower(str_trim(Valor)) %in% c("si", "sí", "1", "true"), na.rm = TRUE),
    .groups = "drop"
  ) |> 
  # Pivotar indicadores a columnas manteniendo Hospitales_Analizados
  pivot_wider(
    id_cols = c(Seremi, Hospitales_Analizados),
    names_from = Indicador,
    values_from = n_si
  ) |> 
  # Ordenamiento geográfico de Norte a Sur
  mutate(Seremi = factor(Seremi, levels = orden_seremi_norte_sur)) |> 
  arrange(Seremi) |> 
  mutate(Seremi = as.character(Seremi)) |> 
  gt(rowname_col = "Seremi") |> 
  tab_header(
    title = "Disponibilidad de Información de Comité de Ética Asistencial (CEA) en Web",
    subtitle = "Presencia de indicadores en Hospitales no pertenecientes al SNSS según SEREMI (Norte a Sur)"
  ) |> 
  cols_label(
    Hospitales_Analizados = "Hospitales Analizados (N)",
    `Funciones CEA` = "Funciones del CEA en web",
    `Integrantes CEA` = "Integrantes del CEA en web",
    `Reglamento CEA` = "Reglamento disponible en web",
    `Presentación Casos` = "Pauta/Formulario de presentación en web"
  ) |> 
  tab_stubhead(label = "SEREMI de Salud") |> 
  cols_align(
    align = "center",
    columns = c(Hospitales_Analizados, `Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`)
  ) |> 
  tab_spanner(
    label = "Indicadores CEA en Sitios Web (N°)",
    columns = c(`Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`)
  ) |> 
  grand_summary_rows(
    columns = c(Hospitales_Analizados, `Funciones CEA`, `Integrantes CEA`, `Reglamento CEA`, `Presentación Casos`),
    fns = list(label = "Total", id = "tot_cea_seremi", fn = "sum"),
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

tabla_cea_seremi


# ==============================================================================
# 2. TABLA SEREMI: COMITÉS DE ÉTICA CIENTÍFICO (CEC)
# ==============================================================================
tabla_cec_seremi <- datos_etica_analisis |> 
  # Filtrar ÚNICAMENTE los registros de SEREMI
  filter(str_detect(`SEREMI / Servicio de Salud`, "SEREMI")) |> 
  select(
    Seremi = `SEREMI / Servicio de Salud`,
    `Funciones CEC` = `CEC_Información de las funciones del cómite de ética cientifico en la página web del establecimiento`,
    `Integrantes CEC` = `CEC_Integrantes del Comité de Ética Cientifico en la página web del establecimiento`,
    `Reglamento CEC` = `CEC_Disponibilidad del documento del reglamento de Comité de Ética Científico en la página web del establecimiento`,
    `Presentación Casos` = `CEC_Disponibilidad del documento de presentación de caso en la página web del establecimiento`
  ) |> 
  # Conteo de hospitales no pertenecientes al SNSS evaluados por jurisdicción SEREMI
  group_by(Seremi) |> 
  mutate(Hospitales_Analizados = n()) |> 
  ungroup() |> 
  # Reestructuración a formato largo para consolidar conteos de cumplimiento
  pivot_longer(
    cols = c(`Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`),
    names_to = "Indicador",
    values_to = "Valor"
  ) |> 
  group_by(Seremi, Hospitales_Analizados, Indicador) |> 
  summarise(
    n_si = sum(str_to_lower(str_trim(Valor)) %in% c("si", "sí", "1", "true"), na.rm = TRUE),
    .groups = "drop"
  ) |> 
  # Pivotar indicadores a columnas manteniendo Hospitales_Analizados
  pivot_wider(
    id_cols = c(Seremi, Hospitales_Analizados),
    names_from = Indicador,
    values_from = n_si
  ) |> 
  # Ordenamiento geográfico de Norte a Sur
  mutate(Seremi = factor(Seremi, levels = orden_seremi_norte_sur)) |> 
  arrange(Seremi) |> 
  mutate(Seremi = as.character(Seremi)) |> 
  gt(rowname_col = "Seremi") |> 
  tab_header(
    title = "Disponibilidad de Información de Comité de Ética Científico (CEC) en Web",
    subtitle = "Presencia de indicadores en Hospitales no pertenecientes al SNSS según SEREMI (Norte a Sur)"
  ) |> 
  cols_label(
    Hospitales_Analizados = "Hospitales Analizados (N)",
    `Funciones CEC` = "Funciones del CEC en web",
    `Integrantes CEC` = "Integrantes del CEC en web",
    `Reglamento CEC` = "Reglamento disponible en web",
    `Presentación Casos` = "Pauta/Formulario de presentación en web"
  ) |> 
  tab_stubhead(label = "SEREMI de Salud") |> 
  cols_align(
    align = "center",
    columns = c(Hospitales_Analizados, `Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`)
  ) |> 
  tab_spanner(
    label = "Indicadores CEC en Sitios Web (N°)",
    columns = c(`Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`)
  ) |> 
  grand_summary_rows(
    columns = c(Hospitales_Analizados, `Funciones CEC`, `Integrantes CEC`, `Reglamento CEC`, `Presentación Casos`),
    fns = list(label = "Total", id = "tot_cec_seremi", fn = "sum"),
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

tabla_cec_seremi






#amononar y guardar las tablas!




# 3. Limpiar entorno ------------------------------------------------------



rm(list = ls()) # limpiar completamente el entorno global environment
gc() # limpiar la memoria virtual utilizada por R
#rm() # limpiar un objeto específico