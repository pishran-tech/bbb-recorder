#Download base image debian
FROM node

WORKDIR /root/bbb-recorder

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get -y update \
  && apt-get -y install google-chrome-stable software-properties-common

RUN add-apt-repository ppa:jonathonf/ffmpeg-4 \
  && apt -y install ffmpeg xvfb


Add . .
RUN npm install --ignore-scripts \
  && cp .env.example .env

CMD ["sh", "-c", "node export.js $RECORD_URL MEETING_ID 0 true"]
