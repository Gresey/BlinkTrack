# 🚨 BlinkTrack – Real-Time Family & Friends Location Tracker

**BlinkTrack** is a real-time location tracking app built using **Flutter** and **Firebase**, enabling users to stay connected with their loved ones by creating private "circles" where all members can share and view each other's live locations. It also includes an **SOS feature** for emergency alerts.


## 🚀 Features

### 👨‍👩‍👧‍👦 Circles
- Create or join multiple circles (e.g. Family, Friends, Work)
- Each circle has its own group of members
- Live location of all circle members shown on a map

### 📍 Live Location Tracking
- Periodic location updates (e.g. every 10 seconds)
- Locations stored in Firebase Realtime Database
- Displayed using Google Maps with user markers

### 📱 Mobile Number Login
- OTP-based authentication using Firebase Auth
- Secure user onboarding with minimal friction

### 🚨 SOS Alerts (In Development)
- Users can add emergency contacts (SOS list)
- In emergencies, send SOS alerts to selected members
- Alerts can trigger push notifications or in-app prompts

## 📍 How It Works

1. User logs in using OTP (mobile number)
2. Onboarded to app and can create or join circles
3. Location is updated every few seconds using Geolocator
4. Realtime DB stores live location data of all circle members
5. Google Map shows all active members as markers
6. SOS button allows alerting members from SOS list in emergencies(in development)


## 📸 Screenshots 
* 🔐 Mobile Login Screen  
  <img src="https://github.com/user-attachments/assets/4718fe59-d5b7-4842-a2d2-707b1f149dcb" width="200" height="420" />
  <img src="https://github.com/user-attachments/assets/cdbb6744-2b43-4d64-b836-f105f6c3ff3e" width="200" height="420" />
  <img src="https://github.com/user-attachments/assets/c249b01b-73b4-406d-a896-7c141e26de58" width="200" height="420" />

* 🧮 Circle Management  
  <img src="https://github.com/user-attachments/assets/cd9c0865-38d0-405c-abfc-8f5d9c2dbd0e" width="200" height="420" />
  <img src="https://github.com/user-attachments/assets/00cdf4c3-fb36-4975-b489-cafe9cd60f3d" width="200" height="420" />

* 🗺 Circle Map View  
  <img src="https://github.com/user-attachments/assets/1fa9f7c1-5e9f-46aa-a394-4f22ceb47250" width="200" height="420" />

* 🚨 SOS Feature in Action  
  <img src="https://github.com/user-attachments/assets/514014b6-a93b-4301-88c1-74c36eb38dcf" width="200" height="420" />


## 🔧 Tech Stack

| Tech                  | Description                          |
|-----------------------|--------------------------------------|
| Flutter               | Cross-platform mobile app framework |
| Firebase Auth         | Mobile number login (OTP)           |
| Firebase Firestore    | Stores user and circle metadata     |
| Firebase Realtime DB  | Stores live location data           |
| Google Maps Flutter   | Map and marker display              |
| Geolocator            | Access device GPS data              |
| Firebase Cloud Messaging (FCM) | (Optional) Push SOS alerts |



## 🛠️ Setup Instructions

###  Prerequisites

* Flutter SDK (Latest Stable)
* Firebase Project Created
* Enable:

  * **Phone Authentication**
  * **Firestore**
  * **Realtime Database**
  * **Cloud Messaging** for SOS push

### 📲 Steps to Run

1. **Clone the repo**

   ```bash
   git clone https://github.com/Gresey/blinktrack.git
   cd blinktrack
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Add Firebase Configuration**

   * `android/app/google-services.json`
   * `ios/Runner/GoogleService-Info.plist`

4. **Run the app**

   ```bash
   flutter run
   ```

- 🔒 Role-based permissions (Admin/Member)
- 📡 Offline location sync



