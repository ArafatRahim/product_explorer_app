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

Flutter Product Explorer App# 🛍️ Product Explorer App

A Flutter Product Explorer application developed using **Provider State Management**, **Repository Pattern**, **REST API integration**, and **SQLite local database**. The application allows users to browse products, search, perform CRUD (Create, Read, Update, Delete) operations, cache data locally for offline access, and load products using pagination.

---

## 📱 Features

- Splash Screen
- View products from REST API
- Search products by title or category
- Product details screen
- Add new product
- Edit existing product
- Delete product
- SQLite local storage
- Offline data persistence
- Load More Pagination
- Pull-to-Refresh
- Responsive Grid Layout (Mobile & Tablet)
- Cached Network Images
- Loading State
- Empty State
- Error Handling
- Provider State Management
- Repository Pattern

---

## 🌐 API Used

The application uses the **DummyJSON Products API**.

https://dummyjson.com/products

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
            /       \
           ▼         ▼
      REST API    SQLite
```

The application follows a clean and maintainable architecture consisting of:

- Presentation Layer
- Provider (State Management)
- Repository Pattern
- REST API Service
- SQLite Local Database

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

## 💾 Local Database

SQLite is used to:

- Cache downloaded products
- Store newly added products
- Update existing products
- Delete products
- Provide offline access after the initial API download

---

## 🚀 Functionalities

- REST API Integration
- JSON Parsing
- CRUD Operations
- SQLite Offline Cache
- Search & Filter
- Pagination (Load More)
- Responsive UI
- Pull-to-Refresh
- Error Handling
- Loading Indicator
- Empty State Management

---

## 📸 Screenshots

Screenshots included:

- Splash Screen
- Home Screen
- Product Details Screen
- Add Product Screen
- Edit Product Screen

---

## ▶️ Getting Started

### Clone the repository

```bash
git clone https://github.com/ArafatRahim/product_explorer_app.git
```

### Install dependencies

```bash
flutter pub get
```

### Run the project

```bash
flutter run
```

---

## 👨‍💻 Developed By

**Name:** Arafat Rahim

**Student ID:** C221021

**Course:** Mobile Application Development with Flutter

**Year:** 2026

---

## 📄 License

This project was developed for academic purposes as part of the **Mobile Application Development with Flutter** course.

2026