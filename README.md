# 🍽️ El Criollo Restaurant Database

**Complete SQL Server database schema for El Criollo Restaurant Management System**

## 📋 Project Overview

El Criollo is a Dominican restaurant management system that handles:
- Employee management with role-based access
- Real-time table management (10 tables)
- Dominican menu with 22+ traditional items
- Order processing and billing
- Reservation system with email automation

## 🗄️ Database Schema

### Tables Created:
1. **Usuarios** - Employee authentication and roles
2. **MESAS** - Restaurant table management
3. **PRODUCTOS** - Dominican menu items
4. **Pedidos** - Order management
5. **DETALLE_PEDIDOS** - Order line items
6. **FACTURAS** - Billing and payments
7. **RESERVAS** - Reservation system with email tracking

## 🚀 Quick Setup

### Prerequisites:
- SQL Server 2019+ 
- SQL Server Management Studio (SSMS)

### Installation:
1. Execute `scripts/01-create-database.sql`
2. Execute `scripts/02-create-tables.sql`

### Default Admin User:
- **Username:** thecuevas0123_
- **Password:** thepikachu0123_
- **Role:** Administrador

## 🏗️ Architecture

```
Frontend (React) ←→ API (C# .NET) ←→ Database (SQL Server)
```

## 🍖 Sample Data

The database includes:
- **10 restaurant tables** (Interior, Terraza, VIP)
- **22+ Dominican menu items** including:
  - Pollo Guisado, Pescado Frito, Chivo Guisado
  - Moro de Guandules, Yuca Hervida
  - Traditional beverages and desserts

## 🔄 Next Steps

1. ✅ Database schema complete
2. 🔄 C# .NET API integration
3. 🔄 Authentication system
4. 🔄 Email automation for reservations
5. 🔄 React frontend integration

## 👨‍💻 Author

**Josue Bernabe**
- Project: El Criollo Restaurant Management System
- Created: July 11, 2025

## 📄 License

This project is part of a learning portfolio for restaurant management systems.
