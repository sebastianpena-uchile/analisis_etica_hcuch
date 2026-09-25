
# 1. Cargar datos ---------------------------------------------------------

load("data/clean/datos_etica_analisis.Rdata")







# 2. Explorar datos -------------------------------------------------------




create_report(
  data = datos_etica_analisis,
  output_file = "reporte_etica.html",
  output_dir = "analyses/report" # O una ruta explícita como "~/Desktop"
)


install.packages("visdat")
library(visdat)

# Heatmap binario directo: presente vs. NA
vis_miss(datos_etica_analisis)
