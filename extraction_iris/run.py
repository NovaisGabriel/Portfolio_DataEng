import zipfile
# import requests
# from io import BytesIO
import os
import boto3

# Cria um diretório para armazenar o conteúdo do enade
os.makedirs('./data', exist_ok=True)

# print("Extracting data...")

# # Define a url e faz o download do conteúdo
# url = "https://download.inep.gov.br/microdados/microdados_enem_2020.zip"
# filebytes = BytesIO(requests.get(url).content)

print("Unzip files...")
# Extrai o conteúdo do zipfile para a pasta selecionada
# myzip = zipfile.ZipFile('../data/Iris.rar')
# myzip.extractall('./data_extracted')
with zipfile.ZipFile('./data/Iris.zip', 'r') as zip_ref:
    zip_ref.extractall('./data_extracted')


print("Upload to S3...")
s3_client = boto3.client('s3', aws_access_key_id=os.environ['AWS_ACCESS_KEY_ID'], aws_secret_access_key=os.environ['AWS_SECRET_ACCESS_KEY'])
s3_client.upload_file(
    "./data_extracted/iris.csv", 
    "teste-estrutura-prod-landing-zone-715036709715", 
    "data_extracted/iris.csv"
)