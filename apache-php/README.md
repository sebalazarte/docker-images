## Apache + PHP en Fedora con Docker

Guia breve para construir la imagen, crear el contenedor y limpiar los recursos asociados.

### 1. Construir la imagen
```bash
docker build --tag apache-fedora .
```
**Subcomando**
- `build`: indica que Docker debe construir una imagen a partir del contexto.

**Parametros**
- `--tag apache-fedora` (o `-t`): asigna nombre y etiqueta a la imagen resultante.
- `.`: usa el directorio actual (donde esta el Dockerfile) como contexto de build.

### 2. Crear y ejecutar el contenedor
```bash
docker run -d -p 80:80 --name apache apache-fedora
```
**Subcomando**
- `run`: crea y ejecuta un nuevo contenedor basado en una imagen.

**Parametros**
- `-d`: ejecuta el contenedor en modo *detached* (en segundo plano).
- `-p 80:80`: expone el puerto 80 del contenedor en el puerto 80 de la maquina host (formato `host:contenedor`).
- `--name apache`: asigna un nombre legible al contenedor para controlarlo con comandos posteriores.
- `apache-fedora`: nombre de la imagen que se usara para crear el contenedor.

### 3. Detener y eliminar el contenedor
```bash
docker stop apache
docker rm apache
```
**Subcomandos**
- `stop`: detiene un contenedor en ejecucion.
- `rm`: elimina un contenedor detenido.

**Parametros**
- `apache`: nombre del contenedor sobre el que se aplica cada subcomando.

### 4. Eliminar la imagen
```bash
docker rmi apache-fedora
```
**Subcomando**
- `rmi`: elimina una imagen local del cache de Docker.

**Parametros**
- `apache-fedora`: nombre (o ID) de la imagen que se desea borrar. Asegurate de que no existan contenedores basados en ella antes de ejecutar este comando.

### 5. Script automatizado (Windows)
```cmd
scripts\run_apache.cmd
```
**Descripcion**
- Reconoce la carpeta raiz del proyecto y ejecuta todos los comandos Docker desde alli.
- Reconstruye la imagen `apache-fedora`, elimina cualquier contenedor previo llamado `apache` y crea uno nuevo exponiendo el puerto 80.
- Muestra logs `[INFO]` y aborta con `[ERROR]` si algun paso falla, devolviendo el mismo exit code que Docker.

**Como usarlo**

1. Abre un `cmd` o PowerShell en cualquier ruta.
2. Ejecuta `d:\Docker\docker-images\apache-php\scripts\run_apache.cmd` (o `scripts\run_apache.cmd` si ya estas en la carpeta del proyecto).
3. Revisa la salida para confirmar que el build y el contenedor se lanzaron correctamente.

> Tip: si necesitas recrear todo desde cero, primero elimina el contenedor (`docker stop`/`docker rm`) y luego la imagen (`docker rmi`) antes de volver a ejecutar los pasos 1 y 2.