# Monopoly Banker NFC

**IoT banking system for Monopoly board game using NFC/RFID technology with Raspberry Pi and Flutter.**

> Hardware-software integration project demonstrating contactless transaction processing, real-time balance management, and custom NFC protocol implementation for tabletop gaming.

---

## Technical Overview

This project replaces physical Monopoly money with a digital banking system powered by NFC cards. Players tap NFC-enabled cards on a Raspberry Pi reader to perform transactions, with real-time balance updates displayed on a Flutter mobile interface.

**Key Capabilities**
- **Contactless payments** via NFC tag reading (13.56 MHz)
- **Real-time transaction processing** with balance validation
- **Multi-player account management** with persistent storage
- **Transaction history** and audit logging
- **Hardware-software synchronization** via REST API

## Architecture

### Hardware Layer
- **Raspberry Pi 4** - Transaction processing server and API host
- **PN532 NFC Reader** - Reads Mifare Classic/Ultralight NFC tags
- **Custom NFC Cards** - Player "bank cards" with unique UIDs

### Software Stack
- **Python Backend** - Flask REST API handling transaction logic
- **Flutter Frontend** - Cross-platform mobile UI for game master
- **SQLite Database** - Local persistence of accounts and transactions
- **libnfc** - Low-level NFC communication protocol

## How It Works

1. **Player Registration**: Each player's NFC card is scanned and assigned a starting balance ($1500)
2. **Transaction Flow**:
   - Player taps card on reader
   - PN532 reads unique card UID
   - Backend validates balance and processes transaction
   - Flutter app updates in real-time via WebSocket
3. **Transaction Types**:
   - Property purchase
   - Rent payment (player-to-player transfer)
   - Salary collection (pass GO)
   - Chance/Community Chest events

## Quick Start

### Hardware Setup

**Requirements**
- Raspberry Pi 4 (or Pi 3B+)
- PN532 NFC/RFID Reader Module
- NFC cards (Mifare Classic 1K or Ultralight)
- Jumper wires for GPIO connection

**Wiring (I2C Connection)**
```
PN532 → Raspberry Pi
VCC   → 3.3V (Pin 1)
GND   → Ground (Pin 6)
SDA   → GPIO 2 (Pin 3)
SCL   → GPIO 3 (Pin 5)
```

**Enable I2C on Raspberry Pi**
```bash
sudo raspi-config
# Interface Options → I2C → Enable
```

### Software Installation

**Backend (Raspberry Pi)**
```bash
# Install system dependencies
sudo apt update
sudo apt install python3-pip libnfc-bin libnfc-dev

# Clone repository
git clone https://github.com/sebaszap123-dev/monopoly-banker-nfc.git
cd monopoly-banker-nfc

# Install Python dependencies
pip3 install -r requirements.txt

# Start Flask server
python3 server.py
# API running on http://raspberrypi.local:5000
```

**Frontend (Mobile Device)**
```bash
# Flutter setup
flutter pub get
flutter packages pub run build_runner build

# Run on connected device
flutter run

# Or build APK
flutter build apk --release
```

## API Endpoints

### Account Management
```bash
# Register new player card
POST /api/register
{
  "card_uid": "04:AB:CD:EF:12:34:80",
  "player_name": "Alice"
}

# Get player balance
GET /api/balance/{card_uid}
```

### Transactions
```bash
# Debit (charge player)
POST /api/transaction
{
  "card_uid": "04:AB:CD:EF:12:34:80",
  "amount": -200,
  "description": "Rent: Park Place"
}

# Credit (pay player)
POST /api/transaction
{
  "card_uid": "04:AB:CD:EF:12:34:80",
  "amount": 200,
  "description": "Pass GO"
}

# Player-to-player transfer
POST /api/transfer
{
  "from_card_uid": "04:AB:CD:EF:12:34:80",
  "to_card_uid": "04:FE:DC:BA:56:78:90",
  "amount": 150,
  "description": "Property purchase"
}
```

### Transaction History
```bash
# Get all transactions for player
GET /api/transactions/{card_uid}
```

## NFC Card Setup

**Programming Cards (Optional)**
```bash
# Use nfc-tools to write player data
nfc-mfclassic w a u cards/player1.mfd
```

**Card UID Format**: Standard ISO14443A UID (7 bytes, hex representation)

Example: `04:AB:CD:EF:12:34:80`

## Configuration

**Backend Settings** (`config.py`)
```python
# Database
DATABASE_PATH = 'monopoly_bank.db'

# Starting balance
INITIAL_BALANCE = 1500

# NFC Reader
NFC_DEVICE = 'pn532_i2c:/dev/i2c-1'

# API Server
HOST = '0.0.0.0'
PORT = 5000
```

**Flutter Configuration** (`lib/config.dart`)
```dart
// API endpoint (update with your Raspberry Pi IP)
const String API_BASE_URL = 'http://192.168.1.100:5000';
```

## Project Structure

```
monopoly-banker-nfc/
├── server.py                # Flask REST API
├── nfc_reader.py           # PN532 interface
├── database.py             # SQLite ORM
├── transaction_logic.py    # Banking operations
├── lib/                    # Flutter frontend
│   ├── screens/
│   │   ├── dashboard.dart  # Game master view
│   │   └── register.dart   # Player registration
│   ├── models/
│   │   └── transaction.dart
│   └── services/
│       └── api_service.dart
└── requirements.txt
```

## Troubleshooting

**NFC Reader Not Detected**
```bash
# Check I2C devices
i2cdetect -y 1
# PN532 should appear at address 0x24

# Test libnfc
nfc-scan-device
nfc-list
```

**Card Not Reading**
- Ensure card is within 4cm of reader
- Check PN532 power supply (3.3V, not 5V)
- Verify I2C wiring and connections

**API Connection Issues**
- Confirm Raspberry Pi IP address: `hostname -I`
- Check firewall rules: `sudo ufw allow 5000`
- Verify mobile device is on same network

## Future Enhancements

- [ ] Blockchain-based transaction ledger
- [ ] Multi-game session support
- [ ] NFC card encryption for security
- [ ] Web dashboard for desktop game master
- [ ] Sound effects and haptic feedback
- [ ] Automatic property ownership tracking

## Educational Value

This project demonstrates:
- **Hardware-software integration** patterns
- **RESTful API design** for IoT devices
- **Real-time data synchronization** techniques
- **NFC protocol implementation** with libnfc
- **Cross-platform mobile development** with Flutter

---

**Disclaimer:** This is an educational project. All rights to Monopoly and its trademarks are reserved by Hasbro, Inc.

**License:** MIT

**Stack:** Python, Flask, Flutter, Dart, Raspberry Pi, PN532, NFC/RFID, SQLite

**Hardware:** Raspberry Pi 4, PN532 NFC Module, Mifare Classic/Ultralight NFC Tags
