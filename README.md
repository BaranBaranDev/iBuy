# iBuy - E-Commerce App

**iBuy** is a modern e-commerce application designed with a strong emphasis on code quality, performance, and scalable architecture. The app's interface is developed entirely programmatically using UIKit, utilizing advanced UICollectionView layouts to provide a smooth and responsive user experience.

## Features

- **Programmatic UIKit**: The entire interface is built without Storyboards or XIBs, ensuring complete control over the UI and flexibility in layout design.
  
- **Compositional Layout**: Implements `UICollectionViewCompositionalLayout` for a flexible and efficient UI, supporting dynamic and complex layouts.
  
- **Clean Swift VIP Architecture**: Follows the Clean Architecture principles with VIP (View, Interactor, Presenter) to ensure a highly modular, testable, and maintainable codebase.
  
- **Core Data Integration**: Provides generic data management using Core Data for storing, retrieving, and deleting user data.
  
- **Firebase Admin Panel**: Integrates Firebase to handle user data and serve as the backend for real-time database operations.
  
- **SDWebImage with Caching**: Efficiently loads and caches images using SDWebImage, featuring a custom cache size limit of **50MB** to optimize performance.
  
- **Notification Center & Protocols**: Utilizes `NotificationCenter` and protocols extensively to ensure decoupled communication across app components.
  
- **Factory Pattern**: Implements the Factory Pattern for creating common UI components such as labels and buttons, promoting code reuse and consistency.
  
- **Dependency Injection**: Applies dependency injection throughout the app to decouple class dependencies and enhance testability.

## Core Technologies

- **UIKit**: For custom, programmatic UI development.
- **Clean Swift Architecture (VIP)**: Ensures separation of concerns and promotes scalable code.
- **Core Data**: For persistent data storage solutions.
- **Firebase**: Serves as the backend for real-time data management and authentication.
- **SDWebImage**: Facilitates image loading and caching with a custom cache size of **50MB**.
