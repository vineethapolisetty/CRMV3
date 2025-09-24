# CRMV3
CRM Application Final Version 3
A simple Customer Relationship Management (CRM) application built using ColdFusion and MySQL.
This project was developed as a practice project to understand CRUD operations, AJAX integration, and session handling in a real-world style application.

Features
User authentication (Login / Logout)
Add new customer details
Edit and update customer records
Delete customer records
Real-time search functionality using AJAX
Organized project structure with CFC components
Technologies Used
Backend: ColdFusion 2023 (CFML)
Frontend: HTML, CSS, JavaScript, jQuery (AJAX)
Database: MySQL
Features in This Version
Implemented password validation with special characters
Added password recovery via email OTP reset
Fixed folder path issue in URL display
Introduced index.cfm as main entry point
Added router.cfm to include all cfm files
Added controller.cfc to manage functions
Completed development of all department modules
Refactored code: moved inline JS & CSS to separate files
Implemented jQuery pagination (single record per request, hide/show pages)
Set downloads to open in a new page
Created structured folders for each page like headers, footers, HTML, CSS separated
Added local logging with cflog
Configured data source in onapplicationstart
Implemented session management on all pages
