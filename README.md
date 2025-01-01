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
- Pre-installed AI/LLM SDKs including OpenAI, Anthropic, and Google's Generative AI

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
   Place your Google Cloud credentials file as `credentials/google-credentials.json`.

3. Launch Environment:
   ```bash
   docker-compose up --build
   ```

4. Browser Access:
   Access `http://localhost:8888` to start Jupyter Notebook

## Project Structure

```
.
├── .devcontainer/          # Dev Container configuration
├── .github/                # GitHub related configurations
├── credentials/            # Credential files (gitignored)
├── notebooks/             # Jupyter notebooks directory (contents gitignored)
├── docker/                # Docker related files
├── Dockerfile             # Main Dockerfile
├── docker-compose.yml     # Docker Compose configuration
├── requirements.txt       # Python dependencies
├── package.json          # Node.js dependencies
└── Gemfile               # Ruby dependencies
```

## Version Management

The project includes version management files for each language:
- `.python-version` - Python version
- `.node-version` - Node.js version
- `.ruby-version` - Ruby version
- `.go-version` - Go version

## Main Installed Packages

### Python
- pandas
- numpy
- matplotlib
- scikit-learn
- openai (v1.12.0+)
- anthropic (v0.18.1+)
- google-generativeai (v0.1.0+)

### Node.js
- openai
- @anthropic-ai/sdk

### Ruby
- ruby-openai
- anthropic

### Go
- github.com/sashabaranov/go-openai v1.36.1
- github.com/anthropics/anthropic-sdk-go v0.2.0-alpha.8
- github.com/google/generative-ai-go v0.19.0
- github.com/tidwall/gjson v1.14.4
- github.com/tidwall/sjson v1.2.5

## Security Notes

- Properly manage environment variables and Google credentials
- All sensitive files are properly managed by `.gitignore`
- Notebooks directory is included in git repository but its contents are ignored
- Containers are run with security considerations
