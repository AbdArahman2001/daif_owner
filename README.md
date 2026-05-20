# Dayf App (Owner Application)

## Project Overview

Dayf App is a comprehensive platform for booking tourist accommodations, specifically designed for hosts (property owners) to efficiently manage their bookings and properties. The application aims to provide a seamless experience for hosts by streamlining booking processes, optimizing inventory management, and offering comprehensive performance analytics. This application is built using the Flutter framework, ensuring a rich and consistent user experience across both Android and iOS platforms.

## Key Features

### 1. Booking and Property Management
*   **Advanced Booking System**: A high-performance booking engine featuring a seamless 3-step checkout process.
*   **Dynamic Inventory Management**: Sophisticated scheduling algorithms to handle dynamic inventory, prevent overbooking, and manage complex reservation conflicts.
*   **Geographical Location**: Integration with Google Maps SDK and Geolocator with custom geofencing to enable precise location-based discovery.
*   **Personalized Recommendation Engine**: A recommendation engine utilizing user behavioral data and ranking algorithms to enhance user engagement.

### 2. Advanced Host Tools
*   **Robust Filtering System**: A filtering system with 15+ dynamic parameters using optimized query logic for instant search results.
*   **Secure Hybrid Payment Gateways**: Integration of secure hybrid payment gateways (Online & Cash) with automated booking confirmation workflows.
*   **Comprehensive Analytics Dashboards**: Analytics dashboards for hosts using Syncfusion Charts to track revenue, visitor metrics, and booking trends.

## Technologies and Expertise Used

Dayf App was developed relying on a set of cutting-edge technologies and best engineering practices to ensure high performance, scalability, and ease of maintenance.

### 1. Framework and Language
*   **Flutter**: Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. (Note: Flutter 2.18.1+ was used).
*   **Dart**: The programming language used with Flutter.

### 2. Application Architecture and State Management
*   **Clean Architecture**: Clean Architecture was adopted to separate concerns, ensuring testability, maintainability, and scalability. (Note: This is evident through folder organization such as `data`, `controller`, `view`).
*   **Provider**: For state management in the application, offering a simple yet powerful way to manage and flow data across the UI.
*   **SOLID Principles**: SOLID principles were applied to ensure clean, flexible, and extensible code design.

### 3. Main Libraries and Dependencies (from `pubspec.yaml`)
*   **cupertino_icons**: iOS icons for Flutter.
*   **shimmer**: For attractive loading effects.
*   **dio**: A powerful HTTP client for handling network requests.
*   **connectivity**: To check internet connection status.
*   **get**: (GetX) For state management, dependency injection, and fast routing.
*   **intl**: For internationalization and localization support.
*   **shared_preferences**: For storing simple data locally.
*   **path_provider**: To get common file system paths.
*   **flutter_local_notifications**: For managing local notifications.
*   **flutter_screenutil**: For adapting the UI to different screen sizes.
*   **carousel_slider**: For displaying rotating slides.
*   **cached_network_image**: For loading and caching images from the network.
*   **dotted_border**: For creating dotted borders.
*   **image_picker**: For picking images from the gallery or camera.
*   **pin_code_fields**: For PIN code input fields.
*   **flutter_cache_manager**: For managing file caching.
*   **url_launcher**: For opening external links.
*   **photo_view**: For viewing images with zoom and pan capabilities.
*   **lottie**: For displaying Lottie JSON animations.
*   **string_validator**: For validating text inputs.
*   **infinite_scroll_pagination**: For implementing infinite scrolling.
*   **package_info_plus**: For getting application information.
*   **store_redirect**: For redirecting users to app stores.

### 4. Analytics and Visualization Tools
*   **Syncfusion Charts**: For creating rich analytical dashboards and visualizing data (e.g., revenue, visitor metrics, and booking trends).

### 5. Project Management and Collaboration
*   **Agile/Scrum**: Agile/Scrum methodologies were followed in project management to ensure flexibility and iterative delivery.
*   **Trello**: A tool for task management and distribution among team members.
*   **Code Reviews**: Regular code reviews to maintain high quality and adherence to SOLID principles.

## Project Development Phases

*   **Project Planning & Architecture (September 2022 - October 2022)**:
    *   Led the architectural design of the platform using Clean Architecture and Provider.
    *   Developed sophisticated scheduling algorithms to handle dynamic inventory, prevent overbooking, and manage complex reservation conflicts.

*   **Development & Core Engine (November 2022 - January 2023)**:
    *   Engineered a high-performance booking engine featuring a seamless 3-step checkout process.
    *   Integrated Google Maps SDK and Geolocator with custom geofencing to enable precise location-based discovery.
    *   Built a personalized recommendation engine utilizing user behavioral data and ranking algorithms to enhance user engagement.

*   **Advanced Integrations & Analytics (January 2021 - July 2023)**:
    *   Developed a robust filtering system with 15+ dynamic parameters using optimized query logic for instant search results.
    *   Integrated secure hybrid payment gateways (Online & Cash) with automated booking confirmation workflows.
    *   Built comprehensive analytics dashboards for hosts using Syncfusion Charts to track revenue, visitor metrics, and booking trends.

## Getting Started

To set up and run the project locally, follow these steps:

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/AbdArahman2001/daif_owner.git
    cd daif_owner
    ```

2.  **Get dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the app**:
    ```bash
    flutter run
    ```

## Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.


## Contact Us

For inquiries or support, please contact bdalrhmnalslyby710@gmail.com.

---
