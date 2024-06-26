# Build MegaService of FinanceAssistant on Gaudi

This document outlines the deployment process for a FinanceAssistant application utilizing the [GenAIComps](https://github.com/opea-project/GenAIComps.git) microservice pipeline on Intel Gaudi server. The steps include Docker image creation, container deployment via Docker Compose, and service execution to integrate microservices such as embedding, retriever, rerank, and llm. We will publish the Docker images to Docker Hub, it will simplify the deployment process for this service.

### 1. Build Agent Image

```bash
git clone https://github.com/opea-project/GenAIComps.git
cd GenAIComps
docker build -t opea/comps-agent-langchain:latest --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy -f comps/agent/langchain/docker/Dockerfile .
```

### 2. Start all the services Docker Containers

```bash
export HUGGINGFACEHUB_API_TOKEN="xxx"
export SERPAPI_API_KEY="xxx"
cd GenAIExamples/DocWriterAssistant/docker/gaudi/
docker compose -f docker-compose.yaml up -d
```

### 3. Validation

```bash
curl http://127.0.0.1:9090/v1/chat/completions -H "Content-Type: application/json" -d '{
     "query": "What date is today and what is the weather today in Austin?"
     }'
data: "Today's date is 7/11/2024 and the weather in Austin is hot with a chance of thunderstorms in the afternoon.</s>"

data: [DONE]
```

```bash
curl http://127.0.0.1:9090/v1/chat/completions -H "Content-Type: application/json" -d '{
     "query": "What is the stock price for Intel today?"
     }'
data: 'The current stock price for Intel is 40,000.9 (US).</s>'

data: [DONE]

```