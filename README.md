STIEBEL ELTRON VIET NAM PROJECT (QUOC BAO SOFTWARE) 2024
Overview
The Stiebel Eltron Viet Nam Project is a mobile application developed for the Stiebel Eltron brand, a company specializing in providing services related to warranty and customer support for their products. This application enables users to interact with the brand, allowing them to register products, track warranty status, and access customer support easily through their mobile devices.

Features
Mobile Application: Built using Flutter, providing a cross-platform solution for both Android and iOS users.
Warranty and Customer Support: The app helps users manage warranties and provides seamless access to customer support for Stiebel Eltron products.
State Management: Utilizes BloC (Business Logic Component) for efficient state management and to separate the business logic from the UI.
Multi-Language Support: Integrated GetX Localization for managing multiple languages, ensuring a user-friendly experience for customers in various regions.
API Integration: Leverages Dio to handle API calls, making HTTP requests, interacting with JSON data, and managing errors effectively.
Technologies Used
Flutter: For building the mobile application across iOS and Android platforms.
BloC: To manage state and handle the application's business logic.
GetX Localization: For easy multi-language support and localization in the app.
Dio: A powerful HTTP client library used for API calls, error handling, and data management.
Key Functionalities
Product Registration: Users can register their Stiebel Eltron products through the app, ensuring their products are covered under warranty.
Warranty Tracking: Track and manage the warranty status of registered products.
Customer Support: Direct access to customer support for product inquiries or issues.
API Integration: The app communicates with backend services through APIs to fetch and update warranty information and handle user requests.
Installation

To set up the project locally, follow these steps:
Clone the repository:
git clone https://github.com/yourusername/stiebel-eltron-vietnam.git
Install dependencies: Navigate to the project directory and install the required dependencies:
cd stiebel-eltron-vietnam
flutter pub get
Run the application: To run the application on your preferred platform (Android/iOS):
bash
Sao chép mã
flutter run
Project Structure
The project is structured as follows:
lib/
│
├── blocs/                 # Contains BloC logic
├── models/                # Data models
├── services/              # API services (using Dio)
├── localization/          # GetX localization files for multi-language support
├── screens/               # UI screens for the application
└── widgets/               # Reusable widgets
Contributions
Contributions are welcome! Please follow the steps below:
Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Commit your changes (git commit -m 'Add some feature').
Push to the branch (git push origin feature/your-feature).
Open a pull request.
Contact
For any questions or support, please reach out to:

Project Lead: Nguyen Huu Nghia
Email: nghiamc147@gmail.com
