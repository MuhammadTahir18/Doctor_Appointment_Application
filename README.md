# 🏥 Doctor Appointment App

A full-featured **Doctor Appointment Booking** Flutter application built for Pakistani users. Book appointments with nearby doctors, chat in real-time, and manage your health — all in one place.

---

## 📱 Screenshots

> Add your app screenshots here after running on Android
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/d8d6c47749ba03bf11ebfed607b91e6735a465fc/dsplash.PNG)
> ![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/dlogin.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/dsignup.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/d1.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/d2.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/d3.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/d4.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/d5.PNG)
![App Screenshot](https://github.com/MuhammadTahir18/Doctor_Appointment_Application/blob/b00e95f1c533410c5ee7a3c1c916781e769f48bb/d7.PNG)
---

## ✨ Features

- 🔐 **Authentication** — Email/Password login & registration via Firebase Auth
- 🏠 **Home Screen** — Browse doctors with search & specialty filter
- 👨‍⚕️ **Doctor Profiles** — Detailed info with rating, experience, fee & location
- 📅 **Appointment Booking** — Select date & time slot and confirm booking
- 📋 **My Appointments** — View upcoming & past appointments, cancel if needed
- 💬 **Real-time Chat** — Chat with doctors via Firebase Realtime Database
- 🔔 **Push Notifications** — Appointment reminders via Firebase Cloud Messaging
- 👤 **Profile Screen** — View account info, change password, manage settings
- 🛡️ **Admin Panel** — Add/delete doctors (admin role only)
- 🌙 **Splash Screen** — Animated splash with auto auth check

---

## 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| **Flutter** | Cross-platform mobile framework |
| **Dart** | Programming language |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | Database for doctors, appointments, users |
| **Firebase Realtime Database** | Real-time chat messaging |
| **Firebase Cloud Messaging** | Push notifications |
| **flutter_bloc / Cubit** | State management |
| **BLoC Pattern** | Clean architecture state handling |
| **Clean Architecture** | Separation of data, domain, presentation layers |

---

## 🏗️ Architecture

This project follows **Clean Architecture** with **BLoC/Cubit** state management:

```
lib/
├── core/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/          # Models, repositories
│   │   │   └── presentation/  # Screens, Cubit, States
│   │   ├── doctors/
│   │   │   ├── data/          # DoctorModel, DoctorRepository
│   │   │   └── presentation/  # HomeScreen, DoctorCubit
│   │   ├── appointments/
│   │   │   ├── data/          # AppointmentModel, Repository
│   │   │   └── presentation/  # BookingScreen, AppointmentCubit
│   │   ├── chat/
│   │   │   ├── data/          # MessageModel, ChatRepository
│   │   │   └── presentation/  # ChatScreen, ChatCubit
│   │   ├── profile/
│   │   │   └── presentation/  # ProfileScreen
│   │   ├── admin/
│   │   │   └── presentation/  # AdminScreen
│   │   └── splash/
│   │       └── presentation/  # SplashScreen
│   └── main_screen.dart       # Bottom Navigation
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Firebase account
- Android Studio / VS Code

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/doctor-appointment-app.git
cd doctor-appointment-app
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Firebase Setup**
- Create a new Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
- Enable **Authentication** (Email/Password)
- Create **Firestore Database** (test mode)
- Create **Realtime Database**
- Run FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

**4. Run the app**
```bash
flutter run
```

---

## 🔥 Firebase Collections

### `doctors`
```
name, specialty, rating, experience, fee,
address, lat, lng, about, image, isAvailable
```

### `users`
```
name, email, role (patient/admin), createdAt
```

### `appointments`
```
doctorId, doctorName, patientId, date,
time, status (pending/confirmed/cancelled), fee
```

### `chats/{roomId}/messages`
```
senderId, message, timestamp
```

---

## 📦 Dependencies

```yaml
firebase_core: ^2.27.0
cloud_firestore: ^4.15.0
firebase_auth: ^4.17.0
firebase_database: ^10.4.9
firebase_messaging: ^14.7.19
flutter_bloc: ^8.1.4
bloc: ^8.1.4
go_router: ^13.2.0
cached_network_image: ^3.3.1
shared_preferences: ^2.2.2
flutter_secure_storage: ^9.0.0
intl: ^0.19.0
```

---

## 👨‍💻 Developer

**Muhammad Tahir**
- 🎓 BS Information Technology
- 💼 Flutter Developer
- 📍 Lahore, Pakistan
- 🔗 [GitHub](https://github.com/YOUR_USERNAME)
- 📧 your.email@gmail.com

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first.

---

> Built with ❤️ using Flutter & Firebase
