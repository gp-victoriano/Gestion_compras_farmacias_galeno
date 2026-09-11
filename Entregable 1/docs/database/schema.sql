-- Creación de Tablas
CREATE TABLE Proveedor (
    ID_Proveedor INT IDENTITY(1,1) PRIMARY KEY,
    NIT NVARCHAR(20) NOT NULL UNIQUE,
    DIRECCION NVARCHAR(150) NOT NULL,
    TELEFONO NVARCHAR(20),
    Estado BIT DEFAULT 1
);

CREATE TABLE Producto (
    ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Producto NVARCHAR(150) NOT NULL,
    RequiereReceta BIT DEFAULT 0,
    PrecioCostoUnitario DECIMAL(18,2) NOT NULL
);

CREATE TABLE OrdenCompra (
    ID_OrdenCompra INT IDENTITY(1,1) PRIMARY KEY,
    ID_Proveedor INT NOT NULL,
    FechaEmision DATETIME DEFAULT GETDATE(),
    Estado NVARCHAR(20) CHECK (Estado IN ('Pendiente', 'Aprobada', 'Recibida', 'Cancelada')),
    Total DECIMAL(18,2) NOT NULL,
    Observaciones NVARCHAR(500),
    CONSTRAINT FK_OrdenCompra_Proveedor FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor (ID_Proveedor)
);

CREATE TABLE DetalleOrdenCompra (
    ID_Detalle INT IDENTITY(1,1) PRIMARY KEY,
    ID_OrdenCompra INT NOT NULL,
    ID_Producto INT NOT NULL,
    CantidadSolicitada INT NOT NULL,
    PrecioCostoUnitario DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_Detalle_Orden FOREIGN KEY (ID_OrdenCompra) REFERENCES OrdenCompra (ID_OrdenCompra),
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (ID_Producto) REFERENCES Producto (ID_Producto)
);

-- Datos de Prueba (Seeds)
INSERT INTO Proveedor (NIT, DIRECCION, TELEFONO, Estado) VALUES ('7738291-0', 'Ciudad de Guatemala', '22001122', 1);
INSERT INTO Producto (Nombre_Producto, RequiereReceta, PrecioCostoUnitario) VALUES ('Paracetamol 500mg', 0, 10.50);