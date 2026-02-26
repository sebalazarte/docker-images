@echo off
setlocal enabledelayedexpansion

set "IMAGE_NAME=apache-ssl"
set "CONTAINER_NAME=apache-ssl-container"
set "HOST_PORT=8443"
set "CONTAINER_PORT=443"

rem Work from the directory that contains both this script and the Dockerfile
set "SCRIPT_DIR=%~dp0"
pushd "%SCRIPT_DIR%"

echo [INFO] Starting Docker automation script in %CD% ...

echo [INFO] Building image "%IMAGE_NAME%" from current directory
docker build --tag %IMAGE_NAME% .
if errorlevel 1 goto :error

echo [INFO] Removing previous container "%CONTAINER_NAME%" if it exists
docker rm -f %CONTAINER_NAME% >nul 2>&1

echo [INFO] Launching container "%CONTAINER_NAME%" on port %HOST_PORT%:%CONTAINER_PORT%
docker run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%
if errorlevel 1 goto :error

echo [INFO] Current container status:
docker ps --filter "name=%CONTAINER_NAME%"

echo [INFO] Script completed successfully.
popd
exit /b 0

:error
popd
echo [ERROR] Script aborted with exit code %errorlevel%.
exit /b %errorlevel%
