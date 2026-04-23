FROM node:22-slim

# Устанавливаем FFmpeg, Python3 и socat (для TCP-туннеля)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    socat \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install --no-cache-dir yt-dlp --break-system-packages

WORKDIR /app
COPY . .
RUN npm install --production

# Запускаем туннель socat в фоне и затем стартуем бота
CMD socat UDP4-LISTEN:50000,fork TCP4:localhost:50000 & \
    socat UDP4-LISTEN:50001,fork TCP4:localhost:50001 & \
    node --no-deprecation index.js
