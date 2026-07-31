# Database Design — Entity Relationship Diagram

Based on the actual EF Core entities in `backend/Aoun.DAL/Entities`.

```mermaid
erDiagram
    APPLICATION_USER ||--o| DONOR_PROFILE : has
    APPLICATION_USER ||--o| CHARITY_PROFILE : has
    APPLICATION_USER ||--o{ TRUST_SCORE : has
    APPLICATION_USER ||--o{ NOTIFICATION : receives
    APPLICATION_USER ||--o{ FAVORITE : creates
    APPLICATION_USER ||--o{ DONATION : makes

    CHARITY_PROFILE ||--o{ CHARITY_DOCUMENT : uploads
    CHARITY_PROFILE ||--|| CHARITY : manages
    CHARITY ||--o{ CAMPAIGN : publishes
    CHARITY ||--o{ CASE : publishes

    CATEGORY ||--o{ CAMPAIGN : classifies
    CATEGORY ||--o{ CASE : classifies

    CAMPAIGN ||--o{ DONATION : receives
    CASE ||--o{ DONATION : receives
    CASE ||--o{ REPORT : flagged_by

    DONATION ||--o| ZAKAT : "may be"

    FAVORITE }o--|| CAMPAIGN : references
    FAVORITE }o--|| CASE : references

    APPLICATION_USER {
        string Id PK
        string Email
        string PasswordHash
        string Role
    }
    DONOR_PROFILE {
        int Id PK
        string UserId FK
        string FullName
    }
    CHARITY_PROFILE {
        int Id PK
        string UserId FK
        string Status
    }
    CHARITY {
        int Id PK
        string Name
        string Description
        bool IsVerified
    }
    CAMPAIGN {
        int Id PK
        int CharityId FK
        int CategoryId FK
        string Title
        decimal GoalAmount
        decimal CollectedAmount
        string State
    }
    CASE {
        int Id PK
        int CharityId FK
        int CategoryId FK
        string Title
        decimal RequiredAmount
        decimal CollectedAmount
    }
    DONATION {
        int Id PK
        string DonorId FK
        int CampaignId FK
        int CaseId FK
        decimal Amount
        datetime CreatedAt
    }
    ZAKAT {
        int Id PK
        int DonationId FK
        decimal NisabValue
        decimal CalculatedAmount
    }
    CATEGORY {
        int Id PK
        string Name
    }
    FAVORITE {
        int Id PK
        string UserId FK
        int CampaignId FK
        int CaseId FK
    }
    NOTIFICATION {
        int Id PK
        string UserId FK
        string Message
        bool IsRead
    }
    TRUST_SCORE {
        int Id PK
        string UserId FK
        int Score
    }
    REPORT {
        int Id PK
        int CaseId FK
        string Reason
    }
    CHARITY_DOCUMENT {
        int Id PK
        int CharityProfileId FK
        string DocumentUrl
    }
```

> Note: field-level types are best-effort based on the entity classes; refer to `Aoun.DAL/Migrations` for the authoritative, generated schema.
