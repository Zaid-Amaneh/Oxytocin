# Oxytocin - Medical Clinic Management App

An advanced mobile application built with Flutter, designed to digitize the healthcare sector in Damascus. This project provides an integrated technical solution that connects patients with doctors, simplifying the process of finding clinics, booking appointments, and managing medical records efficiently and securely.

## 🌟 Overview

Oxytocin addresses the challenges facing the traditional healthcare sector in Damascus, where reliance on paper records and phone calls leads to numerous issues like data loss, inefficient appointment scheduling, and difficulty in accessing the right clinic. The application introduces a modern digital platform aimed at improving the quality of health services and simplifying access through a user-friendly mobile app and a powerful web-based control panel.

## 🎥 Demo & Screenshots

You can view the UI/UX design and an interactive prototype of the project on Behance

👉 [Watch here](https://www.behance.net/gallery/234136599/Medical-Appointment-Booking-App-Mobile-UIUX-Design)

## 🎨 Screenshots

Here are some highlights of the Oxytocin app’s UI/UX and interactions:

<table>
<tr>
<td align="center">
**Login Screen**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/login.png" alt="Login Screen" width="250"/>
</td>
<td align="center">
**Register Screen**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/register.png" alt="Register Screen" width="250"/>
</td>
<td align="center">
**Home Page**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/homePage.png" alt="Home Page" width="250"/>
</td>
</tr>
<tr>
<td align="center">
**Queue Screen 1**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/queue1.png" alt="Queue Screen 1" width="250"/>
</td>
<td align="center">
**Queue Screen 2**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/queue2.png" alt="Queue Screen 2" width="250"/>
</td>
<td align="center">
**Doctor Profile**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/doctorProfile.png" alt="Doctor Profile" width="250"/>
</td>
</tr>
<tr>
<td align="center">
**Google Maps Interaction**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/googleMapsInteraction.png" alt="Google Maps Interaction" width="250"/>
</td>
<td align="center">
**Appointment Booked**<br>
<img src="https://github.com/Zaid-Amaneh/Oxytocin/blob/main/screenshots/appointmentBooked.png" alt="Appointment Booked" width="250"/>
</td>
<td></td>
</tr>
</table>


## 🚀 Flutter Features & Architectural Patterns

*A detailed overview of the key features, design patterns, and technologies implemented in the Oxytocin app using Flutter.*

| Feature / Concept | Description |
| --- | --- |
| **State Management (Bloc)** | Manages the app’s state efficiently, separating business logic from UI for better scalability and maintainability. |
| **Navigation (GoRoute)** | Handles routing and navigation between screens in a structured way, supporting deep linking and nested routes. |
| **Google Maps Integration** | Displays interactive maps, allows plotting routes, showing clinic locations, and improving the user experience. |
| **Secure Token Storage** | Uses **Secure Storage** to safely store authentication tokens and sensitive user data on the device. |
| **Clean Architecture** | Organizes the project into layers (presentation, domain, data) to make the code more maintainable, testable, and scalable. |
| **MVVM Pattern** | Implements the Model-View-ViewModel pattern for a clear separation of UI and business logic, enhancing code readability. |
| **API Integration** | Connects the Flutter app to backend REST APIs to fetch and update data like doctors, appointments, and medical records. |
| **Push Notifications (FCM)** | Sends real-time notifications for appointments, updates, and reminders directly to the user. |
| **Local Storage (Shared Preferences / SQLite)** | Stores user settings, cached data, or offline information locally on the device. |
| **Responsive UI / Adaptive Design** | Ensures the app works smoothly on different screen sizes and orientations. |
| **Form Validation** | Provides input validation and error handling for forms like booking appointments or creating patient records. |
| **Error Handling & Loading States** | Implements consistent error handling and loading indicators for a better user experience. |

## 💣 Technology Stack

The project utilizes a modern technology stack to ensure scalability, security, and a seamless user experience.

| Category | Technology | Description |
| --- | --- | --- |
| **Backend** | Django (Python) | A high-level Python web framework used for the core application logic. |
| **Mobile App** | Flutter | A UI toolkit by Google for building natively compiled applications for mobile from a single codebase. |
| **Web Frontend** | React | A JavaScript library for building user interfaces, used for the web dashboard. |
| **Database** | PostgreSQL + PostGIS | The primary database for the system. PostGIS provides support for geographic objects. |
| **UI/UX Design** | Figma | A collaborative design tool used for creating the user interface and user experience prototypes. |
| **Authentication** | JWT (JSON Web Tokens) | Used for securely transmitting information between parties as a JSON object to authenticate sessions. |

## 👨‍💻 Author

- **Zaid Amaneh** – Flutter Developer & UI/UX Designer
- 💼 [LinkedIn](https://www.linkedin.com/in/zaidamaneh/?locale=en_US)
- 🐙 [GitHub](https://github.com/zaid-amaneh)
- 🎨 [Behance](https://www.behance.net/zaidamaneh)

## 📄 License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

