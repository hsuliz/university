# meat-in-bread

App where user can find out menu. Registered user can place an order and look for past orders.

#### Tools used:

API:

* Node.js
* Typescript
* React
* Express
* JWT
* MongoDB
* Mongoose

## Requirements

* _Node 18_
* _MongoDB_ with variables:
    ```
  port: 27017
  MONGO_INITDB_ROOT_USERNAME=meat
  MONGO_INITDB_ROOT_PASSWORD=meat
    ```

## Installation

1. Start local MongoDB. You can use docker-compose file:

    ```shell
     docker-compose up -d
    ```

2. Compiling.

- API:

  In  `/api` directory:
    - Download dependencies.
      ```shell
      npm install
      ```
    - Compile
      ```shell
      npm run build
      ```
    - Start
      ```shell
      npm run start
      ```


- Front:

  In  `/front` directory:
    - Download dependencies.
      ```shell
      npm install
      ```
    - Compile
      ```shell
      npm run build
      ```
    - Start
      ```shell
      npm run start
      ```

## Additional info

This application using environment variables to be more flexible. File `/api/.env` can be changed for your demands.