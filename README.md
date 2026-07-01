# TrendLoop Mobile App

Flutter Android and iOS app for the TrendLoop P2P retail marketplace.

The mobile app has separate buyer and seller platforms. Users must authenticate when they open the app. Buyer accounts enter the buyer platform, while seller accounts enter the seller platform.

## Tech stack

- Flutter
- Dart
- Material 3
- Provider state management
- HTTP API services
- Cached network images

## Folder structure

```text
mobile
├── pubspec.yaml
└── lib
    ├── main.dart
    ├── models
    │   ├── app_user.dart
    │   ├── product.dart
    │   ├── seller.dart
    │   └── store_summary.dart
    ├── screens
    │   ├── auth_gate.dart
    │   ├── auth_screen.dart
    │   ├── buyer
    │   ├── seller
    │   ├── profile
    │   ├── common
    │   ├── cart_screen.dart
    │   ├── product_detail_screen.dart
    │   ├── profile_screen.dart
    │   ├── root_shell.dart
    │   ├── sell_screen.dart
    │   └── store_profile_screen.dart
    ├── services
    │   ├── api_client.dart
    │   ├── api_service.dart
    │   ├── auth_service.dart
    │   ├── cart_service.dart
    │   ├── order_service.dart
    │   ├── product_service.dart
    │   └── seller_service.dart
    ├── state
    │   └── app_state.dart
    └── theme
        └── app_theme.dart
```

## Main app flow

The app starts at:

```dart
AuthGate
```

Auth behavior:

- Logged-out users see `AuthScreen`.
- Logged-in buyers see the buyer platform.
- Logged-in sellers see the seller platform.

Platform selection happens in:

```text
lib/screens/root_shell.dart
```

```dart
return isSeller ? const SellerShell() : const BuyerShell();
```

## Buyer platform

Buyer tabs:

```text
Shop | Stores | Cart | Me
```

Buyers can:

- Browse products.
- Search and filter product discovery feed.
- View all seller stores.
- Open public store profiles.
- View products inside stores.
- Add items to cart.
- Access profile pages.

Buyer screens:

```text
lib/screens/buyer/buyer_shell.dart
lib/screens/buyer/buyer_home_screen.dart
lib/screens/buyer/stores_screen.dart
lib/screens/store_profile_screen.dart
```

## Seller platform

Seller tabs:

```text
Dashboard | Listings | Orders | Me
```

Sellers can:

- View seller dashboard.
- View public store preview.
- Manage listings.
- Create new product listings.
- Access seller order placeholders.
- Access seller tools such as analytics, shipping labels, and promotions.

Seller screens:

```text
lib/screens/seller/seller_shell.dart
lib/screens/seller/seller_dashboard_screen.dart
lib/screens/seller/seller_listings_screen.dart
lib/screens/seller/seller_orders_screen.dart
lib/screens/seller/seller_order_details_screen.dart
```

## Profile pages

The profile area has pages for:

```text
My seller shop
Orders
Wishlist
Trust & safety
Settings
```

Additional tile pages include:

```text
Shipping labels
Shop analytics
Promotions
Saved products
Saved stores
Account verification
Buyer protection
Report a listing or seller
Disputes and returns
Privacy and security
Payments
Addresses
Notifications
Language and region
Appearance
Help center
```

These are in:

```text
lib/screens/profile/
```

Shared placeholder/info pages use:

```text
lib/screens/common/info_page.dart
```

## Services

Each frontend service has its own file:

```text
lib/services/api_client.dart
lib/services/auth_service.dart
lib/services/product_service.dart
lib/services/cart_service.dart
lib/services/seller_service.dart
lib/services/order_service.dart
```

`api_service.dart` exports all services for convenience.

## Backend API URL

Default API URL:

```dart
http://10.0.2.2:4000/api
```

This works for the Android emulator when the backend runs on your host machine or Docker exposes port `4000`.

For iOS simulator or desktop web, run with:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:4000/api
```

For a physical device, replace `localhost` with your computer LAN IP:

```bash
flutter run --dart-define=API_BASE_URL=http://YOUR_LAN_IP:4000/api
```

## Run the app

Start the backend first:

```bash
cd ../backend
docker compose up -d --build
```

Then run Flutter:

```bash
cd ../mobile
flutter pub get
flutter run
```

## Demo account

Seller demo account:

```text
Email: mia@example.com
Password: password123
```

Use this account to enter the seller platform.

To test the buyer platform, register without enabling seller shop creation.

## Dependencies

Install Flutter dependencies:

```bash
flutter pub get
```

Analyze code:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```
