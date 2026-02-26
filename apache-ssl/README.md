# Certificados autofirmados para Apache SSL

Esta carpeta contiene los archivos necesarios para ejecutar la imagen `apache-ssl`. Antes de iniciar el contenedor debes generar una pareja de clave privada y certificado autofirmado que Apache usará para terminar las conexiones HTTPS.

## Pasos para generar las llaves

1. Abre **Git Bash** (u otro shell con OpenSSL disponible) y navega hasta el directorio `apache-ssl` del proyecto.
2. Ejecuta el siguiente comando, que creará la clave privada (`docker.key`) y el certificado (`docker.crt`) válidos por un año:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout docker.key -out docker.crt
```

Puedes cambiar los nombres de los archivos (`docker.key` y `docker.crt`) o la cantidad de días de validez según tus necesidades; solo asegúrate de actualizar las rutas donde Apache espera encontrar esos archivos.

## Explicación del comando

- `req`: invoca el generador de solicitudes de certificado (CSR) y creación de claves.
- `-x509`: indica que se debe emitir directamente un certificado X.509 autofirmado en vez de una CSR.
- `-nodes`: evita cifrar la clave privada con passphrase para que Apache pueda leerla sin intervención manual.
- `-days 365`: establece la vigencia del certificado en 365 días; ajusta el valor si necesitas otro periodo.
- `-newkey rsa:2048`: genera una nueva clave RSA de 2048 bits junto con el certificado.
- `-keyout docker.key`: nombre del archivo que almacenará la clave privada.
- `-out docker.crt`: nombre del archivo de salida para el certificado público.

Una vez generados los archivos, puedes construir y ejecutar la imagen `apache-ssl` con los certificados recién creados para habilitar HTTPS en tu entorno local.