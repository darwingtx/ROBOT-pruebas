# ROBOT-pruebas

## Tecnologias:
robotframework

## Como usarlo
Para usarlo simplemente hay que instalar lo requerimientos y ejecutar el test que desee.

### Instalar requerimientos
Instalar lo requerimentos con pip

```
pip install -r requirements.txt
```

Una ves se instalen asegurese que robotframework esta funcionando con:

```
robot --version
```

o con 
```
python -m robot --version
```

### Ejecutar 
Ejecutar los archivos con extencion .robot con robot <nombre del archivo>. Ejemplo
```
robot /elements/elements.robot
```

O de esta manera si no reconoce robot como comando:
```
python -m robot /elements/elements.robot
```
