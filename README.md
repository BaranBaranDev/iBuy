# iBuy - E-Commerce App

iBuy is a modern e-commerce app built with a focus on code quality, performance, and scalable architecture. The app interface is 100% programmatically developed using UIKit, leveraging advanced UICollectionView layouts for a smooth and responsive user experience.

Features

Programmatic UIKit: The entire interface is built without Storyboards or XIBs, ensuring full control over the UI and flexibility in layout.
Compositional Layout: Uses UICollectionView with modern UICollectionViewCompositionalLayout for a flexible and efficient UI, supporting dynamic and complex layouts.
Clean Swift VIP Architecture: Implements the Clean Architecture with VIP (View, Interactor, Presenter) for highly modular, testable, and maintainable code.
CoreData Integration: Generic data management using CoreData for storing, retrieving, and deleting user data.
Firebase Admin Panel: Firebase is integrated for handling user data and serving as the backend for real-time database operations.
SDWebImage with Caching: Images are loaded and cached efficiently using SDWebImage, including a custom cache size limit (50MB) to optimize performance.
Notification Center & Protocols: Extensive use of NotificationCenter and protocols ensures decoupled communication across app components.
Factory Pattern: Utilized for creating common UI components such as labels, buttons, and more to promote code reuse and consistency.
Dependency Injection: Applied across the app to decouple class dependencies and improve testability.
Core Technologies

UIKit: For custom, programmatic UI.
Clean Swift Architecture (VIP): Ensuring separation of concerns and scalable code.
CoreData: For persistent data storage.
Firebase: Backend for real-time data and authentication.
SDWebImage: For image loading and caching with a custom cache size of 50MB.
