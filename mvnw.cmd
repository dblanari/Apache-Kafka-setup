@ECHO OFF
SET DIR=%~dp0
SET WRAPPER_DIR=%DIR%\.mvn\wrapper
SET WRAPPER_JAR=%WRAPPER_DIR%\maven-wrapper.jar
SET PROPS=%WRAPPER_DIR%\maven-wrapper.properties

IF NOT EXIST "%WRAPPER_JAR%" (
  FOR /F "tokens=1,* delims==" %%A IN ('findstr /R "^wrapperUrl=" "%PROPS%"') DO SET WRAPPER_URL=%%B
  if exist "%ProgramFiles%\Git\usr\bin\curl.exe" (
    "%ProgramFiles%\Git\usr\bin\curl.exe" -fsSL "%WRAPPER_URL%" -o "%WRAPPER_JAR%"
  ) ELSE (
    powershell -Command "Invoke-WebRequest -OutFile '%WRAPPER_JAR%' '%WRAPPER_URL%'" || (
      ECHO Failed to download Maven wrapper&EXIT /B 1)
  )
)

SET JAVA_CMD=java
IF NOT "%JAVA_HOME%"=="" SET JAVA_CMD=%JAVA_HOME%\bin\java
"%JAVA_CMD%" -jar "%WRAPPER_JAR%" %*
