#############################################################################
# Analisis de Asistencia ejemplar para el Taller: Codificación colaborativa #
# 27 de Mayo de 2021                                                        #
# Equipo de Manejo de Información del GTRM Perú                             #
#############################################################################

# Packages usados en el script
library(readxl)
library(writexl)
library(ggplot2)

# Abrir los datos
df <- read_excel("Datos/Asistencia.xlsx")

###############################
# Control y limpieza de datos #
###############################

# Limpiar y preparar los datos
df <- df %>%
  mutate(Departamento = recode(Departamento, "Arekipa" = "Arequipa"), 
         Albergue = as.factor(Albergue))

# Control de cifras
control <- df %>%  
  mutate(asistencia_check    = if_else(RyM <= Asistencia, "FALSO" , "CORRECTO"), 
         menores_check       = if_else(RyM <= Menores, "FALSO" , "CORRECTO"))

# Guardar los datos
writexl::write_xlsx(control, './Procesados/Control_Asistencia.xlsx')

#####################
# Analisis de datos #
#####################

# Calcular el porcentaje de personas asitidas
df <- df %>%  
  mutate(porcentaje_asistido = Asistencia / RyM)

# porcentaje_menores  = Menores / RyM

# Guardar los datos
write_xlsx(df, './Resultados/Datos/Asistencia.xlsx')


#####################
# Creación de tabla #
#####################

# Bar diagram - RyM
ggplot(data = df, aes(Departamento, RyM)) + 
  geom_bar(stat= "identity")

# Guardar Figura
ggsave(path = "Resultados/Figuras", filename =  "RyM.png")

# Bar diagram - Asistencia
ggplot(data = df, aes(Departamento, Asistencia)) + 
  geom_bar(stat= "identity")

# Guardar Figura
ggsave(path = "Resultados/Figuras", filename =  "Asistencia.png")

#Hola



  