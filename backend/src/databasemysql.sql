--CREAMOS LA BASE DE DATOS
CREATE DATABASE DB_POS;

--indicamos que vamos a utilizar la base de datos
USE db_pos;

-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    correo VARCHAR(255),
    telefono VARCHAR(20),
    nombre_usuario VARCHAR(255) UNIQUE,
    contraseña VARCHAR(255) NOT NULL
);

-- Crear la tabla de ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha_venta DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Crear la tabla de proveedores
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    contacto VARCHAR(255),
    telefono VARCHAR(20)
);

-- Crear la tabla de inventario
CREATE TABLE inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(255),
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    id_proveedor INT,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id)
);

-- Crear la tabla de reportes
CREATE TABLE reportes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    id_inventario INT,
    cantidad_vendida INT,
    FOREIGN KEY (id_venta) REFERENCES ventas(id),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id)
);

-- Crear la tabla de roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255)
);

-- Insertar roles iniciales
INSERT INTO roles (nombre) VALUES ('Administrador'), ('Vendedor'), ('Cliente');

-- Crear tabla intermedia para la relación muchos a muchos entre usuarios y roles
CREATE TABLE usuario_roles (
    id_usuario INT,
    id_rol INT,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_rol) REFERENCES roles(id)
);

-- Insertar usuario administrador inicial con nombre de usuario
INSERT INTO usuarios (nombre, correo, telefono, nombre_usuario,contraseña)
VALUES ('Nombre del Administrador', 'admin@example.com', '123456789', 'admin','admin');

-- Insertar roles del usuario administrador
INSERT INTO usuario_roles (id_usuario, id_rol)
SELECT id, (SELECT id FROM roles WHERE nombre = 'Administrador')
FROM usuarios
WHERE nombre_usuario = 'admin';

-- Actualizar el nombre del usuario administrador
UPDATE usuarios
SET nombre = 'Nuevo Nombre del Administrador'
WHERE nombre_usuario = 'admin';
