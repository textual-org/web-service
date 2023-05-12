# Textual: Work In Progress

## Setup

Install the required dependencies

```bash
npm install
```

## Running

Running in development mode with hot reloading on port 3001:

```bash
npm run dev
```

Running in production mode on port 3000:

```bash
uvicorn app:app --port 3000
```

## Terraform

At Textual, we use Terraform to manage our infrastructure. Terraform commands can be run just as other npm scripts:
Note: Don't forget to install Terraform CLI, add it to your PATH, and configure the .env file.

```bash
npm run tf:init
npm run tf:plan
```
