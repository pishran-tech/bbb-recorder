#Download base image debian
FROM node

# Create app directory
WORKDIR /root/bbb-recorder

#Update Software Repository
RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN add-apt-repository ppa:jonathonf/ffmpeg-4
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get -y update
RUN apt-get -y install google-chrome-stable software-properties-common ffmpeg xvfb

Add . .
RUN npm install --ignore-scripts
RUN cp .env.example .env

CMD ["sh", "-c", "node export.js $RECORD_URL MEETING_ID 0 true"]
