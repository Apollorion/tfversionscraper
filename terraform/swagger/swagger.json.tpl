{
  "swagger": "2.0",
  "info": {
    "description": "This is an API to get specific versions of terraform",
    "version": "1.0.0",
    "title": "Terraform Version API",
    "contact": {
      "email": "joey@apollorion.com"
    },
    "license": {
      "name": "MIT",
      "url": "https://opensource.org/licenses/MIT"
    }
  },
  "host": "${host}",
  "basePath": "/",
  "tags": [
    {
      "name": "terraform",
      "description": "Terraform Versions"
    }
  ],
  "schemes": [
    "${schema}"
  ],
  "paths": {
    "/all": {
      "get": {
        "tags": [
          "terraform"
        ],
        "summary": "Get all versions of terraform",
        "description": "Gets all versions of terraform",
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "Good request"
          }
        }
      }
    },
    "/latest": {
      "get": {
        "tags": [
          "terraform"
        ],
        "summary": "Get the latest version of terraform",
        "description": "Get the latest version of terraform",
        "produces": [
          "application/json"
        ],
        "responses": {
          "200": {
            "description": "Good request"
          }
        }
      }
    },
    "/{version}": {
      "get": {
        "tags": [
          "terraform"
        ],
        "summary": "Get a specific version of terraform",
        "description": "Gets a specific version of terraform",
        "produces": [
          "application/json"
        ],
        "parameters": [
          {
            "in": "path",
            "name": "version",
            "required": true,
            "type": "string",
            "description": "Version of terraform you wish to get."
          }
        ],
        "responses": {
          "200": {
            "description": "Good request"
          },
          "404": {
            "description": "Version not found"
          }
        }
      }
    }
  }
}