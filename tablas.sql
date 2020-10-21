-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.35-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para bd_autobuses_dmn
DROP DATABASE IF EXISTS `bd_autobuses_dmn`;
CREATE DATABASE IF NOT EXISTS `bd_autobuses_dmn` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bd_autobuses_dmn`;

-- Volcando estructura para tabla bd_autobuses_dmn.administrador
DROP TABLE IF EXISTS `administrador`;
CREATE TABLE IF NOT EXISTS `administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.administrador: ~0 rows (aproximadamente)
DELETE FROM `administrador`;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` (`id`, `nombre`, `password`) VALUES
	(1, 'diego', 'diego');
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.cliente
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numeroIdentificacion` varchar(9) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `domicilio` varchar(50) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numeroIdentificacion` (`numeroIdentificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.cliente: ~0 rows (aproximadamente)
DELETE FROM `cliente`;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` (`id`, `numeroIdentificacion`, `nombre`, `apellidos`, `domicilio`, `correo`, `telefono`, `password`) VALUES
	(84, '11111111A', 'diego', 'maestro navarro', 'calle', 'diego@gmail', '123', '202cb962ac59075b964b07152d234b70');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.compra
DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_viaje` int(11) NOT NULL,
  `id_tarjeta` int(11) NOT NULL,
  `fechaPago` date NOT NULL,
  `importe` float NOT NULL,
  `numeroViajeros` int(11) NOT NULL,
  `localizador` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `localizador` (`localizador`),
  KEY `FK_compra_tarjeta` (`id_tarjeta`),
  KEY `FK_compra_viaje` (`id_viaje`),
  CONSTRAINT `FK_compra_tarjeta` FOREIGN KEY (`id_tarjeta`) REFERENCES `tarjeta` (`id`),
  CONSTRAINT `FK_compra_viaje` FOREIGN KEY (`id_viaje`) REFERENCES `viaje` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.compra: ~0 rows (aproximadamente)
DELETE FROM `compra`;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` (`id`, `id_viaje`, `id_tarjeta`, `fechaPago`, `importe`, `numeroViajeros`, `localizador`) VALUES
	(278, 66, 57, '2019-03-13', 20, 2, 'YtnMvgby'),
	(279, 69, 57, '2019-03-13', 7, 1, 'haBbMvXC'),
	(280, 70, 57, '2019-03-13', 20, 2, 'x7xR9Ywr');
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.compra_backup
DROP TABLE IF EXISTS `compra_backup`;
CREATE TABLE IF NOT EXISTS `compra_backup` (
  `id` int(11) NOT NULL,
  `id_viaje` int(11) NOT NULL,
  `id_tarjeta` int(11) NOT NULL,
  `fechaPago` date NOT NULL,
  `importe` float NOT NULL,
  `numeroViajeros` int(11) NOT NULL,
  `localizador` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `localizador` (`localizador`),
  KEY `FK_compra_backup_viaje_backup` (`id_viaje`),
  KEY `FK_compra_backup_tarjeta` (`id_tarjeta`),
  CONSTRAINT `FK_compra_backup_tarjeta` FOREIGN KEY (`id_tarjeta`) REFERENCES `tarjeta` (`id`),
  CONSTRAINT `FK_compra_backup_viaje_backup` FOREIGN KEY (`id_viaje`) REFERENCES `viaje_backup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.compra_backup: ~0 rows (aproximadamente)
DELETE FROM `compra_backup`;
/*!40000 ALTER TABLE `compra_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra_backup` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.empresa
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CIF` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` int(9) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `logo` varchar(50) NOT NULL,
  `numeroPlazas` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CIF` (`CIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.empresa: ~0 rows (aproximadamente)
DELETE FROM `empresa`;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.estacion
DROP TABLE IF EXISTS `estacion`;
CREATE TABLE IF NOT EXISTS `estacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEstacion` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombreEstacion` (`nombreEstacion`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.estacion: ~6 rows (aproximadamente)
DELETE FROM `estacion`;
/*!40000 ALTER TABLE `estacion` DISABLE KEYS */;
INSERT INTO `estacion` (`id`, `nombreEstacion`, `direccion`) VALUES
	(1, 'Albacete', '1'),
	(2, 'Villarobledo', '2'),
	(3, 'Hellín', '3'),
	(4, 'Almansa', '4'),
	(5, 'Riópar', '5'),
	(7, 'Ayna', '6');
/*!40000 ALTER TABLE `estacion` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.horario
DROP TABLE IF EXISTS `horario`;
CREATE TABLE IF NOT EXISTS `horario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ruta` int(11) NOT NULL,
  `horaSalida` time NOT NULL,
  `horaLlegada` time NOT NULL,
  `dia` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_horario_ruta` (`id_ruta`),
  CONSTRAINT `FK_horario_ruta` FOREIGN KEY (`id_ruta`) REFERENCES `ruta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.horario: ~20 rows (aproximadamente)
DELETE FROM `horario`;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` (`id`, `id_ruta`, `horaSalida`, `horaLlegada`, `dia`) VALUES
	(25, 3, '08:00:00', '09:30:00', 'M'),
	(26, 3, '19:30:00', '21:00:00', 'M'),
	(27, 5, '09:00:00', '09:50:00', 'X'),
	(28, 5, '18:00:00', '18:50:00', 'X'),
	(29, 6, '09:00:00', '10:00:00', 'J'),
	(30, 6, '19:00:00', '20:00:00', 'J'),
	(31, 7, '07:00:00', '08:50:00', 'V'),
	(32, 7, '20:00:00', '21:50:00', 'V'),
	(33, 8, '06:00:00', '06:50:00', 'S'),
	(34, 8, '18:00:00', '18:50:00', 'S'),
	(35, 11, '09:30:00', '11:00:00', 'L'),
	(37, 11, '10:30:00', '23:00:00', 'L'),
	(38, 12, '07:00:00', '07:50:00', 'M'),
	(39, 12, '17:00:00', '17:50:00', 'M'),
	(40, 13, '09:00:00', '10:00:00', 'X'),
	(41, 13, '18:00:00', '19:00:00', 'X'),
	(42, 16, '08:00:00', '09:50:00', 'J'),
	(43, 16, '09:10:00', '11:00:00', 'J'),
	(44, 17, '09:00:00', '09:50:00', 'V'),
	(45, 17, '20:00:00', '20:50:00', 'V');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.ocupacion
DROP TABLE IF EXISTS `ocupacion`;
CREATE TABLE IF NOT EXISTS `ocupacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_viajero` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `numeroAsiento` int(11) NOT NULL,
  `importe` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viajero` (`id_viajero`,`id_compra`,`numeroAsiento`),
  KEY `FK_ocupacion_compra` (`id_compra`),
  CONSTRAINT `FK_ocupacion_compra` FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id`),
  CONSTRAINT `FK_ocupacion_viajero` FOREIGN KEY (`id_viajero`) REFERENCES `viajero` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.ocupacion: ~0 rows (aproximadamente)
DELETE FROM `ocupacion`;
/*!40000 ALTER TABLE `ocupacion` DISABLE KEYS */;
INSERT INTO `ocupacion` (`id`, `id_viajero`, `id_compra`, `numeroAsiento`, `importe`) VALUES
	(421, 101, 278, 1, 10),
	(422, 102, 278, 2, 10),
	(423, 103, 279, 1, 7),
	(424, 104, 280, 1, 10),
	(425, 105, 280, 2, 10);
/*!40000 ALTER TABLE `ocupacion` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.ocupacion_backup
DROP TABLE IF EXISTS `ocupacion_backup`;
CREATE TABLE IF NOT EXISTS `ocupacion_backup` (
  `id` int(11) NOT NULL,
  `id_viajero` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `numeroAsiento` int(11) NOT NULL,
  `importe` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_viajero` (`id_viajero`,`id_compra`,`numeroAsiento`),
  KEY `FK_ocupacion_backup_compra` (`id_compra`),
  CONSTRAINT `FK_ocupacion_backup_compra` FOREIGN KEY (`id_compra`) REFERENCES `compra_backup` (`id`),
  CONSTRAINT `FK_ocupacion_backup_viajero_backup` FOREIGN KEY (`id_viajero`) REFERENCES `viajero_backup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.ocupacion_backup: ~0 rows (aproximadamente)
DELETE FROM `ocupacion_backup`;
/*!40000 ALTER TABLE `ocupacion_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocupacion_backup` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.ruta
DROP TABLE IF EXISTS `ruta`;
CREATE TABLE IF NOT EXISTS `ruta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estacion_origen` int(11) NOT NULL,
  `estacion_destino` int(11) NOT NULL,
  `distancia` float NOT NULL,
  `tiempoEstimado` varchar(50) NOT NULL,
  `precio` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ruta_estacion` (`estacion_destino`),
  KEY `FK_ruta_estacion_2` (`estacion_origen`),
  CONSTRAINT `FK_ruta_estacion` FOREIGN KEY (`estacion_destino`) REFERENCES `estacion` (`id`),
  CONSTRAINT `FK_ruta_estacion_2` FOREIGN KEY (`estacion_origen`) REFERENCES `estacion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.ruta: ~10 rows (aproximadamente)
DELETE FROM `ruta`;
/*!40000 ALTER TABLE `ruta` DISABLE KEYS */;
INSERT INTO `ruta` (`id`, `estacion_origen`, `estacion_destino`, `distancia`, `tiempoEstimado`, `precio`) VALUES
	(3, 1, 2, 91, '90 min', 10),
	(5, 1, 3, 61, '50 min', 7),
	(6, 1, 4, 72, '1 Hora', 8),
	(7, 1, 5, 133, '110 min', 14),
	(8, 1, 7, 61, '50 min', 7),
	(11, 2, 1, 91, '90 min', 10),
	(12, 3, 1, 61, '50 min', 7),
	(13, 4, 1, 72, '1 Hora', 8),
	(16, 5, 1, 133, '110 min', 14),
	(17, 7, 1, 61, '50 min', 7);
/*!40000 ALTER TABLE `ruta` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.tarjeta
DROP TABLE IF EXISTS `tarjeta`;
CREATE TABLE IF NOT EXISTS `tarjeta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `numero` varchar(50) NOT NULL,
  `caducidad` date NOT NULL,
  `CVV` int(4) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero` (`numero`),
  KEY `FK_tarjeta_cliente` (`id_cliente`),
  CONSTRAINT `FK_tarjeta_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.tarjeta: ~0 rows (aproximadamente)
DELETE FROM `tarjeta`;
/*!40000 ALTER TABLE `tarjeta` DISABLE KEYS */;
INSERT INTO `tarjeta` (`id`, `tipo`, `numero`, `caducidad`, `CVV`, `id_cliente`) VALUES
	(57, 'MasterCard', '1234523455432123', '2020-01-01', 123, 84);
/*!40000 ALTER TABLE `tarjeta` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.viaje
DROP TABLE IF EXISTS `viaje`;
CREATE TABLE IF NOT EXISTS `viaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_horario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `plazas_disponibles` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_viaje_horario` (`id_horario`),
  CONSTRAINT `FK_viaje_horario` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.viaje: ~20 rows (aproximadamente)
DELETE FROM `viaje`;
/*!40000 ALTER TABLE `viaje` DISABLE KEYS */;
INSERT INTO `viaje` (`id`, `id_horario`, `fecha`, `plazas_disponibles`) VALUES
	(66, 35, '2019-02-04', 6),
	(67, 37, '2019-02-04', 8),
	(68, 39, '2019-02-05', 8),
	(69, 38, '2019-02-05', 7),
	(70, 25, '2019-02-05', 6),
	(71, 26, '2019-02-05', 8),
	(72, 28, '2019-02-06', 8),
	(73, 41, '2019-02-06', 8),
	(74, 27, '2019-02-06', 8),
	(75, 40, '2019-02-06', 8),
	(76, 43, '2019-02-07', 8),
	(77, 42, '2019-02-07', 8),
	(79, 29, '2019-02-07', 8),
	(80, 30, '2019-02-07', 8),
	(81, 44, '2019-02-08', 8),
	(82, 45, '2019-02-08', 8),
	(83, 31, '2019-02-08', 8),
	(84, 32, '2019-02-08', 8),
	(85, 34, '2019-02-09', 8),
	(86, 33, '2019-02-09', 8);
/*!40000 ALTER TABLE `viaje` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.viajero
DROP TABLE IF EXISTS `viajero`;
CREATE TABLE IF NOT EXISTS `viajero` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numeroIdentificacion` varchar(9) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numeroIdentificacion` (`numeroIdentificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.viajero: ~0 rows (aproximadamente)
DELETE FROM `viajero`;
/*!40000 ALTER TABLE `viajero` DISABLE KEYS */;
INSERT INTO `viajero` (`id`, `numeroIdentificacion`, `nombre`, `apellidos`) VALUES
	(101, '11111111A', 'diego', 'maestro'),
	(102, '11111111B', 'ana', 'navarro'),
	(103, '33333333A', 'juan', 'maestro'),
	(104, '44444444A', 'ana', 'mklm'),
	(105, '55555555B', 'diego', 'maestro navarro');
/*!40000 ALTER TABLE `viajero` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.viajero_backup
DROP TABLE IF EXISTS `viajero_backup`;
CREATE TABLE IF NOT EXISTS `viajero_backup` (
  `id` int(11) NOT NULL,
  `numeroIdentificacion` varchar(9) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numeroIdentificacion` (`numeroIdentificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.viajero_backup: ~0 rows (aproximadamente)
DELETE FROM `viajero_backup`;
/*!40000 ALTER TABLE `viajero_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `viajero_backup` ENABLE KEYS */;

-- Volcando estructura para tabla bd_autobuses_dmn.viaje_backup
DROP TABLE IF EXISTS `viaje_backup`;
CREATE TABLE IF NOT EXISTS `viaje_backup` (
  `id` int(11) NOT NULL,
  `id_horario` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `plazasLibres` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_viaje_backup_horario` (`id_horario`),
  CONSTRAINT `FK_viaje_backup_horario` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bd_autobuses_dmn.viaje_backup: ~0 rows (aproximadamente)
DELETE FROM `viaje_backup`;
/*!40000 ALTER TABLE `viaje_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `viaje_backup` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
