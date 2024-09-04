-- Usar la Base de Datos
USE FastFoodDB;


-- Pregunta: ¿Cuál es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) AS VentasNivelGlobal
FROM Ordenes;


-- Pregunta: ¿Cuál es  el precio promedio de los productos dentro de cada categoría?

SELECT CategoriaID, CAST(AVG(Precio) AS DECIMAL(10,2)) 'Precio Promedio'
FROM Productos
GROUP BY CategoriaID
ORDER BY 'Precio promedio' DESC;


-- Pregunta: ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?

SELECT SucursalID, MIN(TotalCompra) AS Minimo, MAX(TotalCompra) AS Maximo
FROM Ordenes
GROUP BY SucursalID;


-- Pregunta: ¿Cuál es el mayor número de kilómetros recorridos para una entrega?

SELECT MAX(KilometrosRecorrer) AS 'Máximo' -- si le quiero asignar un alias con tilde, tengo que usar comillas
FROM Ordenes;


-- Pregunta: ¿Cuál es la cantidad promedio de productos por orden?

SELECT OrdenID, AVG(Cantidad) AS PromedioCantidadProducto
FROM DetallesOrden
GROUP BY OrdenID;


-- Pregunta: ¿Cuál es el total de ventas por cada tipo de pago?

SELECT TipoPagoID, SUM(TotalCompra) AS TotalVenta
FROM Ordenes
GROUP BY TipoPagoID
ORDER BY TotalVenta DESC;


-- Pregunta: ¿Cuál sucursal tiene la venta promedio más alta?

SELECT TOP 1 SucursalID, CAST(AVG(TotalCompra) AS DECIMAL(10,2)) PromedioVenta
FROM Ordenes
GROUP BY SucursalID
ORDER BY PromedioVenta DESC;


-- Pregunta: ¿Cuáles son las sucursales que han generado ventas por orden por encima de $50. REVISAR EL CODE REVIEW 6  PARA VERIFICAR QUE ESTE BIEN PORQUE HUBIERON CAMBIOS

SELECT SucursalID, 
	SUM(TotalCompra) AS TotalVentas,
	COUNT(OrdenID) AS NumeroOrdenes,
	CAST(SUM(TotalCompra)/COUNT(OrdenID) AS DECIMAL(10,2)) AS PromedioVentaXOrden
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 50
ORDER BY TotalVentas DESC;


-- Pregunta: ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

SELECT 'Antes del 1 de julio de 2023' AS 'Período',
	CAST(AVG(TotalCompra) AS DECIMAL(10,2)) TotalVenta
FROM Ordenes
WHERE FechaOrdenTomada < '2023-07-01'
UNION  --Para usar el union las dos querys deben tener la misma estructura y el ALL incluye duplicados
SELECT 'Después del 1 de julio de 2023' AS 'Período',
	CAST(AVG(TotalCompra) AS DECIMAL(10,2)) TotalVenta
FROM Ordenes
WHERE FechaOrdenTomada > '2023-07-01';


--Pregunta: ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, cuál es el valor promedio de estas ventas, y cuál ha sido la venta máxima alcanzada?

SELECT HorarioVenta,
	COUNT(*) as CantidadVentas,
	CAST(AVG(TotalCompra) AS DECIMAL(10,2)) PromedioVentas,
	MAX(TotalCompra) VentaMaxima
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY CantidadVentas DESC;
