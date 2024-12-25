# Multi-language Development Environment with Jupyter Notebook

## Overview

This project provides a development environment where multiple programming languages (Python, JavaScript, TypeScript, Ruby, Go) can be executed in a single Jupyter Notebook environment. AI/LLM related SDKs are included, allowing you to immediately start experimenting with machine learning and natural language processing.

## Supported Languages and Kernels

- Python 3 (ipykernel)
- JavaScript (Node.js)
- TypeScript (tslab)
- Ruby (iruby)
- Go (gophernotes)
- Bash

## Main Features

- Jupyter Notebook kernels for each language
- Pre-installed AI/LLM SDKs including OpenAI and Anthropic

## Requirements

- Docker
- Docker Compose

## Setup

1. Environment Variable Configuration:
   Create a `.env` file and set the following environment variables:
   ```
   OPENAI_API_KEY=your_openai_api_key
   GOOGLE_MAP_API_KEY=your_google_map_api_key
   ```

2. Google Cloud Authentication Setup:
   Place `google-credentials.json` in the project root.

3. Launch Environment:
   ```bash
   docker-compose up --build
   ```

4. Browser Access:
   Access `http://localhost:8888` to start Jupyter Notebook

## Project Structure

```
.
├── docker/
│ └── Dockerfile
├── notebooks/
│ ├── python.ipynb
│ ├── javascript.ipynb
│ ├── typescript.ipynb
│ ├── ruby.ipynb
│ └── go.ipynb
├── docker-compose.yml
├── requirements.txt
├── package.json
└── Gemfile
```

## Main Installed Packages

### Python
- pandas
- numpy
- matplotlib
- scikit-learn
- openai
- anthropic

### Node.js
- openai
- @anthropic-ai/sdk

### Ruby
- ruby-openai
- anthropic

## Security Notes

- Properly manage environment variables and Google credentials
- Containers are run with no-new-privileges option
- Sensitive information is managed by `.gitignore`
