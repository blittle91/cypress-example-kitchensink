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
WORKDIR ../../../root/.cache/Cypress/6.0.1/Cypress/resources/app/packages/server/config/

RUN sed -i 's|https://api.cypress.io/|http://sorry-cypress-demo-1462500339.us-east-2.elb.amazonaws.com:8080|g' app.yml