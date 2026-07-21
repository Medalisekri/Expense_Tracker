# 💸 Expense Tracker

> A personal finance app built with Flutter and Firebase. Track daily expenses, organize by category, and manage spending in real time — with a clean glassmorphism UI.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Riverpod](https://img.shields.io/badge/Riverpod-00BCD4?style=for-the-badge&logo=flutter&logoColor=white)

---

## Screenshots


| Login | Home | Add Expense |
|---|---|---|
| *<img width="200" height="400" alt="Screenshot (389)" src="https://github.com/user-attachments/assets/dfa3c624-ecca-46c6-ba4e-5a24b19905dc" />* | *<img width="200" height="400" alt="Screenshot (390)" src="https://github.com/user-attachments/assets/cab73bee-3920-4af9-8c44-fcbafa4e4a29" />*| *<img width="200" height="400" alt="Screenshot (388)" src="https://github.com/user-attachments/assets/e251da67-ece6-44ab-80f5-def0e08ac31b" />* |






---

## Features

| Feature | Description |
|---|---|
| Authentication | Email/password login, Google Sign-In, password reset |
| Add Expenses | Form with category, amount, date, and note |
| Edit and Delete | Tap any expense to edit, tap delete to remove |
| Real-time sync | Changes appear instantly without refresh |
| Category filter | Filter by Food, Transport, Shopping, Health, Other |
| Total summary | Running total calculated automatically |
| Per-user data | Each account sees only their own expenses |
| Inline validation | Field-level error messages, not just snackbars |
| Glassmorphism UI | Gradient backgrounds with frosted glass cards |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| Language | Dart |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| State Management | Riverpod (StateNotifier) |

---

## Architecture

The app follows a clean three-layer architecture — screens never touch Firebase directly.

```
lib/
├── models/
│   └── expense.dart                  # Data class with fromFirestore / toMap / copyWith
├── repositories/
│   └── expense_repository.dart       # All Firestore and Auth calls live here
├── providers/
│   └── expense_provider.dart         # Riverpod StateNotifier — central state
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   └── add_expenses_screen.dart
├── services/
│   └── auth_service.dart             # Google Sign-In logic
└── main.dart
```

The UI layer only calls `ref.read(expenseProvider.notifier).addExpense(...)` — it never imports Firestore directly. This separation makes the code easier to read, debug, and scale.

---

## Getting Started

**Prerequisites:** Flutter SDK, a Firebase project

**1. Clone the repo**
```bash
git clone https://github.com/yourusername/expense-tracker.git
cd expense-tracker
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Firebase setup**
- Create a project at [console.firebase.google.com](https://console.firebase.google.com)
- Enable **Email/Password** and **Google** authentication
- Create a **Firestore** database
- Run `flutterfire configure` to generate `firebase_options.dart`
- Add your **SHA-1 fingerprint** for Google Sign-In (Project Settings → Your app)

**4. Firestore security rules**
```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /expenses/{expenseId} {
      allow read, write: if request.auth != null
        && request.auth.uid == resource.data.userId;
    }
  }
}
```

**5. Run the app**
```bash
flutter run
```

---

## Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.x.x
  firebase_core: ^x.x.x
  firebase_auth: ^x.x.x
  cloud_firestore: ^x.x.x
  google_sign_in: ^6.x.x
```

Replace `x.x.x` with the actual versions in your `pubspec.yaml`

---

## What I Learned


- Firebase Auth flow — login, signup, Google Sign-In, password reset, session persistence
- Firestore real-time streams with per-user filtering using `.where()`
- Repository pattern — keeping all Firebase calls out of the UI layer
- Riverpod StateNotifier — centralized state, ref.watch vs ref.read
- Debugging Firestore queries — learned that missing `.listen()` kills the stream silently
- Glassmorphism UI — gradient backgrounds, glass cards, dark styled text fields

---

