# Usa una imagen base de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias del sistema necesarias
RUN apt-get update && \
    apt-get install -y libgl1-mesa-glx libglib2.0-0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Actualiza pip
RUN pip install --upgrade pip

# Copia el archivo de requisitos primero
COPY requirements.txt ./

# Crea un entorno virtual
RUN python -m venv /venv

# Instala las dependencias en el entorno virtual
RUN /venv/bin/pip install --no-cache-dir -r requirements.txt

# Copia el resto de la aplicación
COPY . .

# Expone el puerto 5000
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["/venv/bin/gunicorn", "-b", "0.0.0.0:5000", "app:app"]
