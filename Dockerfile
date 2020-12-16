FROM cypress/base:10
RUN node --version
RUN npm --version
WORKDIR /home/node/app
# copy our test application
COPY package.json package-lock.json ./
COPY app ./app
COPY serve.json ./
# copy Cypress tests
COPY cypress.json cypress ./
COPY cypress ./cypress

ENV CI=1

# install NPM dependencies and Cypress binary
RUN npm ci
# check if the binary was installed successfully
RUN $(npm bin)/cypress verify

# Set to use Sorry Cypress
RUN sed -i 's/api.cypress.io/http://localhost:1234/g' /root/.cache/Cypress/6.1.0/Cypress/resources/app/packages/server/config/app.yml