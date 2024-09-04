-- Pasi 1: Creación de la Base de Datos
-- CREAR UNA CARPETA EN C

CREATE DATABASE	 FastFoodDB
ON
(	NAME = 'FastFoodDB_Data',
	FILENAME = 'C:\SQL_DB\FastFoodDB_Data.mdf',
	SIZE = 50MB,
	MAXSIZE = 1GB,
	FILEGROWTH = 5MB )
LOG ON
(	NAME = 'Carrera_BD_Log.ldf',
	FILENAME = 'C:\SQL_DB\FastFoodDB_Data.ldf',
	SIZE = 50MB,
	MAXSIZE = 1GB,
	FILEGROWTH = 5MB );


-- Usar la Base de Datos
USE FastFoodDB;

SELECT NAME, database_id, create_date
FROM sys.databases
WHERE NAME = 'FastFoodDB';

-- Tabla Categorías
CREATE TABLE Categorias (
	CategoriaID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL
);


-- Tabla productos
CREATE TABLE Productos (
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100),
	CategoriaID INT,
	Precio DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);


--Tabla Sucursales
CREATE TABLE Sucursales (
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(100)
);

-- Tabla Empleados
CREATE TABLE Empleados (
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Posicion VARCHAR(100) NOT NULL,
	Departamento VARCHAR(100) NOT NULL,
	SucursalID INT,
	Rol VARCHAR(50) NOT NULL,
	FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID)
);

-- Tabla Clientes
CREATE TABLE Clientes (
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(100) NOT NULL
);


-- Tabla Origen Orden
CREATE TABLE  OrigenesOrden (
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(100) NOT NULL,
);


-- Tabla Tipos Pago
CREATE TABLE TiposPago (
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(100) NOT NULL
);


-- Tabla Mensajeros
CREATE TABLE Mensajeros (
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	EsExterno BIT NOT NULL
);


-- Tabla Ordenes
CREATE TABLE Ordenes (
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT, -- Empleado que toma la orden
	SucursalID INT, -- Donde se hace la venta
	MensajeroID INT, -- Externo o interno
	TipoPagoID INT,
	OrigenID INT, -- En línea, presencial, telefono
	HorarioVenta VARCHAR(100) NOT NULL, -- Mañana, tarde, noche
	TotalCompra DECIMAL(10,2) NOT NULL,
	KilometrosRecorrer DECIMAL(10,2), -- En caso de que sea a domicilio
	FechaDespacho DATETIME, -- En caso de que sea a domicilio (hora de despacho del pedido)
	FechaEntrega DATETIME, -- En caso de que sea a domicilio (horra de llegada del pedido)
	FechaOrdenTomada DATETIME NOT NULL, -- Hora y fecha de la toma del pedido
	FechaOrdenLista DATETIME, -- Hora y fecha que salio la orden de la cocina
	FOREIGN KEY (ClienteID) REFERENCES Clientes (ClienteID),
	FOREIGN KEY (EmpleadoID) REFERENCES Empleados (EmpleadoID),
	FOREIGN KEY (SucursalID) REFERENCES Sucursales (SucursalID),
	FOREIGN KEY (MensajeroID) REFERENCES Mensajeros (MensajeroID),
	FOREIGN KEY (TipoPagoID) REFERENCES TiposPago (TipoPagoID),
	FOREIGN KEY (OrigenID) REFERENCES OrigenesOrden (OrigenID)
);


-- Tabla Detalles Orden
CREATE TABLE DetallesOrden (
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID,ProductoID),
	FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID),
	FOREIGN KEY (ProductoID) REFERENCES Productos
);

