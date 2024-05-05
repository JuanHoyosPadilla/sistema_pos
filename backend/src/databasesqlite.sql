-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT,
    correo TEXT,
    telefono TEXT,
    nombre_usuario TEXT UNIQUE
);

-- Crear la tabla de ventas
CREATE TABLE ventas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    fecha_venta DATE,
    total NUMERIC(10, 2),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Crear la tabla de proveedores
CREATE TABLE proveedores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT,
    contacto TEXT,
    telefono TEXT
);

-- Crear la tabla de inventario
CREATE TABLE inventario (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_producto TEXT,
    cantidad INTEGER,
    precio_unitario NUMERIC(10, 2),
    id_proveedor INTEGER,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id)
);

-- Crear la tabla de reportes
CREATE TABLE reportes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta INTEGER,
    id_inventario INTEGER,
    cantidad_vendida INTEGER,
    FOREIGN KEY (id_venta) REFERENCES ventas(id),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id)
);

-- Crear la tabla de roles
CREATE TABLE roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT
);

-- Insertar roles iniciales
INSERT INTO roles (nombre) VALUES ('Administrador'), ('Vendedor'), ('Cliente');

-- Crear tabla intermedia para la relación muchos a muchos entre usuarios y roles
CREATE TABLE usuario_roles (
    id_usuario INTEGER,
    id_rol INTEGER,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_rol) REFERENCES roles(id)
);

-- Insertar usuario administrador inicial con nombre de usuario
INSERT INTO usuarios (nombre, correo, telefono, nombre_usuario)
VALUES ('Nombre del Administrador', 'admin@example.com', '123456789', 'admin');

-- Insertar roles del usuario administrador
INSERT INTO usuario_roles (id_usuario, id_rol)
SELECT id, (SELECT id FROM roles WHERE nombre = 'Administrador')
FROM usuarios
WHERE nombre_usuario = 'admin';

-- Actualizar el nombre del usuario administrador
UPDATE usuarios
SET nombre = 'Nuevo Nombre del Administrador'
WHERE nombre_usuario = 'admin';
