FROM python:3.8-slim-buster as main

ENV RAILWAY=true
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet
ENV PIP_NO_CACHE_DIR=1

# Kerakli tizim kutubxonalarini o‘rnatish
RUN apt update && apt install -y --no-install-recommends \
    libcairo2 git gcc g++ python3-dev libffi-dev libpq-dev libssl-dev

# Kesh va keraksiz fayllarni tozalash
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Git orqali loyiha yuklash
RUN git clone https://github.com/hikariatama/Hikka /Hikka
WORKDIR /Hikka

# pip ni yangilash va kutubxonalarni o‘rnatish
RUN python -m pip install --upgrade pip
RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
RUN pip install --no-warn-script-location --no-cache-dir redis

# Port ochish
EXPOSE 8080

# Ma'lumotlar uchun papka yaratish
RUN mkdir /data

# Container ishga tushganda bajariladigan buyruq
CMD ["python3", "-m", "hikka"]
