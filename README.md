# CareConnect-Team10
CareConnect App

Project Description
CareConnect is an accessible health and daily self-management application designed specifically for individuals living with moderate Rheumatoid Arthritis (RA) and Osteoarthritis (OA). The application helps users record pain and stiffness levels, track medications, manage appointments, document symptoms, and follow simple wellness or mobility routines without requiring difficult or repetitive touch interactions. Because arthritis can make traditional mobile interfaces uncomfortable or frustrating to use, CareConnect emphasizes large touch targets, low-effort single-tap interactions, voice input, minimal typing, and controls positioned within easy reach. The goal of the application is to help users independently manage common daily health-related activities while reducing the physical effort required to interact with technology.

Team Members:

Zack Bristor
Donald Keita
Sahil Kapoor
Team charter link: https://docs.google.com/document/d/1eyGg-CO_upiG2UkL0_sVFP8KAMmAMK9OKNGDByqwgxY/edit?tab=t.0

Instructions:

How to Run the App

Install Flutter and the required development tools.
Clone the repository.
Navigate to the mobile folder.
Run flutter pub get.
Run flutter run to start the application.
For Chrome testing, run flutter run -d chrome.
How to Run Tests

Navigate to the mobile folder.
Run flutter test.
Run flutter test --coverage to generate the coverage report.
Generate the HTML coverage report using genhtml coverage/lcov.info -o coverage/html.
Test Coverage Report

Coverage report location: mobile/coverage/html/index.html
Assignment goal: 60% or greater test coverage.
Final coverage percentage and screenshot will be added after testing is complete.
Known Issues / Limitations

The application is currently an academic prototype.
Some features and screens are still under development.
Sample/mock health and medication data is currently used.
Newly added medications are currently stored in memory and may reset when the application restarts.
Persistent storage and additional backend integration are still under development.
Additional accessibility and device testing may still be required.

AI Usage Summary

AI was used to help update the Add Medication and Medications screens.
AI assisted with debugging Flutter.
AI provided suggestions for navigation, accessibility, responsive layout, and code organization.
AI assisted with test planning and documentation.
All AI-generated code and recommendations were reviewed and tested before being added to the project.
**Project Description** <br> 
CareConnect is an accessible health and daily self-management application designed specifically for individuals living with moderate Rheumatoid Arthritis (RA) and Osteoarthritis (OA). The application helps users record pain and stiffness levels, track medications, manage appointments, document symptoms, and follow simple wellness or mobility routines without requiring difficult or repetitive touch interactions. Because arthritis can make traditional mobile interfaces uncomfortable or frustrating to use, CareConnect emphasizes large touch targets, low-effort single-tap interactions, voice input, minimal typing, and controls positioned within easy reach. The goal of the application is to help users independently manage common daily health-related activities while reducing the physical effort required to interact with technology.

**Team Members:** <br> 
* Zack Bristor <br>
* Donald Keita <br>
* Sahil Kapoor <br>

Team charter link: https://docs.google.com/document/d/1eyGg-CO_upiG2UkL0_sVFP8KAMmAMK9OKNGDByqwgxY/edit?tab=t.0

**Instructions:** <br>

**How to Run the App**
* Install Flutter and the required development tools.
* Clone the repository.
* Navigate to the `mobile` folder.
* Run `flutter pub get`.
* Run `flutter run` to start the application.
* For Chrome testing, run `flutter run -d chrome`.

**How to Run Tests**
* Navigate to the `mobile` folder.
* Run `flutter test`.
* Run `flutter test --coverage` to generate the coverage report.
* Generate the HTML coverage report using `genhtml coverage/lcov.info -o coverage/html`.

**Test Coverage Report**
* Coverage report location: `mobile/coverage/html/index.html`
* Assignment goal: 60% or greater test coverage.
* Final coverage percentage and screenshot will be added after testing is complete.

**Known Issues / Limitations**
* The application is currently an academic prototype.
* Some features and screens are still under development.
* Sample/mock health and medication data is currently used.
* Newly added medications are currently stored in memory and may reset when the application restarts.
* Persistent storage and additional backend integration are still under development.
* Additional accessibility and device testing may still be required.

**Team Member Contributions This Week**

**Sahil Kapoor**
* Developed the Add Medication screen.
* Updated the Medications screen.
* Added medication form validation.
* Added medication name, dosage, frequency, and instructions fields.
* Updated navigation for the Add Medication workflow.
* Added accessibility improvements using Flutter Semantics.
* Added responsive layout improvements.
* Tested and debugged the medication workflow.
* Updated project documentation.

**Donald Keita**
* Designed and implemented the Inbox screen for CareConnect’s messaging module.
* Added support for displaying message previews, timestamps, read/unread indicators, and sender metadata.
* Developed the Send Message workflow, including message composition UI, subject/body fields, and validation rules.
* Implemented the Reply Message feature, including automatic population of sender, subject prefix (“Re:”), and quoted message context.
* Implemented data persistence with SQLite for all the functionalities.
* Wrote unit tests for the Inbox message service, including inbox, send messages, reply to message.
* Organized implementation of inbox, reply message, reply message separately in models, screens, services.
* Reviewed code quality and resolve conflicts from pull requests and merge them to main repository.

**Zack Bristor**
* Developed the Request Appointments screen.
* Updated the Appointments screen.
* Added validation on Request Appointments.
* Added accessibility improvements using Flutter Semantics.
* Added responsive layout improvements.
* Tested and debugged the Appointments workflow.
* Updated project documentation.

**AI Usage Summary**
* AI was used to help update the Add Medication and Medications screens.
* AI assisted with debugging Flutter.
* AI provided suggestions for navigation, accessibility, responsive layout, and code organization.
* AI assisted with test planning and documentation.
* All AI-generated code and recommendations were reviewed and tested before being added to the project.
