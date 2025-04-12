# 🛒 Flutter New E-Commerce Application

Welcome to the **Flutter New E-Commerce Application** – a complete and modern e-commerce solution built with Flutter and a PHP backend!  
This project is designed to offer a seamless shopping experience for users and a scalable foundation for developers.

## 🚀 Features

- 📱 **Beautiful UI** with responsive design
- 🔐 **OTP Authentication** (with SMS auto-fill)
- 📦 **Product Listing & Details**
- 🛍️ **Add to Cart & Checkout Flow**
- 🔁 **Device-level account restriction**
- 📡 **Works with local PHP API (XAMPP)**
- 🔄 **Real-time updates and state management**

## 🛠️ Tech Stack

- **Frontend**: Flutter (Web & Mobile)
- **Backend**: PHP (Localhost with XAMPP)
- **Authentication**: OTP via SMS + Device ID lock

## 📷 Screenshots

| Home Screen | Product Details | Cart |
|-------------|------------------|------|
| *Coming soon* | *Coming soon* | *Coming soon* |

## ⚙️ Setup Instructions

1. **Clone the Repository**
```bash
   git clone https://github.com/prothesbarai/Flutter-New-E-Commerce-Application.git
```
2.**Navigate to the project directory**
```bash
   cd Flutter-New-E-Commerce-Application
```
3. **Install Flutter dependencies**
```bash
   flutter pub get
```
4. **Run the app**
```bash
   flutter run -d chrome  # for web
   flutter run            # for mobile
```

5. **Setup the backend**

- Start your XAMPP server

- Import the ecommerce.sql to your MySQL database

- Place the PHP API files inside htdocs

## 💡 Note
Make sure to enable device permission for SMS and phone state.

The app is designed to prevent multiple accounts from the same device.

📬 Feedback
Have any suggestions or improvements? Feel free to open an issue or create a pull request!

## 🔗 Follow Me
Made with ❤️ by Prothes Barai
👉 Follow me on GitHub for more awesome projects!


## Click This Link and Guide For Future async await
[Read File](https://github.com/prothesbarai/Flutter-New-E-Commerce-Application/blob/main/Future_Async_Await_Guide_Bangla.md)






## 👉 Backend API Generate :
```php
   <?php
      header('Content-Type: application/json');
      $servername = "localhost";
      $username = "root";
      $password = "";
      $dbname = "";

      // Create connection
      $conn = new mysqli($servername, $username, $password, $dbname);

      // Check connection
      if ($conn->connect_error) {
         die("Connection failed: " . $conn->connect_error);
      }

      $sql = "SELECT * FROM products";
      $result = $conn->query($sql);

      $products = array();

      if ($result->num_rows > 0) {
         while($row = $result->fetch_assoc()) {
            $products[] = $row;
         }
      }

      echo json_encode($products);

      $conn->close();
   ?>

```


## SQL Side Dummy Data 
```sql
   CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `imageUrl` text DEFAULT NULL,
  `title` text DEFAULT NULL,
  `regularPrice` double DEFAULT NULL,
  `memberPrice` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `total_quantity` int(11) DEFAULT NULL
)
```

```sql
   INSERT INTO `products` (`id`, `imageUrl`, `title`, `regularPrice`, `memberPrice`, `discount`, `quantity`) VALUES
(1, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 100, 90, 10, 5),
(2, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 150, 135, 10, 8),
(3, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 200, 180, 10, 3),
(4, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 120, 110, 8.3, 10),
(5, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 250, 200, 20, 2),
(6, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 300, 270, 10, 7),
(7, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 180, 160, 11.1, 4),
(8, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 220, 210, 4.5, 6),
(9, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 130, 120, 7.7, 9),
(10, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 90, 85, 5.6, 12),
(11, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 140, 130, 7.1, 11),
(12, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 170, 150, 11.8, 1),
(13, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 160, 140, 12.5, 3),
(14, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 190, 175, 7.9, 6),
(15, 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&w=600', 'Product design is the process of creating or improving products to meet user needs and business goals', 210, 190, 9.5, 5);
```
