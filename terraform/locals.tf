locals {
    AWS_REGION = "eu-central-1"

    APPRUNNER_RUNTIME_ENVIRONMENT_VARIABLES = {
        "APP_NAME" = "web-service"
        "APP_PORT" = "3000"
    }
}

