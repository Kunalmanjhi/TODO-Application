# ✅ Todo App — Flutter

A beautifully designed, fully functional **Todo / Task Manager** app built with Flutter. Features local persistence with Hive, reactive state management via GetX, dark/light theme support, and smooth swipe-to-action task cards.

---

## 📱 Screenshots

> Add your screenshots here once the app is running.

---

## ✨ Features

- 📋 **Add, Edit & Delete Tasks** — Full CRUD with a clean bottom sheet UI
- 📅 **Due Date Picker** — Assign dates to tasks with a native date picker
- 🗂️ **Smart Categorization** — Tasks auto-sort into **Yesterday**, **Today**, and **Upcoming**
- 🔍 **Filter Chips** — Filter by All, Today, Yesterday, Future, Completed, or Pending
- ✅ **Toggle Completion** — Tap the checkbox or swipe to mark tasks done/undone
- 🌙 **Dark / Light Theme** — Persistent theme toggle saved across sessions
- 📊 **Stats Header** — Live counts for Total, Today, Done, and Pending tasks
- 💾 **Offline Storage** — All data stored locally using Hive (no internet needed)
- 🎨 **Custom Typography** — Uses Google Fonts (Plus Jakarta Sans)
- 🧹 **Empty States** — Context-aware empty state messages per filter

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| [Flutter](https://flutter.dev) | UI Framework |
| [GetX](https://pub.dev/packages/get) | State Management + DI + Routing |
| [Hive](https://pub.dev/packages/hive_flutter) | Local NoSQL Database |
| [flutter_slidable](https://pub.dev/packages/flutter_slidable) | Swipeable task cards |
| [Google Fonts](https://pub.dev/packages/google_fonts) | Custom typography |
| [intl](https://pub.dev/packages/intl) | Date formatting |
| [uuid](https://pub.dev/packages/uuid) | Unique task ID generation |

---

## 📁 Project Structure

```
lib/
├── main.dart               # App entry point, Hive & GetX initialization
├── TaskModel.dart          # Hive data model with category logic
├── Task model.g.dart       # Hive generated adapter (do not edit)
├── task_controller.dart    # GetX controller — CRUD, filters, counts
├── theme_controller.dart   # GetX controller — dark/light theme
├── home_screen.dart        # Main screen with grouped task list
├── task_bottom_sheet.dart  # Add / Edit task modal
├── task_card.dart          # Slidable task card widget
├── stats_header.dart       # Stats banner (Total / Today / Done / Pending)
├── filter_chip_row.dart    # Horizontal scrollable filter chips
└── Empty_state.dart        # Empty state illustration per filter
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/todo_app.git
cd todo_app

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

> **Note:** The Hive adapter (`Task model.g.dart`) is already generated. If you modify `TaskModel.dart`, regenerate it with:
> ```bash
> flutter pub run build_runner build --delete-conflicting-outputs
> ```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_slidable: ^3.0.0
  google_fonts: ^6.1.0
  intl: ^0.19.0
  uuid: ^4.3.3

dev_dependencies:
  hive_generator: ^2.0.1
  build_runner: ^2.4.8
```

---

## 🎨 Theme

The app ships with two polished themes:

| | Light | Dark |
|---|---|---|
| Primary | `#6C63FF` (Purple) | `#8B83FF` (Soft Purple) |
| Background | `#F8F7FF` | `#0F0E17` |
| Card | `#FFFFFF` | `#1C1B2E` |
| Accent | `#FF6584` (Pink) | `#FF6584` (Pink) |

---
