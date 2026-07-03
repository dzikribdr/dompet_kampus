# CashLess

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase"/>
  <img src="https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white" alt="Go"/>
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white" alt="Redis"/>
</p>

### Project UAS Mobile Programming

- Mata Kuliah : Aplikasi Mobile Lanjutan
- NIM : 1123150049
- Nama : Dzikri Abdurrahman Haris
- Kelas : TI 23 SE 1
- Dosen : I Ketut Gunawan, S.KOM, M.T.I
- Konsentrasi : Software Engineering
- Prodi : Teknik Informatika
- Semester : Genap
- Tahun Akademik: 2026 - 2027

---

### CashLess aplikasi apa sih itu?

CashLess adalah aplikasi e-money modern yang dirancang untuk memudahkan transaksi pembayaran, top up saldo, dan transfer dana secara digital. Aplikasi ini dibangun dengan pendekatan Clean Architecture dan dilengkapi lapisan keamanan berlapis (PIN + Two-Factor Authentication) untuk menjamin keamanan setiap transaksi pengguna.

Aplikasi ini juga sebagai project tugas akhir UAS mata kuliah mobile programming loh yah di <b>Global Institut Teknologi Bina Sarana Global</b> pada semester genap 2026/2027.

## Fitur Utama

- **Authentication:** Registrasi & login menggunakan Firebase Auth, Google Sign-In, serta verifikasi OTP email.
- **Two-Factor Authentication (2FA):** Mendukung tiga metode verifikasi tambahan — Firebase Push Notification, OTP via Email (SMTP), dan TOTP (Google Authenticator).
- **Biometric Login:** Login cepat menggunakan sidik jari/Face ID melalui modul biometric kit internal.
- **PIN Keamanan Transaksi:** Setiap pembayaran, top up, dan transfer dikonfirmasi menggunakan PIN 6 digit.
- **QRIS Scanner:** Pembayaran merchant secara instan melalui pemindaian kode QR.
- **Wallet Management:** Kelola saldo dan riwayat transaksi secara real-time.
- **Top Up & Transfer Saldo:** Fitur pengisian dan transfer dana antar pengguna yang efisien.
- **Promo & Rewards System:** Katalog promo untuk menarik engagement pengguna.
- **App-to-App Payment (Deep Linking):** Menerima permintaan pembayaran dari aplikasi merchant/pihak ketiga secara seamless menggunakan URI Link Stream.

## Tech Stack

- **Framework:** Flutter (Dart)
- **Architecture:** Clean Architecture (Domain - Data - Presentation)
- **State Management:** BLoC (flutter_bloc)
- **Dependency Injection:** GetIt
- **Backend:** Golang (Gin Gonic) + GORM
- **Database:** MySQL
- **Cache/Session:** Redis
- **Auth & Notifikasi:** Firebase (Auth, Admin SDK, Push Notification)
- **Networking:** Dio (HTTP Client)
- **Navigation:** GoRouter
- **Storage:** Flutter Secure Storage
- **Biometric:** local_auth

## Preview Aplikasi

<p align="center">
    <img src="assets/images/splash.jpeg" width="160"/>
    <img src="assets/images/daftar.jpeg" width="160"/>
    <img src="assets/images/masuk.jpeg" width="160"/>
    <img src="assets/images/home.jpeg" width="160"/>
    <img src="assets/images/profile.jpeg" width="160"/>
</p>
<p align="center">
    Splash Screen &nbsp;|&nbsp; Daftar &nbsp;|&nbsp; Masuk &nbsp;|&nbsp; Home &nbsp;|&nbsp; Profile
</p>

## Struktur Project (Clean Architecture)

Aplikasi ini menerapkan prinsip pemisahan tanggung jawab (_Separation of Concerns_) dengan memisahkan lapisan domain (business rules), data (sumber data), dan presentation (UI + BLoC). Struktur ini memastikan _codebase_ tetap rapi, mudah di-_maintenance_, dan siap untuk diskalakan.

```text
cashless/
├── android/                     # Konfigurasi native Android (App Name, Icons, Permissions)
├── assets/                      # Aset statis aplikasi
├── lib/
│   ├── core/                    # Konfigurasi inti dan utilitas global
│   │   ├── constants/           # AppConstants & ApiEndpoints
│   │   ├── error/                # Exception handling
│   │   ├── network/              # ApiClient (Dio wrapper)
│   │   ├── router/               # AppRouter (GoRouter navigation tree)
│   │   ├── services/             # DeeplinkService (App-to-App payment)
│   │   ├── theme/                # AppColors & AppTextStyles
│   │   └── utils/                # Helper & AppBlocObserver
│   ├── domain/                   # Business Logic murni
│   │   ├── entities/             # Entity murni (User, Account, dsb)
│   │   ├── repositories/         # Kontrak repository (interface)
│   │   └── usecases/             # UseCase per fitur (auth, account, payment)
│   ├── data/                     # Implementasi sumber data
│   │   ├── datasources/          # Remote (API) & Local (Secure Storage)
│   │   ├── models/                # DTO/Model data
│   │   └── repositories/          # Implementasi repository
│   ├── presentation/              # Lapisan Antarmuka Pengguna (UI/UX)
│   │   ├── blocs/                 # AuthBloc, AccountBloc, HomeBloc, PaymentBloc
│   │   ├── pages/                 # Splash, Auth (Login/Register/2FA), Home, Topup,
│   │   │                          # Transfer, Payment (QR/Deeplink/PIN), History, Promo
│   │   └── widgets/                # Komponen UI reusable
│   ├── src/                       # Modul internal flutter_biometric_kit
│   ├── injection/                 # GetIt service locator (injection_container.dart)
│   ├── flutter_biometric_kit.dart # Entry point modul biometric
│   └── main.dart                  # Entry point aplikasi (Root Setup & Init)
├── pubspec.yaml                   # Manajemen dependensi aplikasi
└── README.md                      # Dokumentasi utama
```

## Arsitektur Sistem

Berikut adalah diagram alur integrasi antara **FrozenFood (E-Commerce)** dan **CashLess (E-Money)** saat proses pembayaran terjadi:

```mermaid
sequenceDiagram
    participant FF as FrozenFood (E-Commerce)
    participant CL as CashLess (E-Money)
    participant BE as Backend CashLess (Go + Gin)

    FF->>CL: Checkout & Panggil Deep Link (dompetkampus://pay?amount=...)
    CL-->>CL: Tampilkan Detail Pembayaran
    CL-->>CL: Validasi PIN Transaksi
    CL-->>CL: Validasi Two-Factor Authentication (2FA)
    CL->>BE: Proses Transaksi & Potong Saldo
    BE-->>CL: Transaksi Sukses
    CL->>FF: Callback Deep Link (frozenfood://payment-callback?status=success)
    FF-->>FF: Konfirmasi & Update Status Pesanan
```

> Catatan desain: status pesanan **tidak hanya dipercaya dari callback deep link** — FrozenFood tetap mengonfirmasi status pembayaran ke backend-nya sendiri lewat REST API, supaya database selalu jadi sumber kebenaran (*single source of truth*).

## Implementasi Deep Link & Keamanan Berlapis

### Mekanisme Deep Link (App-to-App Payment)

Aplikasi ini menggunakan skema URI (`dompetkampus://`) untuk menerima permintaan pembayaran dari aplikasi merchant/pihak ketiga secara _seamless_.

- **Format Link:** `dompetkampus://pay?merchant_id=...&merchant_name=...&amount=...&description=...&reference=...&callback=...`
- **Penerimaan Data:** Menggunakan _package_ `app_links` untuk menangkap deep link, baik pada kondisi _cold-start_ (app belum berjalan) maupun _in-app_ (app sedang berjalan).
- **Validasi Payload:** `merchant_id`, `merchant_name`, dan `amount` divalidasi sebelum diteruskan ke halaman pembayaran; jika tidak valid, pengguna diarahkan ke halaman error dengan pesan yang sesuai.
- **Callback Status:** Setelah transaksi selesai, aplikasi dapat mengembalikan status pembayaran ke aplikasi pemanggil melalui `callback` URL yang disertakan pada payload.

### Keamanan Berlapis (PIN + 2FA)

- **Layer 1 (Kredensial):** Autentikasi utama menggunakan Firebase Authentication dan Google Sign-In, dilanjutkan verifikasi OTP email saat registrasi.
- **Layer 2 (Two-Factor Authentication):** Pengguna dapat memilih salah satu dari tiga metode 2FA — Firebase Push Notification, OTP via Email (SMTP), atau TOTP (Google Authenticator) — yang disimpan sebagai preferensi akun.
- **Layer 3 (Transaksi):** Setiap transaksi (top up, transfer, pembayaran) wajib dikonfirmasi menggunakan PIN 6 digit, dengan opsi login cepat via biometrik (sidik jari/Face ID).

## Arsitektur Backend (Golang-Gin & GORM)

Layanan backend dibangun menggunakan bahasa **Go** dengan framework **Gin Gonic**, **GORM** sebagai ORM ke database **MySQL**, serta **Redis** untuk pengelolaan sesi OTP sementara. Autentikasi dan notifikasi terintegrasi dengan **Firebase Admin SDK**, dan sesi API diamankan menggunakan **JWT**.

### Daftar Endpoint Utama

| Method | Endpoint                    | Keterangan                             |
| ------ | --------------------------- | -------------------------------------- |
| GET    | `/v1/health`                | Health check server                    |
| POST   | `/v1/auth/verify-token`     | Verifikasi token Firebase              |
| POST   | `/v1/auth/register`         | Registrasi akun baru + OTP             |
| GET    | `/v1/auth/me`               | Ambil data profil pengguna             |
| PUT    | `/v1/auth/fcm-token`        | Update token notifikasi FCM            |
| POST   | `/v1/auth/verify-email-otp` | Verifikasi OTP email                   |
| POST   | `/v1/otp/send-firebase`     | Kirim OTP via Firebase notif           |
| POST   | `/v1/otp/send-email`        | Kirim OTP via email (SMTP)             |
| POST   | `/v1/otp/confirm`           | Konfirmasi kode OTP                    |
| POST   | `/v1/otp/totp/register`     | Registrasi TOTP (Google Authenticator) |
| POST   | `/v1/otp/totp/verify`       | Verifikasi kode TOTP                   |
| GET    | `/v1/account`               | Ambil data saldo akun                  |
| GET    | `/v1/account/transactions`  | Ambil riwayat transaksi                |
| POST   | `/v1/payment/topup`         | Top up saldo                           |
| POST   | `/v1/payment/transfer`      | Transfer saldo antar pengguna          |

> Seluruh endpoint di atas (kecuali `/health`, `/auth/verify-token`, dan `/auth/register`) memerlukan header `Authorization: Bearer <JWT>`.

## Cara Menjalankan Project

### Frontend (Flutter)

1. Clone repository ke mesin lokal:
   ```bash
   git clone [URL_REPOSITORY_ANDA]
   ```
2. Masuk ke direktori proyek:
   ```bash
   cd cashless
   ```
3. Unduh semua dependensi yang diperlukan:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi pada emulator atau perangkat fisik:
   ```bash
   flutter run
   ```
5. (Opsional) Untuk membuat _file_ instalasi APK:
   ```bash
   flutter build apk --release
   ```

### Backend (Golang)

1. Masuk ke direktori backend:
   ```bash
   cd be-emoney
   ```
2. Siapkan file `.env` (kredensial database MySQL, Redis, Firebase, dan SMTP).
3. Unduh dependensi Go:
   ```bash
   go mod tidy
   ```
4. Jalankan server:
   ```bash
   go run main.go
   ```

## Daftar Dependensi Utama

**Frontend (Flutter):**

- **flutter_bloc** — State Management
- **get_it** — Dependency Injection
- **firebase_auth** & **firebase_core** — Autentikasi
- **google_sign_in** — Login via Google
- **go_router** — Navigasi & Deep Linking routing
- **app_links** — Penangkap URI Deep Link
- **dio** — HTTP Request
- **mobile_scanner** — Pemindai QRIS
- **local_auth** — Autentikasi biometrik
- **flutter_secure_storage** — Penyimpanan token aman
- **equatable**, **intl**, **url_launcher**, **pretty_dio_logger**

**Backend (Golang):**

- **gin-gonic/gin** — HTTP Web Framework
- **gorm.io/gorm** + **gorm.io/driver/mysql** — ORM & Database
- **redis/go-redis** — Session/OTP cache
- **firebase.google.com/go/v4** — Firebase Admin SDK
- **golang-jwt/jwt** — Autentikasi JWT
- **pquerna/otp** — TOTP (Google Authenticator)
- **gomail.v2** — Pengiriman OTP via email

## Repositories & Demo

- **Frontend (CashLess):** https://github.com/dzikribdr/dompet_kampus
- **Backend (be-emoney):** https://github.com/dzikribdr/be-emoney
- **Frontend (FrozenFood):** https://github.com/dzikribdr/frozen_food_1123150049
- **Backend (be-frozenfood):** https://github.com/dzikribdr/gin-firebase-backend
- **Demo Presentasi:** https://www.youtube.com/watch?v=UhlI0ovDtSA

---

1123150049<br>
Dzikri Abdurrahman Haris