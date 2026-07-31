# 🤝 Aoun - Smart Charity & Donation Platform

**Aoun** is a comprehensive Content Management System (CMS) and smart donation platform engineered to connect donors seamlessly with verified charities. It features advanced AI-assisted content generation, resilient cloud architectures, and secure payment tracking.

## 🚀 Key Features

* **Multi-Role CMS Architecture:** Dedicated, secure dashboards for **Admins**, **Charities**, and **Donors**. Allows organizations to register, upload legal verification documents, and manage fundraising cases through a strict approval workflow.
* **Robust Security & Authentication:** Implemented a highly secure Role-Based Access Control (RBAC) system utilizing ASP.NET Core Identity and JWT, ensuring strict data isolation across different user roles and providing customized endpoints for document verification.
* **Seamless Payment Integration:** Integrated with the **Paymob** payment gateway to securely process Zakat and case-specific donations. Includes resilient backend webhooks that handle payment callbacks, automatically updating donor profiles and real-time platform administrative statistics.
* **Resilient AI Smart Routing:** Engineered a highly available AI service to generate marketing descriptions for charity cases and power interactive chatbots. 
    * *Highlight:* Implemented a **Custom Fallback Routing Mechanism** that intelligently switches between multiple Generative AI providers (**Groq, OpenAI, DeepSeek, Gemini**) to guarantee **zero downtime** in the event of API key failures or rate limits.
* **Automated Business Logic:** Automated workflows for charity profile approvals, email notifications, and dynamic statistics generation for the admin dashboard.

## 🛠️ Tech Stack

* **Backend Framework:** C#, ASP.NET Core 8 Web API
* **Database & ORM:** SQL Server, Entity Framework Core (Code-First approach)
* **Security:** ASP.NET Identity, JWT (JSON Web Tokens)
* **3rd Party Integrations:** Paymob API (Payment Gateway)
* **AI Integration:** Multiple LLM APIs (OpenAI, Gemini, Groq, DeepSeek)

## 🗄️ Database Architecture
Designed and optimized complex relational database schemas to efficiently and securely handle users, distinct charity profiles, fundraising cases, and detailed donation histories.

## 👨‍💻 Developed By
**Abdallah Salah** - *Technical Team Leader & Backend Developer*
* [LinkedIn](https://linkedin.com/in/abdallah-salah-)
* [GitHub](https://github.com/Abdallah-Salah7)
