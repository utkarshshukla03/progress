
# 🧠 Progress - Your Smart Habit Management App

**Progress** is a cross-platform Flutter application designed to help users build and sustain positive habits with insightful visualizations, note-taking, AI support, and smart reminders. It’s perfect for productivity enthusiasts who want to track their daily progress, document their journey, and get personalized assistance.

---

## 🚀 Features

### 📅 Habit Tracker with Heatmap
- Visualize your daily habit consistency using a **calendar heatmap**.
- Instantly identify streaks and missed days to boost motivation.

### 📝 Smart Note-Taking
- Jot down quick notes, daily reflections, or task briefs.
- Organize your thoughts alongside your habit logs.

### 🤖 AI Assistant (GPT-powered)
- Get AI-based support for:
  - Breaking down complex tasks.
  - Generating motivation or productivity tips.
  - Answering quick questions or helping plan routines.

### ⏰ Scheduled Notifications
- Never forget a task with customizable daily/weekly habit reminders.
- Local notification support with time and habit tagging.

---

## 🛠 Tech Stack

- **Flutter** – Cross-platform mobile development.
- **Provider** – State management (use what fits your setup).
- **Hive ** – Local database for storing habits and notes.
- **Flutter Local Notifications** – For setting scheduled reminders.
- **Gemini** – Powering the in-app AI assistant.

---

## 📸 Screenshots

> ![WhatsApp Image 2025-04-02 at 13 14 25_24bcda38](https://github.com/user-attachments/assets/afbd6be2-a816-4a58-ba8b-e95589e9e859)


---

## ⚙️ Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/utkarshshukla03/progress
   cd progress
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

---

## 🔐 API Key Configuration (For AI Assistant)

1. Create a `.env` file in the root directory:
   ```
   OPENAI_API_KEY=your_openai_key_here
   ```

2. Ensure you use `flutter_dotenv` or a similar package to securely load the key:
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';

   await dotenv.load(fileName: ".env");
   final apiKey = dotenv.env['OPENAI_API_KEY'];
   ```

---

## 📦 Upcoming Features

- 🏆 Streak-based reward system  
- ☁️ Cloud sync and account login  
- 🌙 Dark mode  
- 👥 Habit sharing and challenge friends  

---

## 🤝 Contributing

Pull requests are welcome!  
For major changes, please open an issue first to discuss what you would like to change.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙌 Acknowledgments

- Flutter Dev Community
- Google Gemini
- Calendar Heatmap Flutter packages
- Notification scheduling plugins

---
