import requests
from bs4 import BeautifulSoup
import pandas as pd
from extraccion_datos import extraction, crear_dataframe, insertar_datos, conversion_str_int


def data_liga():
    url = "https://colombia.as.com/resultados/futbol/inglaterra/clasificacion/"

    ########################################################
    #----1. Verificar el estado de acceso de la pagina
    ########################################################
    try:
        status_genereport=requests.get(url).status_code
    except:
        status_genereport=None
    if status_genereport!=200:
        raise ValueError('La página esta caida')
    else:
        print("La página esta online")
        response = requests.get(url)
        content=response.text
        

    soup = BeautifulSoup(content, 'html.parser')

    ################################################################################################## 
    #--2. Encontrar la información respecto a la tabla de información de los resultados de los equipos
    ######|###########################################################################################
    table = soup.find('table', class_="tabla-datos table-hover")

    ########################################################
    #-------------3. Extraer datos de la tabla
    ########################################################
    puntajes_html = table.find_all('tbody') #extaer informacion de la tabla contenida en el tbody del html

    #Extraer los datos de las estadisticas de los equipos de la pagina
    extraccion_data=extraction(puntajes_html)

    #--------------------------------------------
    #--3.1. Crear un df para almacenar los datos
    #--------------------------------------------
    #Crear un dataframe con los datos extraidos
    df=crear_dataframe(extraccion_data)

    #insertar datos de estadisticas adicionales al dataframe
    df=conversion_str_int(df) #convertir los datos de str a int
    df=insertar_datos(df) #insertar estadiasticas adicionales al dataframe

    ####################################################
    #--3.2.descargar el dataframe en un archivo csv
    ####################################################
    df.to_csv('datos_liga_inglesa_2024.csv', index=False)

if __name__ == '__main__':
    data_liga()








