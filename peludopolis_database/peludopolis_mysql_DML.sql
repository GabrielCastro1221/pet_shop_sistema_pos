-- Seleccionar la base de datos
USE peludopolis_sistema_ventas_db;

-- =========================================
-- INSERTAR USUARIOS (con roles)
-- =========================================
INSERT INTO usuarios (nombre, correo, pass, rol)
VALUES 
('Gabriel Rodríguez', 'gabriel@example.com', 'password123', 'vendedor'),
('Juan López', 'juan@example.com', 'admin123', 'admin'),
('Laura Martínez', 'laura@example.com', 'cliente456', 'cliente'),
('Sofía Torres', 'sofia@example.com', 'sofia123', 'vendedor'),
('Pedro Ramírez', 'pedro@example.com', 'pedro123', 'admin'),
('Lucía Gómez', 'lucia@example.com', 'lucia123', 'cliente');

-- =========================================
-- INSERTAR CLIENTES
-- =========================================
INSERT INTO clientes (dni, nombre, telefono, direccion, razon_social)
VALUES 
(1234567890, 'Ana Pérez', '3124567890', 'Calle 123, Bogotá', 'Comercio S.A.'),
(987654321, 'Carlos Gómez', '3119876543', 'Carrera 45 #12-34, Medellín', 'Tienda Don Carlos'),
(555666777, 'María Ramírez', '3103456789', 'Calle 77, Cali', 'Veterinaria PetCare'),
(111222333, 'Jorge Velásquez', '3101234567', 'Av. Principal 456, Barranquilla', 'Distribuciones Jorge'),
(444555666, 'Diana Ríos', '3117654321', 'Calle Luna #98, Bucaramanga', 'Mascotas Felices S.A.S.');

-- =========================================
-- INSERTAR PROVEEDORES
-- =========================================
INSERT INTO proveedores (ruc, nombre, telefono, direccion, razon_social)
VALUES 
(987654321, 'Proveedor XYZ', '3149876543', 'Av. Central 456, Medellín', 'Distribuidor XYZ'),
(123123123, 'PetSuppliers S.A.', '3176543210', 'Calle Mascotas 321, Bogotá', 'Importadora PetSuppliers'),
(111222111, 'Distribuidora Animalia', '3127654321', 'Cra 45 #12, Cali', 'Animalia Ltda.'),
(999888777, 'PetComercial', '3186547890', 'Transversal 12 #56, Medellín', 'PetComercial S.A.');

-- =========================================
-- INSERTAR PRODUCTOS
-- =========================================
INSERT INTO productos (codigo, nombre, proveedor_id, stock, precio)
VALUES 
('001', 'Alimento para perros', 1, 50, 35.99),
('002', 'Collar para gato', 2, 30, 12.50),
('003', 'Shampoo para perros', 1, 20, 19.99),
('004', 'Rascador para gato', 2, 10, 45.00),
('005', 'Cepillo dental para perro', 3, 100, 8.99),
('006', 'Snacks para gatos', 3, 60, 15.00),
('007', 'Arena para gatos', 2, 80, 25.00),
('008', 'Juguete de caucho para perros', 1, 40, 18.75),
('009', 'Transportadora mediana', 4, 20, 55.00);

-- =========================================
-- INSERTAR CONFIGURACIÓN DE EMPRESA
-- =========================================
INSERT INTO config (nombre_empresa, ruc, telefono, direccion, razon_social)
VALUES 
('Peludopolis', '123456789', '3124567890', 'Av. Mascotas 789, Cali', 'Peludopolis S.A.S.');

-- =========================================
-- INSERTAR VENTAS
-- =========================================
INSERT INTO ventas (cliente_id, vendedor_id, total, fecha)
VALUES 
(1, 2, 150.00, '2025-06-17'),
(2, 1, 90.00, '2025-06-16'),
(3, 4, 120.00, '2025-06-15'),
(4, 5, 200.00, '2025-06-14'),
(5, 1, 75.50, '2025-06-13');

-- =========================================
-- INSERTAR DETALLES DE VENTA
-- =========================================
INSERT INTO detalle_ventas (codigo_producto, cantidad, precio, id_venta)
VALUES 
(1, 2, 35.99, 1), -- 2 alimentos para perros
(2, 1, 12.50, 1), -- 1 collar
(3, 2, 19.99, 2), -- 2 shampoo
(4, 1, 45.00, 3), -- 1 rascador
(5, 5, 8.99, 4), -- 5 cepillos dentales
(6, 3, 15.00, 4), -- 3 snacks gatos
(7, 2, 25.00, 5), -- 2 arenas
(8, 1, 18.75, 5); -- 1 juguete caucho

-- =========================================
-- ACTUALIZACIONES
-- =========================================
UPDATE usuarios SET nombre = 'Gabriel R.' WHERE correo = 'gabriel@example.com';
UPDATE productos SET stock = stock - 2 WHERE codigo = '001'; -- tras venta
UPDATE clientes SET telefono = '3157894560' WHERE dni = 1234567890;

-- =========================================
-- ELIMINACIONES
-- =========================================
DELETE FROM usuarios WHERE correo = 'laura@example.com';
DELETE FROM productos WHERE codigo = '004';
DELETE FROM ventas WHERE id = 2;

-- =========================================
-- CONSULTAS SELECT
-- =========================================

-- Todos los usuarios
SELECT * FROM usuarios;

-- Productos disponibles en stock
SELECT * FROM productos WHERE stock > 0;

-- Ventas hechas por un vendedor específico
SELECT * FROM ventas WHERE vendedor_id = 2;

-- Detalle de una venta específica
SELECT dv.*, p.nombre AS nombre_producto
FROM detalle_ventas dv
JOIN productos p ON dv.codigo_producto = p.id
WHERE dv.id_venta = 1;

-- Clientes con nombre que empieza con 'A'
SELECT * FROM clientes WHERE nombre LIKE 'A%';

-- Listado de productos con precios mayores a 20
SELECT * FROM productos WHERE precio > 20;

-- Total de ventas por vendedor
SELECT u.nombre AS vendedor, SUM(v.total) AS total_vendido
FROM ventas v
JOIN usuarios u ON v.vendedor_id = u.id
GROUP BY u.nombre;

-- Cantidad total de productos vendidos por producto
SELECT p.nombre, SUM(dv.cantidad) AS cantidad_total
FROM detalle_ventas dv
JOIN productos p ON dv.codigo_producto = p.id
GROUP BY p.nombre;
