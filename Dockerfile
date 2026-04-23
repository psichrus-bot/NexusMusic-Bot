FROM node:22-slim

# Устанавливаем FFmpeg и Python3
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Создаем символическую ссылку для python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Устанавливаем yt-dlp через pip
RUN pip3 install --no-cache-dir yt-dlp --break-system-packages

# Создаем директорию приложения
WORKDIR /app

# Копируем ВСЕ файлы сначала
COPY . .

# Только потом устанавливаем зависимости
RUN npm install --production

# Запускаем бота
CMD ["node", "--no-deprecation", "index.js"]
