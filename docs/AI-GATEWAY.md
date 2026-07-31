# AI Gateway — Architecture & Features

Aoun's AI capabilities are served by a dedicated **Python FastAPI** microservice (the "AI Gateway"), kept separate from the core ASP.NET Core API so that AI/ML workloads can scale, deploy, and iterate independently.

## Deployment

- **Runtime:** FastAPI (Python)
- **Hosting:** Hugging Face Spaces
- **Consumers:** `Aoun.API` (via `AISmartService` / `AIController`) and, indirectly, the mobile app and admin panel.

## Core Language Model

- **Model:** Qwen2.5-7B-Instruct
- Used as the reasoning/generation engine behind all four AI features below.

## Multi-Provider Fallback Routing

To keep AI features resilient in production, the gateway routes requests across multiple providers with automatic fallback:

1. OpenAI
2. Gemini
3. Groq
4. DeepSeek

If a provider errors out, times out, or is rate-limited, the gateway transparently retries the next provider in the chain — the caller (the .NET backend) never has to know which provider ultimately served the request.

## The Four AI Features

### 1. RAG-Based Donor Chatbot
A retrieval-augmented-generation chatbot that answers donor questions and helps them discover causes to support, grounded in real platform data (campaigns, cases, charity info) rather than hallucinated answers.

### 2. Recommendation Engine (Hybrid ML + LLM)
- **ML layer:** A **Collaborative Filtering** model based on **Cosine Similarity** over a User–Item interaction matrix (built with Scikit-Learn, serialized as a `.pkl`). Each donor is represented as a vector derived from their donation/interaction history; the model finds the nearest "behavioral neighborhood" of similar donors to identify relevant charity categories.
- **LLM layer:** The statistical model's predictions are passed as contextual guidance to the language model, which then selects and explains the most appropriate live campaigns/cases from current backend data — combining ML accuracy with LLM flexibility.

### 3. Admin Financial Assistant
An LLM-backed assistant exposed to platform admins that can answer natural-language questions about platform financial data (donations, campaign performance, etc.) via the `AdminController` / `CharityDashboardController` data.

### 4. Arabic Marketing Content Generator
Generates Arabic marketing copy (in Modern Standard Arabic) for charities to use in campaign descriptions and outreach, following right-to-left formatting conventions native to the platform's Arabic-first design.

## Request Flow

```
Mobile App / Admin Panel
        │
        ▼
  Aoun.API (ASP.NET Core)
        │  AIController → AISmartService
        ▼
  AI Gateway (FastAPI, Hugging Face Spaces)
        │
        ├── Provider router (OpenAI → Gemini → Groq → DeepSeek)
        ├── Qwen2.5-7B-Instruct (generation/reasoning)
        └── Scikit-Learn recommendation model (.pkl)
```

## Configuration

API keys for each provider are read from configuration (`ApiKeys` section in `appsettings.json` / environment variables) and are **never committed to source control**. See the root [README](../README.md) for local setup instructions.
