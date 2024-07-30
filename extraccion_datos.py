import pandas as pd

def extraction(puntaje_html):
    #Funcion para extraer los datos de la tabla de la pagina web	
    list_data=[]
    for i in puntaje_html:
        data=i.get_text().split('\n')
        cleaned_list = [x for x in data if x.strip()]
    x=0    
    y=23
    while y<208:
        extract=cleaned_list[x+1:y]
        list_data.append(extract) 
        x+=23
        y+=23
    while y<348:
        #se genera un nuevo while porque hay un dato adicional la lista de datos extraidos y debe ser eliminado
        extract=cleaned_list[x+1:y+1]
        extract.pop(1) #elemento adicional que debe ser eliminado
        list_data.append(extract) 
        x+=24
        y+=24
    while y<468:
        extract=cleaned_list[x+1:y]
        list_data.append(extract) 
        x+=23
        y+=23
    return list_data        


def crear_dataframe(datos_lista):
    #Funcion para insertar los datos en el dataframe
    column_names = ['equipo', 
                    'pts_total', 'pj_total', 'pg_total', 'pe_total', 'pp_total', 'gf_total', 'gc_total', 
                    'pts_local', 'pj_local', 'pg_local', 'pe_local', 'pp_local', 'gf_local', 'gc_local', 
                    'pts_visitante', 'pj_visitante', 'pg_visitante', 'pe_visitante', 'pp_visitante', 'gf_visitante', 'gc_visitante']

    #insertar los datos en el dataframe
    df = pd.DataFrame(datos_lista, columns=column_names)
    return df

def conversion_str_int(df):
    #Funcion para convertir los datos de str a int
    df['pts_total'] = df['pts_total'].astype(int)
    df['pj_total'] = df['pj_total'].astype(int)
    df['pg_total'] = df['pg_total'].astype(int)
    df['pe_total'] = df['pe_total'].astype(int)
    df['pp_total'] = df['pp_total'].astype(int)
    df['gf_total'] = df['gf_total'].astype(int)
    df['gc_total'] = df['gc_total'].astype(int)
    df['pts_local'] = df['pts_local'].astype(int)
    df['pj_local'] = df['pj_local'].astype(int)
    df['pg_local'] = df['pg_local'].astype(int)
    df['pe_local'] = df['pe_local'].astype(int)
    df['pp_local'] = df['pp_local'].astype(int)
    df['gf_local'] = df['gf_local'].astype(int)
    df['gc_local'] = df['gc_local'].astype(int)
    df['pts_visitante'] = df['pts_visitante'].astype(int)
    df['pj_visitante'] = df['pj_visitante'].astype(int)
    df['pg_visitante'] = df['pg_visitante'].astype(int)
    df['pe_visitante'] = df['pe_visitante'].astype(int)
    df['pp_visitante'] = df['pp_visitante'].astype(int)
    df['gf_visitante'] = df['gf_visitante'].astype(int)
    df['gc_visitante'] = df['gc_visitante'].astype(int)
    return df
    

def insertar_datos(df):
    df['promedio_goles'] = round((df['gf_total'])/df['pj_total'], 3)
    df['promedio_goles_local'] = round((df['gf_local'])/df['pj_local'],3)
    df['promedio_goles_visitante'] = round((df['gf_visitante'])/df['pj_visitante'],3)
    df['promedio_ganados']=round(df['pg_total']/df['pj_total'], 3)
    df['promedio_empatados']=round(df['pe_total']/df['pj_total'], 3)
    df['promedio_perdidos']=round(df['pp_total']/df['pj_total'], 3)
    return df