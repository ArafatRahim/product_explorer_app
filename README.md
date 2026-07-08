# 🛍️ Product Explorer App

A Flutter Product Explorer application built using **Provider**, **Repository Pattern**, **REST API**, and **SQLite**. The application allows users to browse products, search, add, edit, and delete products with local database support.

---

## 📱 Features

- View products from REST API
- Search products
- Product details page
- Add new product
- Edit existing product
- Delete product
- SQLite local storage
- Offline data persistence
- Responsive Grid Layout
- Pull-to-refresh
- Cached Network Images
- Provider State Management

---

## 🏗️ Architecture

```
UI
│
▼
Provider
│
▼
Repository
│
▼
API + SQLite
```

The application follows a simple clean architecture using:

- Presentation Layer
- Provider
- Repository
- Local Database (SQLite)
- Remote API

---

## 📂 Folder Structure

```
lib/
│
├── data/
│   ├── database/
│   ├── models/
│   └── repositories/
│
├── presentation/
│   ├── screens/
│   └── widgets/
│
├── providers/
│
├── services/
│
└── main.dart
```

---

## 📦 Packages Used

- provider
- http
- sqflite
- path
- cached_network_image

---

## 🚀 API

Product data is fetched from:

https://dummyjson.com/products

---

## 💾 Local Database

SQLite is used to:

- Store downloaded products
- Save newly added products
- Update products
- Delete products
- Support offline usage

---

## 📸 Screenshots

Add screenshots of:

- Home Screen
- Product Details
- Add Product
- Edit Product

---

## ▶️ Getting Started

```bash
flutter pub get
flutter run
```

---

## 👨‍💻 Developed By

**Arafat Rahim**

Flutter Product Explorer App

2026