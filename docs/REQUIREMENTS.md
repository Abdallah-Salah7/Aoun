# Requirements Gathering Document

Gathered Oct 8th, 2025. Source: team requirements workshop. 49 requirements covering Donor, Charity/Organization, and Admin stakeholders.

## Account & Auth
1. Allow user registration for both donors and charity (Functional)
2. Enable login using Email, Google, or Facebook (Functional)
3. Verify user email using verification link (Functional)
4. Allow users to edit profile details (Functional)
5. Save history of previous donations for each user (Functional)

## Charity Onboarding & Verification
6. Allow organizations to register using official information (Functional)
7. Allow organizations to upload official verification documents (Functional)
8. Verify charitable organizations before case submission — document upload, AI OCR, admin review, verification badge (Functional)
9. Allow admin to review and approve organizations manually (Functional)

## Charity / Organization Features
10. Allow organizations to create humanitarian cases (images, information, target amount) (Functional)
11. Provide a dedicated dashboard for each organization (Functional)
12. Allow organizations to view total donations received (financial summary cards, charts) (Functional)
13. Provide AI assistance for organizations (case-writing support) (Functional)
14. Detect duplicate cases (duplicate content analysis) (Functional)
15. Allow organizations to respond to donor inquiries (messaging system) (Functional)
16. Allow organizations to edit and update existing cases (Functional)
17. Allow organizations to view donor feedback and ratings (Functional)
18. Allow organizations to receive notifications about new donations (Functional)

## Donor Home & Discovery
19. Allow donors to browse the home page after login (Functional)
20. Display highlighted urgent and critical cases on the home page (Functional)
21. Provide AI-based case recommendations — personalized suggestions, low-funded cases (Functional)
22. Support emergency wallet donations (Functional)
23. Support large institution donations (e.g. 57357, Bahya) (Functional)
24. Support relief campaigns (e.g. Gaza, Sudan) (Functional)
25. Support construction campaigns (mosques, schools, hospitals, wells) (Functional)
26. Allow donors to navigate to a specific category (Functional)
27. Support categories such as patients, poor, orphans, and emergencies (Functional)
28. Allow donors to search for cases by keyword (Functional)
29. Allow donors to filter cases by urgency level (Urgent / Critical / Normal) (Functional)
30. Display cases with full details to donors (images, description, progress bar, donor count) (Functional)
31. Allow donors to donate directly to cases (quick-donate button, payment flow) (Functional)
32. Allow donors to save favorite cases (Functional)
33. Send notifications to donors about updates in followed cases (Functional)
34. Allow donors to share cases (social sharing) (Functional)
35. Provide an AI chatbot for donors (FAQs, donation help) (Functional)

## Zakat Calculator
36. Provide a dedicated Zakat Calculator page for donors (Functional)
37. Allow donors to choose the type of Zakat to calculate (Money, Gold, Silver, Fitr) (Functional)
38. Calculate Zakat on silver or gold based on entered amount (2.5% nisab logic) (Functional)
39. Calculate Zakat Al-Fitr based on number of family members (Functional)
40. Calculate Zakat Al-Mal based on entered cash and savings (Functional)
41. Allow donors to donate calculated Zakat directly (Functional)
42. Save Zakat calculation history for donors (Functional)
43. Ensure Zakat calculations follow correct Islamic rules — verified calculation formulas (Non-Functional)

## AI Chatbot
44. Provide an AI chatbot that guides donors on how to donate and helps them find suitable cases — step-by-step guidance, category/case recommendations, highlighting urgent cases, direct navigation (Functional)
45. Allow donors to interact with the chatbot — case explanation, Zakat guidance, FAQ support, Arabic & English responses (Functional)

## Non-Functional
46. Ensure system scalability — scalable backend architecture
47. Ensure high availability — 24/7 uptime support
48. Ensure fast system response time — optimized performance
49. Ensure a user-friendly interface — simple navigation, accessibility
