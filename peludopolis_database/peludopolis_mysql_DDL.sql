-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS peludopolis_sistema_ventas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Usar la base de datos
USE peludopolis_sistema_ventas_db;

-- ===============================
-- Tabla: Usuarios
-- ===============================
CREATE TABLE IF NOT EXISTS usuarios (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    pass VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- Tabla: Clientes
-- ===============================
CREATE TABLE IF NOT EXISTS clientes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    dni BIGINT NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- Tabla: Proveedores
-- ===============================
CREATE TABLE IF NOT EXISTS proveedores (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ruc BIGINT NOT NULL UNIQUE,
    nombre VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===============================
-- Tabla: Productos
-- ===============================
CREATE TABLE IF NOT EXISTS productos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    nombre VARCHAR(200) NOT NULL,
    proveedor_id INT UNSIGNED NOT NULL,
    stock INT UNSIGNED NOT NULL DEFAULT 0,
    precio DECIMAL(10,2) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- ===============================
-- Tabla: Ventas
-- ===============================
CREATE TABLE IF NOT EXISTS ventas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    vendedor_id INT UNSIGNED NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    fecha VARCHAR(20) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (vendedor_id) REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- ===============================
-- Tabla: Detalle de Ventas
-- ===============================
CREATE TABLE IF NOT EXISTS detalle_ventas (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo_producto INT UNSIGNED NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    id_venta INT UNSIGNED NOT NULL,
    FOREIGN KEY (codigo_producto) REFERENCES productos(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_venta) REFERENCES ventas(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ===============================
-- Tabla: Configuración del sistema
-- ===============================
CREATE TABLE IF NOT EXISTS config (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(200) NOT NULL,
    ruc VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
