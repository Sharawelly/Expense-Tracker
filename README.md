# 📊 Flutter Expense Tracker App

## 🌟 Overview
This **Flutter Expense Tracker App** is a fully functional and responsive expense management application. It allows users to **track expenses, categorize them, visualize spending trends**, and **delete expenses with an undo option**. The app is optimized for both **light and dark mode**, supports **adaptive layouts**, and offers a smooth **user experience** with intuitive UI elements.

## 🚀 Features
- **Expense Management**: Add, categorize, and delete expenses.
- **Data Persistence**: Stores expense data dynamically.
- **Dynamic Chart Visualization**: Displays categorized expenses in a bar chart.
- **Swipe-to-Delete with Undo**: Users can remove expenses and undo the action.
- **Adaptive UI**: Supports **portrait & landscape modes** using `MediaQuery` and `LayoutBuilder`.
- **Dark Mode Support**: Detects system theme and adjusts UI accordingly.
- **Validation & Error Handling**: Ensures valid input and provides user feedback.
- **Modal Bottom Sheet**: A smooth UI for adding new expenses.
- **Optimized List Rendering**: Uses `ListView.builder()` for performance efficiency.

## 📸 Screenshots
(Include relevant screenshots of the app UI here)

## 🛠️ Tech Stack
- **Flutter** (Dart)
- **Material UI & Cupertino UI** (for adaptive design)
- **Intl Package** (Date Formatting)
- **UUID Package** (Generating unique expense IDs)

## 📂 Folder Structure
```
/lib
│── models/                 # Expense Data Model
│── widgets/                # UI Components
│    ├── chart/             # Expense Chart & Bar
│    ├── expenses_list/     # Expense List & Items
│    ├── new_expense.dart   # Add Expense Modal
│── main.dart               # App Entry Point
```

## ⚡ How to Run
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/flutter-expense-tracker.git
   cd flutter-expense-tracker
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the App**:
   ```bash
   flutter run
   ```

## 📌 Future Enhancements
- **Persistent Storage** using SQLite or Firebase.
- **Multi-Currency Support**.
- **Custom Expense Reports**.
- **Authentication for User Profiles**.

## 🎉 Contributing
Contributions are welcome! Feel free to fork the repo, open an issue, or submit a pull request.

## 📄 License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---
💡 **Developed with Flutter ❤️**

