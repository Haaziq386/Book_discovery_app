# Book-Inator

Book-Inator is a modern Flutter-based book discovery app that allows users to browse and search for books effortlessly. It leverages RESTful APIs for fetching book data and provides a seamless user experience with automated searching, pagination, and image optimization. The app ensures a responsive interface and includes intelligent data preloading and caching mechanisms.

---

## Screenshots

---

## Video Demo

---

## Features

- **Clean and Responsive User Interface**
  - Designed with usability and aesthetics in mind, offering an intuitive and visually appealing experience.
- **Automated Searching**
  - Built-in debouncer to optimize search queries and minimize API calls.
- **Endless Scrolling with Preloading**
  - Efficient pagination with data preloading and caching for smooth scrolling.
- **Optimized Image Handling**
  - Compressed and cached book cover images to ensure fast loading and reduced memory usage.
- **Tab-based Navigation**
  - Seamless navigation between tabs with smooth scrolling behavior.
- **Error Handling**
  - Comprehensive error handling to ensure a robust user experience in case of API failures or connectivity issues.

---

## Tech Stack

- **Flutter/Dart** for the mobile application
- **RESTful APIs** for fetching book data (https://gutendex.com/books/)

### Libraries Used

#### Core Libraries
- `material.dart`: UI components
- `async`: Asynchronous programming utilities
- `convert`: Data serialization and conversion between different data representations

#### Additional Libraries
- `cached_network_image`: Optimized and cached image loading
- `http`:Future-based library for making HTTP requests
- `url_launcher`:Launching a URL
---

## Installation

### Prerequisites
- Ensure Flutter is installed on your system. If not, follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/Haaziq386/Book_discovery_app.git
   cd Book_discovery_app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on an emulator or a connected device:
   ```bash
   flutter run
   ```

---

## Code Structure

The app follows a modular code structure for maintainability and scalability:

### Directory Structure
```
lib/
|-- models/            # Data models (e.g., Book)
|-- screens/           # Individual screens (e.g., Book Detail Screen, SearchScreen)
|-- widgets/           # Reusable widgets (e.g., TabBar, LoadingSpinner)
|-- services/          # API service integration (e.g., API Provider)
|-- utils/             # Helper classes (e.g., Debouncer, constants)
|-- main.dart          # Application entry point
```

### Design Choices
- **Modularity**: Code is organized into models, views, and services, ensuring modularity.
- **State Management**: Provider is used for state management, ensuring a responsive UI.
- **Error Handling**: Try-catch blocks and user-friendly error messages are implemented to handle edge cases gracefully.
- **Optimizations**:
  - Data caching and preloading to enhance performance.
  - Use of `AlwaysScrollableScrollPhysics` and `NeverScrollableScrollPhysics` for seamless scrolling.

---

## Usage

1. Launch the app on your device using the `Book-Inator.apk`.
2. Use the search bar to look up books by title or author.
3. Browse through the endless scrollable list of books.
4. Tap on a book to view more details.
5. Go to the Read Online Tab, to read the book online on the links provided.
6. Enjoy the optimized, responsive interface with haptic feedback.

---

## Challenges and Solutions

### Few Bugs Fixed
1. **UI Enhancements**: Improved design after researching various layouts.
2. **Unscrollable Tabs**: Resolved by combining scroller physics and proper height constraints after trying many other widgets.
3. **Popping Elements During Scroll**: Faded elements using `Opacity` for a smoother experience.
4. **Slow Pagination**: Preloaded and cached data to improve scrolling speed.
5. **Search Query Display Issue**: Passed query as a parameter to avoid refresh-related issues.
6. **Issues with Automated Searching**:Searching on each letter was slow , so went for debouncing.
7. **Responsiveness Issues**:Tested code on multiple devices ,to ensure it's responsiveness.

### Other Limitations

1. A stable internet connection is required for the app to function properly since it relies on API requests to fetch data.
2. The API does not provide sufficient details about the cost of the book, which limits functionality related to pricing. It also lacks detailed data needed to create a comprehensive "About" section in the book detail screen.
3. For simplicity, the formats in the "Read Online" section are displayed as they are provided by the API (e.g., text/html). This could be improved by renaming the formats to more user-friendly terms (e.g., changing text/html to HTML) for better readability.
---

## Made with ❤️ for Intern Assignment of Biliion Labs
