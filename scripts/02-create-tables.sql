-- EL CRIOLLO RESTAURANT - COMPLETE DATABASE SCHEMA
-- Author: Josue Bernabe
-- Created: July 14, 2025
-- Description: Complete table schema for El Criollo Restaurant Management System
-- Dependencies: 01-create-database.sql must be executed first
-- Use the database 
USE RestaurantelCriollo;
-- ============================================================================
-- 1. TABLA USUARIOS - Employee Management System
-- ============================================================================

CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    NombreCompleto NVARCHAR(100) NOT NULL UNIQUE,
    Email NVARCHAR(200) NOT NULL UNIQUE,
    Contraseña NVARCHAR(200) NOT NULL,
    Role VARCHAR(200) NOT NULL CHECK(Role IN('Administrador','Mesero','Recepcionista','Cajero')),
    Activo BIT DEFAULT 1,
    FechaCreacion DATETIME DEFAULT GETDATE()
);

INSERT INTO Usuarios(NombreCompleto, Email, Contraseña, Role)
VALUES('thecuevas0123_', 'admin@elcriollo.com', 'thepikachu0123_', 'Administrador');
PRINT '✅ Table Usuarios created with default admin user';
-- ============================================================================
-- 2. TABLA MESAS - Restaurant Table Management
-- ============================================================================
CREATE TABLE MESAS (
    MESAID INT PRIMARY KEY IDENTITY(1,1),
    NumeroMesas INT NOT NULL UNIQUE,
    Capacidad INT NOT NULL,
    Ubicacion NVARCHAR(50),
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Libre'
        CHECK (Estado IN('Libre', 'Ocupada', 'Reservada')),
    FechaCreacion DATETIME DEFAULT GETDATE()
);
INSERT INTO MESAS(NumeroMesas, Capacidad, Ubicacion) VALUES
(1,4, 'INTERIOR'), (2,4, 'INTERIOR'), (3,6, 'INTERIOR'),
(4,6, 'TERRAZA'), (5,8, 'VIP'), (6,4, 'TERRAZA'),
(7,4, 'INTERIOR'), (8,6, 'INTERIOR'), (9,2, 'TERRAZA'), (10,2, 'INTERIOR');
PRINT '✅ Table MESAS created with 10 restaurant tables';
-- ============================================================================
-- 3. TABLA PRODUCTOS - Menu Management System
-- ============================================================================
CREATE TABLE PRODUCTOS (
    ProductosID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(100) NOT NULL,
    Categoria NVARCHAR(50) 
        CHECK (Categoria IN ('Entradas', 'Plato Principal', 'Acompañante', 'Bebidas', 'Bebidas Alcoholica', 'Postres')),
    Precio DECIMAL(10,2),
    Disponible BIT DEFAULT 1,
    FechasCreacion DATETIME DEFAULT GETDATE(),
    FechaModificacion DATETIME DEFAULT GETDATE()
);
INSERT INTO PRODUCTOS (NombreProducto, Descripcion, Categoria, Precio) VALUES
-- ENTRADAS
('Croquetas de Yuca', 'Deliciosas croquetas de yuca con queso fritas hasta dorar', 'Entradas', 180.00),
('Chicharrones de Pollo', 'Trozos de pollo marinados y fritos estilo dominicano', 'Entradas', 220.00),
('Tostones Rellenos', 'Tostones crujientes rellenos de pollo desmenuzado', 'Entradas', 250.00),
-- PLATOS PRINCIPALES
('Pollo Guisado', 'Pollo criollo guisado con vegetales y especias dominicanas', 'Plato Principal', 450.00),
('Pescado Frito', 'Pescado fresco frito con mojo de ajo y cebolla', 'Plato Principal', 520.00),
('Chivo Guisado', 'Chivo tierno guisado con cilantro ancho y especias', 'Plato Principal', 680.00),
('Pollo al Horno', 'Pollo horneado con hierbas y vegetales asados', 'Plato Principal', 480.00),
('Costillas BBQ', 'Costillas de cerdo con salsa barbacoa criolla', 'Plato Principal', 720.00),
-- ACOMPAÑANTES
('Moro de Guandules', 'Arroz con guandules el acompañante perfecto', 'Acompañante', 120.00),
('Moro de Habichuelas', 'Arroz con habichuelas rojas estilo dominicano', 'Acompañante', 120.00),
('Yuca Hervida', 'Yuca tierna hervida con cebollitas salteadas', 'Acompañante', 100.00),
('Platano Maduro', 'Platanos maduros fritos dulces y caramelizados', 'Acompañante', 80.00),
('Ensalada Verde', 'Lechuga tomate pepino con aderezo de la casa', 'Acompañante', 150.00),
-- POSTRES
('Tres Golpes Dulce', 'Postre tradicional dominicano con coco y canela', 'Postres', 180.00),
('Flan de Coco', 'Flan casero con leche de coco y caramelo', 'Postres', 200.00),
('Majarete', 'Postre de maiz con leche canela y pasas', 'Postres', 160.00),
-- BEBIDAS
('Jugo de Chinola', 'Jugo natural de maracuya refrescante', 'Bebidas', 120.00),
('Jugo de Tamarindo', 'Bebida tradicional dominicana agridulce', 'Bebidas', 120.00),
('Refresco Nacional', 'Refrescos variados nacionales', 'Bebidas', 80.00),
('Agua Mineral', 'Agua embotellada nacional', 'Bebidas', 60.00),
('Cafe Dominicano', 'Cafe negro tradicional dominicano', 'Bebidas', 90.00),
-- BEBIDAS ALCOHOLICAS
('Cerveza Presidente', 'Cerveza nacional dominicana', 'Bebidas Alcoholica', 150.00),
('Ron con Cola', 'Ron dominicano con refresco de cola', 'Bebidas Alcoholica', 200.00),
('Mamajuana', 'Bebida tradicional dominicana con hierbas', 'Bebidas Alcoholica', 280.00);
PRINT '✅ Table PRODUCTOS created with Dominican menu items';

-- ============================================================================
-- 4. TABLA PEDIDOS - Order Management System
-- ============================================================================
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    MESAID INT NOT NULL,
    UsuarioID INT NOT NULL,
    FechaPedido DATETIME NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Activo'
        CHECK (Estado IN('Activo', 'Completado', 'Cancelado', 'Facturado')),
    Total DECIMAL(10,2) DEFAULT 0.00,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MESAID) REFERENCES MESAS(MESAID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);
PRINT '✅ Table Pedidos created with foreign key relationships';
-- ============================================================================
-- 5. TABLA DETALLE_PEDIDOS - Order Line Items
-- ============================================================================
CREATE TABLE DETALLE_PEDIDOS (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT NOT NULL,
    ProductosID INT NOT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    subtotal AS (Cantidad * PrecioUnitario),
    ObservacionesDetalle NVARCHAR(200),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProductosID) REFERENCES PRODUCTOS (ProductosID)
);
PRINT '✅ Table DETALLE_PEDIDOS created with calculated subtotal column';
--============================================================================
-- 6. TABLA FACTURAS - Billing Management System
--============================================================================
CREATE TABLE FACTURAS (
    FacturaID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT NOT NULL,
    ITBIS DECIMAL(10,2) NOT NULL,
    TotalFinal DECIMAL(10,2) DEFAULT 0.00,
    MetodoPago NVARCHAR(200) NOT NULL
        CHECK (MetodoPago IN('Efectivo','Tarjeta', 'Transferencia')),
    FechaFacturacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);

PRINT '✅ Table FACTURAS created with payment method validation';
--=============================================================================
-- 7. TABLA RESERVAS - Reservation and Email Management System
--=============================================================================
CREATE TABLE RESERVAS (
    ReservaID INT PRIMARY KEY IDENTITY(1,1),
    MESAID INT NOT NULL,
    NombreCliente NVARCHAR(100),
    Email NVARCHAR(255),
    Telefono NVARCHAR(20),
    CantidadPersonas INT NOT NULL,
    FechaReserva DATE NOT NULL,
    HoraReserva TIME NOT NULL,
    Estado NVARCHAR(20) DEFAULT 'Pendiente'
        CHECK (Estado IN('Pendiente', 'Confirmada', 'Cancelada')),
    CorreoEnviado BIT DEFAULT 0,
    FechaEnvioCorreo DATETIME NULL,
    ObservacionesReserva NVARCHAR(500),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MESAID) REFERENCES MESAS(MESAID)
);

PRINT '✅ Table RESERVAS created with email automation support';
--===============================================================================
-- DATABASE SCHEMA CREATION COMPLETE
--================================================================================
PRINT '';
PRINT '🎉 ===== EL CRIOLLO DATABASE SCHEMA COMPLETE =====';
PRINT '📊 Total Tables Created: 7';
PRINT '🔗 Foreign Key Relationships: 6';
PRINT '✅ Admin User: thecuevas0123_ / thepikachu0123_';
PRINT '🍽️ Sample Tables: 10 restaurant tables';
PRINT ' Sample Products: 22 Dominican menu items';
PRINT '💰 Ready for C# backend integration';
