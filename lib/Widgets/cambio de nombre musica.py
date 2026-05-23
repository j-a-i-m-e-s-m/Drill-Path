# # import os
# # import re

# # # Carpeta donde están los archivos .mp3
# # carpeta = r"C:\Users\Jaime\Desktop\musica"

# # Expresión regular para encontrar y eliminar [TextoEnCorchetes] + el espacio extra
# patron = r"\[.*?\]\s*"

# # Recorre los archivos en la carpeta
# for archivo in os.listdir(carpeta):
#     if archivo.endswith(".mp3"):
#         # Eliminar la parte entre corchetes y el espacio extra
#         nuevo_nombre = re.sub(patron, "", archivo).strip()
#         ruta_vieja = os.path.join(carpeta, archivo)
#         ruta_nueva = os.path.join(carpeta, nuevo_nombre)

#         # Renombrar solo si el nombre cambia
#         if ruta_vieja != ruta_nueva:
#             os.rename(ruta_vieja, ruta_nueva)
#             print(f'Renombrado: {archivo} → {nuevo_nombre}')

# print("Proceso terminado.")

# import os
# import re

# # Carpeta donde están los archivos .mp3
# carpeta = r"C:\Users\Jaime\Desktop\musica\Cate"

# # Expresión regular para eliminar "y2mate.com - " con espacios opcionales
# # patron = r"yt1s\.com\s*-\s*"
# # Expresión regular para eliminar "Número - " al inicio
# # patron = r"^\d+\s*-\s*"
# # Expresión regular para eliminar todo antes del primer " - "
# patron = r"^.*?\s*-\s*"
# for archivo in os.listdir(carpeta):
#     if archivo.endswith(".mp3"):
#         nuevo_nombre = re.sub(patron, "", archivo).strip()
#         ruta_vieja = os.path.join(carpeta, archivo)
#         ruta_nueva = os.path.join(carpeta, nuevo_nombre)

#         if ruta_vieja != ruta_nueva:
#             os.rename(ruta_vieja, ruta_nueva)
#             print(f'Renombrado: {archivo} → {nuevo_nombre}')

# print("Proceso terminado.")

import os
import re

# Carpeta donde están los archivos .mp3
carpeta = r"C:\Users\Jaime\Desktop\musica\Cate"

# # Expresión regular para eliminar "Número - " al inicio
# patron = r"^\d+\s*-\s*"
# Expresión regular para eliminar todo antes del primer " - "
patron = r"^.*?\s*-\s*"

for archivo in os.listdir(carpeta):
    if archivo.endswith(".mp3"):
        nuevo_nombre = re.sub(patron, "", archivo).strip()
        ruta_vieja = os.path.join(carpeta, archivo)
        ruta_nueva = os.path.join(carpeta, nuevo_nombre)

        # Si el nuevo nombre ya existe, omitir el renombrado
        if os.path.exists(ruta_nueva):
            print(f'Se omitió: {archivo} (ya existe como {nuevo_nombre})')
        else:
            os.rename(ruta_vieja, ruta_nueva)
            print(f'Renombrado: {archivo} → {nuevo_nombre}')

print("Proceso terminado.")