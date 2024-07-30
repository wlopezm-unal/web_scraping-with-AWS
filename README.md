Es un proyecto en el cual se crea la infraestructura en AWS usando Terraform para crear las VPC,  EC2, S3, RDS, el grupo de seguridad. Esto con el fin de en EC2 poder ejecutar un código de web scraping y extraer los datos con respecto a la liga de futbol inglesa 2023-2024 y guardar dicha información en un S3.

It is a project in which the infrastructure is created in AWS using Terraform to create the VPC, EC2, S3, RDS, the security group. This in order to be able to run a web scraping code in EC2 and extract data regarding the English soccer league 2023-2024 and save that information in an S3.

----------------------------------------------------------------------------------------------------------------------
Correr el script de web scraping usando el cliente SSH

----------------------------------------------------------------------------------------------------------------------
1. Instalar dependencias
	* sudo apt-get update
	* sudo apt update

2. Clonar el repositorio github
	* git clone https://github.com/wlopezm-unal/proyecto-tic
3. Crear el entorno virtual para poder ejecutar el script
	* sudo install python3-pip
	* sudo apt install python3-venv
	* pip install -r requeriments.txt
4. Ejecutar el script scraping.py
	* python3 scraping.py

----------------------------------------------------------------------------------------------------------------------
Pasar el archivo csv generado por el web scraping a s3 usando AWS CLI del usando el cliente SSH

----------------------------------------------------------------------------------------------------------------------
Pasos para poder subir tu archivo CSV a un bucket de S3 desde tu instancia EC2 usando PuTTY
1. Instalar las dependencias
	* sudo apt install unzip curl -y 

2. Descargar la aws cli
	* curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

3. Descomprimir el archivo descargado
	* unzip awscliv2.zip

4. Instalar la AWS CLI
	* sudo ./aws/install

5. aws --version
	* aws --version

6. Configurar la AWS CLI
	* aws configure

 Te pedirá ingresar los siguientes datos:

	AWS Access Key ID: Ingresa tu Access Key ID.
	AWS Secret Access Key: Ingresa tu Secret Access Key.
	Default region name: Ingresa tu región predeterminada, por ejemplo, us-west-2.
	Default output format: Puedes dejarlo en blanco o escribir json

7. Subir el archivo CSV a S3
	* cd proyecto-tic
	* aws s3 cp datos_liga_inglesa_2024.csv s3://proyecto-bucket/datos_liga_inglesa_2024.csv
