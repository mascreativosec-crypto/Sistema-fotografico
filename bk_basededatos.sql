-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.4.3 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para sys_fotografia
CREATE DATABASE IF NOT EXISTS `sys_fotografia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sys_fotografia`;

-- Volcando estructura para tabla sys_fotografia.cajas
CREATE TABLE IF NOT EXISTS `cajas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `monto_apertura` decimal(10,2) NOT NULL DEFAULT '300.00',
  `total_ingresos_efectivo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_ingresos_digital` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_egresos` decimal(10,2) NOT NULL DEFAULT '0.00',
  `saldo_esperado` decimal(10,2) NOT NULL DEFAULT '300.00',
  `estado` enum('Abierta','Cerrada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Abierta',
  `usuario_id` int NOT NULL,
  `notas` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Apertura de turno de estudio',
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `cajas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.cajas: ~0 rows (aproximadamente)
DELETE FROM `cajas`;
INSERT INTO `cajas` (`id`, `fecha`, `monto_apertura`, `total_ingresos_efectivo`, `total_ingresos_digital`, `total_egresos`, `saldo_esperado`, `estado`, `usuario_id`, `notas`) VALUES
	(1, '2026-10-08', 300.00, 200.00, 1380.00, 53.90, 446.10, 'Abierta', 1, 'Caja de turno matutino / vespertino en operación normal');

-- Volcando estructura para tabla sys_fotografia.caja_movimientos
CREATE TABLE IF NOT EXISTS `caja_movimientos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caja_id` int NOT NULL,
  `tipo` enum('Ingreso','Egreso') COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Efectivo',
  `comprobante` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `caja_id` (`caja_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `caja_movimientos_ibfk_1` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `caja_movimientos_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.caja_movimientos: ~3 rows (aproximadamente)
DELETE FROM `caja_movimientos`;
INSERT INTO `caja_movimientos` (`id`, `caja_id`, `tipo`, `categoria`, `concepto`, `monto`, `metodo_pago`, `comprobante`, `usuario_id`, `created_at`) VALUES
	(1, 1, 'Egreso', 'Insumos Estudio', 'Compra de baterías recargables Eneloop Pro AA y pilas 9V para disparadores', 38.90, 'Efectivo', 'B002-9912', 1, '2026-10-08 07:04:59'),
	(2, 1, 'Egreso', 'Cafetería Clientes', 'Agua mineral y café gourmet para sala de espera de novios', 15.00, 'Efectivo', 'Ticket-0091', 1, '2026-10-08 07:04:59'),
	(3, 1, 'Ingreso', 'Anticipo Sesión', 'Seña en efectivo Headshot Ejecutivo (SES-2026-084)', 200.00, 'Efectivo', 'REC-0012', 1, '2026-10-08 07:04:59');

-- Volcando estructura para tabla sys_fotografia.categorias_paquetes
CREATE TABLE IF NOT EXISTS `categorias_paquetes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icono` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'bi-camera',
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#d97706',
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.categorias_paquetes: ~5 rows (aproximadamente)
DELETE FROM `categorias_paquetes`;
INSERT INTO `categorias_paquetes` (`id`, `nombre`, `icono`, `color`, `descripcion`) VALUES
	(1, 'Bodas & Matrimonios', 'bi-hearts', '#f59e0b', 'Cobertura completa pre-boda, ceremonia y fiesta'),
	(2, 'Quinceañeras', 'bi-gem', '#e11d48', 'Sesiones temáticas, estudio y fiesta de 15 años'),
	(3, 'Newborn & Maternidad', 'bi-balloon-heart', '#0284c7', 'Fotografía especializada de recién nacidos y embarazo'),
	(4, 'Estudio & Retrato Fine Art', 'bi-person-bounding-box', '#b45309', 'Retrato artístico, graduaciones y fotos profesionales'),
	(5, 'Corporativo & Producto', 'bi-briefcase', '#059669', 'Catálogo publicitario, marcas y fotografía de negocios');

-- Volcando estructura para tabla sys_fotografia.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_doc` enum('DNI','RUC','CE','PASAPORTE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DNI',
  `num_doc` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `origen` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Instagram',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `acepta_marketing` tinyint(1) NOT NULL DEFAULT '1',
  `responsable_id` int DEFAULT NULL,
  `ultimo_contacto` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.clientes: ~5 rows (aproximadamente)
DELETE FROM `clientes`;
INSERT INTO `clientes` (`id`, `codigo`, `tipo_doc`, `num_doc`, `nombres`, `apellidos`, `telefono`, `email`, `direccion`, `fecha_nacimiento`, `origen`, `notas`, `estado`, `created_at`, `acepta_marketing`, `responsable_id`, `ultimo_contacto`) VALUES
	(1, 'CLI-001', 'DNI', '74839201', 'Lucía Fernanda', 'Morales Benítez', '993412567', 'lucia.morales@gmail.com', 'Calle Los Pinos 340, San Isidro', '1996-05-14', 'Instagram', 'Cliente de sesión premamá y seguimiento mensual de bebé', 1, '2026-10-08 07:04:59', 1, NULL, NULL),
	(2, 'CLI-002', 'DNI', '45892014', 'Alejandro y Daniela', 'Vargas & Ruiz', '981234567', 'boda.vargasruiz@gmail.com', 'Av. Primavera 1280, Surco', '1992-09-20', 'Recomendación', 'Boda Civil y Religiosa con cobertura Drone 4K', 1, '2026-10-08 07:04:59', 1, NULL, NULL),
	(3, 'CLI-003', 'DNI', '78901234', 'Camila Nicole', 'Paredes Cárdenas', '972345678', 'camila.paredes@hotmail.com', 'Jr. Batalla de Junín 210, Barranco', '2009-11-03', 'TikTok', 'Sesión de Quince Años en exteriores y estudio', 1, '2026-10-08 07:04:59', 1, NULL, NULL),
	(4, 'CLI-004', 'RUC', '20556789123', 'Inversiones y Moda', 'Velvet S.A.C.', '984567890', 'marketing@velvetstore.pe', 'Av. Conquistadores 650, San Isidro', NULL, 'Facebook Ads', 'Fotografía de catálogo lookbook y e-commerce', 1, '2026-10-08 07:04:59', 1, NULL, NULL),
	(5, 'CLI-005', 'DNI', '71234567', 'Renato André', 'Salazar Quiroga', '995678123', 'renato.salazar@outlook.com', 'Av. Brasil 2450, Jesús María', '1988-02-18', 'Google Maps', 'Sesión familiar navideña con photobook premium', 1, '2026-10-08 07:04:59', 1, NULL, NULL);

-- Volcando estructura para tabla sys_fotografia.configuracion
CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` text COLLATE utf8mb4_unicode_ci,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.configuracion: ~17 rows (aproximadamente)
DELETE FROM `configuracion`;
INSERT INTO `configuracion` (`id`, `clave`, `valor`, `descripcion`) VALUES
	(1, 'empresa_nombre', 'StudioFoto Pro', 'Nombre comercial'),
	(2, 'empresa_slogan', 'Capturando momentos inolvidables con arte y pasión', 'Eslogan'),
	(3, 'empresa_ruc', '20601234567', 'RUC'),
	(4, 'empresa_direccion', 'Av. Larco 742, Miraflores, Lima - Perú', 'Dirección física'),
	(5, 'empresa_telefono', '+51 987 654 321', 'Teléfono'),
	(6, 'empresa_email', 'contacto@studiofotopro.com', 'Email corporativo'),
	(7, 'moneda_simbolo', 'S/', 'Símbolo monetario'),
	(8, 'meta_mensual', '25000.00', 'Meta financiera mensual'),
	(9, 'horario_estudio', '09:00 - 20:00', 'Horario'),
	(10, 'ia_clave', 'AQ.Ab8RN6K1Odp4SggLp4vMYKLhhvF7sfViPWTCfQU_vsLMJTyPkw', NULL),
	(12, 'ia_modelo', 'gemini-3.5-flash-lite', NULL),
	(16, 'moneda_codigo', 'PEN', NULL),
	(17, 'decimal_sep', '.', NULL),
	(18, 'miles_sep', ',', NULL),
	(19, 'timezone', 'America/Lima', NULL),
	(20, 'fecha_formato', 'd/m/Y', NULL),
	(21, 'backup_history', '[{"nombre":"backup_sys_fotografia_20261008_1543.sql","fecha":"2026-10-08 15:43:19","tamano":"41.7 KB"}]', NULL);

-- Volcando estructura para tabla sys_fotografia.crm_cliente_etiqueta
CREATE TABLE IF NOT EXISTS `crm_cliente_etiqueta` (
  `cliente_id` int NOT NULL,
  `etiqueta_id` int NOT NULL,
  PRIMARY KEY (`cliente_id`,`etiqueta_id`),
  KEY `etiqueta_id` (`etiqueta_id`),
  CONSTRAINT `crm_cliente_etiqueta_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `crm_cliente_etiqueta_ibfk_2` FOREIGN KEY (`etiqueta_id`) REFERENCES `crm_etiquetas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.crm_cliente_etiqueta: ~0 rows (aproximadamente)
DELETE FROM `crm_cliente_etiqueta`;

-- Volcando estructura para tabla sys_fotografia.crm_etapas
CREATE TABLE IF NOT EXISTS `crm_etapas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orden` tinyint NOT NULL DEFAULT '0',
  `probabilidad` tinyint NOT NULL DEFAULT '0',
  `color` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#5b5ef4',
  `tipo` enum('ABIERTA','GANADA','PERDIDA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ABIERTA',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.crm_etapas: ~6 rows (aproximadamente)
DELETE FROM `crm_etapas`;
INSERT INTO `crm_etapas` (`id`, `nombre`, `orden`, `probabilidad`, `color`, `tipo`) VALUES
	(1, 'Prospecto', 1, 10, '#94a3b8', 'ABIERTA'),
	(2, 'Contactado', 2, 25, '#0ea5e9', 'ABIERTA'),
	(3, 'Propuesta', 3, 50, '#8b5cf6', 'ABIERTA'),
	(4, 'Negociación', 4, 75, '#f59e0b', 'ABIERTA'),
	(5, 'Ganado', 5, 100, '#10b981', 'GANADA'),
	(6, 'Perdido', 6, 0, '#ef4444', 'PERDIDA');

-- Volcando estructura para tabla sys_fotografia.crm_etiquetas
CREATE TABLE IF NOT EXISTS `crm_etiquetas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#5b5ef4',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.crm_etiquetas: ~6 rows (aproximadamente)
DELETE FROM `crm_etiquetas`;
INSERT INTO `crm_etiquetas` (`id`, `nombre`, `color`) VALUES
	(1, 'VIP', '#f59e0b'),
	(2, 'Novia', '#ec4899'),
	(3, 'Frecuente', '#10b981'),
	(4, 'Moroso', '#ef4444'),
	(5, 'Empresa', '#3b82f6'),
	(6, 'Maternidad', '#8b5cf6');

-- Volcando estructura para tabla sys_fotografia.crm_notas
CREATE TABLE IF NOT EXISTS `crm_notas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `tipo` enum('NOTA','LLAMADA','VISITA','WHATSAPP','EMAIL','REUNION','SISTEMA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NOTA',
  `texto` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`,`creado_en`),
  CONSTRAINT `crm_notas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.crm_notas: ~0 rows (aproximadamente)
DELETE FROM `crm_notas`;

-- Volcando estructura para tabla sys_fotografia.crm_oportunidades
CREATE TABLE IF NOT EXISTS `crm_oportunidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `titulo` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` decimal(12,2) NOT NULL DEFAULT '0.00',
  `etapa_id` int NOT NULL,
  `responsable_id` int DEFAULT NULL,
  `origen` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cierre_estimado` date DEFAULT NULL,
  `estado` enum('ABIERTA','GANADA','PERDIDA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ABIERTA',
  `motivo_perdida` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orden` int NOT NULL DEFAULT '0',
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cerrado_en` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `etapa_id` (`etapa_id`,`orden`),
  KEY `estado` (`estado`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `crm_oportunidades_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `crm_oportunidades_ibfk_2` FOREIGN KEY (`etapa_id`) REFERENCES `crm_etapas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.crm_oportunidades: ~5 rows (aproximadamente)
DELETE FROM `crm_oportunidades`;
INSERT INTO `crm_oportunidades` (`id`, `cliente_id`, `titulo`, `valor`, `etapa_id`, `responsable_id`, `origen`, `cierre_estimado`, `estado`, `motivo_perdida`, `orden`, `creado_en`, `actualizado_en`, `cerrado_en`) VALUES
	(1, 1, 'Sesión Fotográfica Maternidad Ext', 650.00, 1, NULL, NULL, NULL, 'ABIERTA', NULL, 0, '2026-10-08 09:25:58', '2026-10-08 09:25:58', NULL),
	(2, 2, 'Paquete Bodas Premium 2026', 3200.00, 4, NULL, NULL, NULL, 'ABIERTA', NULL, 0, '2026-10-08 09:25:58', '2026-10-08 09:25:58', NULL),
	(3, 3, 'Headshots Corporativos Directorio', 1200.00, 3, NULL, NULL, NULL, 'ABIERTA', NULL, 0, '2026-10-08 09:25:58', '2026-10-08 09:25:58', NULL),
	(4, 4, 'Sesión Familiar Navidad', 490.00, 2, NULL, NULL, NULL, 'ABIERTA', NULL, 0, '2026-10-08 09:25:58', '2026-10-08 09:25:58', NULL),
	(5, 5, 'Renovación Catálogo Primavera', 1500.00, 5, NULL, NULL, NULL, 'GANADA', NULL, 0, '2026-10-08 09:25:58', '2026-10-08 09:25:58', NULL);

-- Volcando estructura para tabla sys_fotografia.crm_tareas
CREATE TABLE IF NOT EXISTS `crm_tareas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `oportunidad_id` int DEFAULT NULL,
  `asignado_id` int DEFAULT NULL,
  `creado_por` int DEFAULT NULL,
  `titulo` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('LLAMAR','WHATSAPP','VISITA','EMAIL','COBRAR','SEGUIMIENTO','OTRO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SEGUIMIENTO',
  `prioridad` enum('BAJA','MEDIA','ALTA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MEDIA',
  `vence` datetime DEFAULT NULL,
  `estado` enum('PENDIENTE','HECHA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `completada_en` datetime DEFAULT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `estado` (`estado`,`vence`),
  KEY `asignado_id` (`asignado_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `oportunidad_id` (`oportunidad_id`),
  CONSTRAINT `crm_tareas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `crm_tareas_ibfk_2` FOREIGN KEY (`oportunidad_id`) REFERENCES `crm_oportunidades` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.crm_tareas: ~0 rows (aproximadamente)
DELETE FROM `crm_tareas`;

-- Volcando estructura para tabla sys_fotografia.equipos
CREATE TABLE IF NOT EXISTS `equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoria` enum('Cámara','Lente / Óptica','Iluminación / Flash','Dron / Estabilizador','Audio & Grabación','Accesorios & Fondos') COLLATE utf8mb4_unicode_ci NOT NULL,
  `marca_modelo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_serie` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Disponible','En Uso / Sesión','En Mantenimiento','Inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Disponible',
  `fotografo_asignado_id` int DEFAULT NULL,
  `fecha_adquisicion` date DEFAULT NULL,
  `valor_estimado` decimal(10,2) DEFAULT '0.00',
  `notas` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `fotografo_asignado_id` (`fotografo_asignado_id`),
  CONSTRAINT `equipos_ibfk_1` FOREIGN KEY (`fotografo_asignado_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.equipos: ~8 rows (aproximadamente)
DELETE FROM `equipos`;
INSERT INTO `equipos` (`id`, `codigo`, `nombre`, `categoria`, `marca_modelo`, `num_serie`, `estado`, `fotografo_asignado_id`, `fecha_adquisicion`, `valor_estimado`, `notas`) VALUES
	(1, 'EQ-CAM-01', 'Cámara Mirrorless Sony Alpha 7 IV (Cuerpo)', 'Cámara', 'Sony A7 IV 33MP Full Frame', 'SN-8492019', 'En Uso / Sesión', 2, '2024-03-15', 9800.00, 'Cámara principal para bodas y eventos en exteriores'),
	(2, 'EQ-CAM-02', 'Cámara Canon EOS R6 Mark II', 'Cámara', 'Canon EOS R6 II 24.2MP', 'SN-5521904', 'Disponible', 3, '2024-06-20', 9200.00, 'Excelente para sesiones infantiles y retratos continuos'),
	(3, 'EQ-LEN-01', 'Lente Sony FE 24-70mm f/2.8 GM II', 'Lente / Óptica', 'Sony G Master 24-70mm f/2.8', 'SN-GM29401', 'En Uso / Sesión', 2, '2024-03-15', 7800.00, 'Óptica todoterreno de máxima nitidez'),
	(4, 'EQ-LEN-02', 'Lente Sony FE 85mm f/1.4 GM (Retrato)', 'Lente / Óptica', 'Sony G Master 85mm f/1.4', 'SN-GM85012', 'Disponible', NULL, '2023-11-10', 5600.00, 'Bokeh cremoso para retratos de novias y graduaciones'),
	(5, 'EQ-ILU-01', 'Flash de Estudio Godox AD600Pro TTL (Batería)', 'Iluminación / Flash', 'Godox Witstro AD600Pro 600W', 'SN-GD60012', 'En Uso / Sesión', 2, '2024-01-20', 3200.00, 'Incluye montura Bowens y trigger inalámbrico Godox XPro II'),
	(6, 'EQ-ILU-02', 'Kit de 2 Flashes Godox SK400II con Softbox', 'Iluminación / Flash', 'Godox SK400II Studio Strobe', 'SN-SK400SET', 'Disponible', NULL, '2023-08-14', 1850.00, 'Instalados fijos en ciclorama del Set A'),
	(7, 'EQ-DRN-01', 'Dron DJI Mavic 3 Pro Cine Combo', 'Dron / Estabilizador', 'DJI Mavic 3 Pro Tri-Cámara Hasselblad', 'SN-DJI98210', 'Disponible', NULL, '2024-05-10', 11500.00, 'Para tomas aéreas de bodas campestres y haciendas'),
	(8, 'EQ-GMB-01', 'Gimbal DJI RS 3 Pro Combo', 'Dron / Estabilizador', 'DJI RS3 Pro con motor Focus', 'SN-RS399120', 'Disponible', NULL, '2024-02-18', 3400.00, 'Estabilizador de 3 ejes para video cinemático');

-- Volcando estructura para tabla sys_fotografia.ia_consultas
CREATE TABLE IF NOT EXISTS `ia_consultas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(500) NOT NULL,
  `titulo` varchar(160) DEFAULT NULL,
  `sql_texto` text NOT NULL,
  `grafico` varchar(255) DEFAULT NULL,
  `creado_en` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla sys_fotografia.ia_consultas: ~2 rows (aproximadamente)
DELETE FROM `ia_consultas`;
INSERT INTO `ia_consultas` (`id`, `pregunta`, `titulo`, `sql_texto`, `grafico`, `creado_en`) VALUES
	(1, 'citas', 'Próximas Sesiones Fotográficas', 'SELECT folio, cliente_nombres, cliente_apellidos, paquete, fotografo, fecha_sesion, hora_inicio, tipo_locacion, estado FROM v_ia_sesiones WHERE fecha_sesion >= \'2026-10-08\' ORDER BY fecha_sesion ASC, hora_inicio ASC LIMIT 20', '{"tipo":"none","x":"","y":""}', '2026-10-08 10:25:42'),
	(2, 'Top paquetes más vendidos este mes', 'Top Paquetes Más Vendidos Este Mes', 'SELECT s.paquete AS paquete, COUNT(*) AS total_vendidos, SUM(s.total) AS ingresos_totales FROM v_ia_sesiones s WHERE s.fecha_sesion >= DATE_FORMAT(CURDATE(), \'%Y-%m-01\') AND s.fecha_sesion <= LAST_DAY(CURDATE()) GROUP BY s.paquete ORDER BY total_vendidos DESC LIMIT 20', '{"tipo":"bar","x":"paquete","y":"total_vendidos"}', '2026-10-08 10:26:13');

-- Volcando estructura para tabla sys_fotografia.pagos
CREATE TABLE IF NOT EXISTS `pagos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sesion_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('Efectivo','Yape / Plin','Tarjeta Débito/Crédito','Transferencia Bancaria') COLLATE utf8mb4_unicode_ci NOT NULL,
  `referencia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` int NOT NULL,
  `concepto` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comprobante_tipo` enum('Recibo','Boleta','Factura') COLLATE utf8mb4_unicode_ci DEFAULT 'Boleta',
  `comprobante_numero` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sesion_id` (`sesion_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`sesion_id`) REFERENCES `sesiones` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `pagos_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `pagos_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.pagos: ~7 rows (aproximadamente)
DELETE FROM `pagos`;
INSERT INTO `pagos` (`id`, `sesion_id`, `cliente_id`, `monto`, `metodo_pago`, `referencia`, `fecha_pago`, `usuario_id`, `concepto`, `comprobante_tipo`, `comprobante_numero`) VALUES
	(1, 1, 1, 400.00, 'Yape / Plin', 'OPE-839201', '2026-10-08 07:04:59', 1, 'Anticipo 50% Sesión Newborn', 'Boleta', 'B001-000491'),
	(2, 2, 3, 1200.00, 'Transferencia Bancaria', 'BCP-992014', '2026-10-08 07:04:59', 1, 'Anticipo Reserva Paquete Quinceañera', 'Boleta', 'B001-000492'),
	(3, 3, 4, 980.00, 'Tarjeta Débito/Crédito', 'POS-VISA-551', '2026-10-08 07:04:59', 1, 'Liquidación 100% Fotografía Lookbook Velvet', 'Factura', 'F001-000188'),
	(4, 4, 2, 2000.00, 'Transferencia Bancaria', 'BBVA-441029', '2026-10-08 07:04:59', 1, 'Anticipo Cobertura Boda Alejandro & Daniela', 'Factura', 'F001-000189'),
	(5, 5, 5, 640.00, 'Tarjeta Débito/Crédito', 'POS-MASTERCARD-88', '2026-10-08 07:04:59', 1, 'Pago Total Retrato Familiar Aniversario', 'Boleta', 'B001-000493'),
	(6, 6, 1, 620.00, 'Yape / Plin', 'OPE-448123', '2026-10-08 07:04:59', 1, 'Pago Total Sesión Maternidad Boho', 'Boleta', 'B001-000494'),
	(7, 7, 5, 200.00, 'Efectivo', 'CAJA-DIR', '2026-10-08 07:04:59', 1, 'Seña reserva Headshots Ejecutivos', 'Recibo', 'REC-0012');

-- Volcando estructura para tabla sys_fotografia.paquetes
CREATE TABLE IF NOT EXISTS `paquetes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria_id` int NOT NULL,
  `codigo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `precio` decimal(10,2) NOT NULL,
  `duracion_min` int NOT NULL DEFAULT '60',
  `fotos_digitales_hd` int NOT NULL DEFAULT '15',
  `fotos_impresas` int NOT NULL DEFAULT '0',
  `tamanio_impresion` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '15x20 cm',
  `incluye_photobook` tinyint(1) DEFAULT '0',
  `incluye_drone` tinyint(1) DEFAULT '0',
  `cambios_vestuario` int DEFAULT '1',
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `paquetes_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_paquetes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.paquetes: ~8 rows (aproximadamente)
DELETE FROM `paquetes`;
INSERT INTO `paquetes` (`id`, `categoria_id`, `codigo`, `nombre`, `descripcion`, `precio`, `duracion_min`, `fotos_digitales_hd`, `fotos_impresas`, `tamanio_impresion`, `incluye_photobook`, `incluye_drone`, `cambios_vestuario`, `estado`) VALUES
	(1, 1, 'PK-BOD-01', 'Boda Golden Love (Completa)', 'Cobertura de preparativos, ceremonia religiosa y fiesta. Galería online privada + Photobook piel 30x30cm + Cobertura con Dron 4K', 3200.00, 480, 250, 40, '20x30 cm Fine Art', 1, 1, 3, 1),
	(2, 1, 'PK-BOD-02', 'Boda Civil & Mini Sesión', 'Cobertura de firma civil + 90 min de sesión exterior en locación elegida. Entrega digital rápida', 1150.00, 150, 80, 15, '15x21 cm', 0, 0, 2, 1),
	(3, 2, 'PK-15-01', 'Quinceañera Princesa Deluxe', 'Sesión previa en exteriores y estudio con 3 vestuarios + Cobertura del evento y vals. Photobook acrílico + Cuadro Lienzo 50x70cm', 2100.00, 360, 180, 30, 'Lienzo 50x70 + 20x30', 1, 0, 4, 1),
	(4, 3, 'PK-NEW-01', 'Newborn Pure Sweetness', 'Sesión para bebés de 5 a 15 días en estudio climatizado, incluye atrezzo, telas orgánicas y vestuario. Fotos con padres y hermanos', 750.00, 120, 25, 10, '15x20 cm montadas', 0, 0, 3, 1),
	(5, 3, 'PK-MAT-01', 'Maternidad Glow & Milk Bath', 'Sesión en estudio o exteriores semana 28-34 de gestación. Acceso al vestidor de vestidos de alta costura para embarazadas', 620.00, 90, 20, 8, '15x20 cm', 0, 0, 3, 1),
	(6, 4, 'PK-RET-01', 'Retrato Profesional & Marca Personal', 'Headshots de alto impacto para LinkedIn, CEOs y médicos. Asesoría de poses e iluminación cinematográfica', 380.00, 60, 10, 0, 'Digital HD', 0, 0, 2, 1),
	(7, 4, 'PK-FAM-01', 'Retrato Familiar de Estudio', 'Sesión cálida para hasta 6 integrantes familiares con fondos temáticos contemporáneos', 490.00, 75, 18, 5, '20x30 cm', 0, 0, 2, 1),
	(8, 5, 'PK-CORP-01', 'E-commerce & Producto Pro', 'Fotografía de producto con fondo blanco puro y bodegón creativo para redes sociales y tiendas online', 980.00, 180, 40, 0, 'Digital Optimizado Web', 0, 0, 1, 1);

-- Volcando estructura para tabla sys_fotografia.sesiones
CREATE TABLE IF NOT EXISTS `sesiones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cliente_id` int NOT NULL,
  `paquete_id` int NOT NULL,
  `fotografo_id` int NOT NULL,
  `fecha_sesion` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `tipo_locacion` enum('Estudio Principal','Exteriores','Domicilio','Iglesia / Evento') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Estudio Principal',
  `direccion_locacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tematica` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Programada','En Sesión','Selección de Fotos','En Edición/Retoque','En Impresión/Lab','Lista para Entrega','Entregada','Cancelada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Programada',
  `precio_pactado` decimal(10,2) NOT NULL,
  `costo_adicionales` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL,
  `anticipo` decimal(10,2) NOT NULL DEFAULT '0.00',
  `saldo_pendiente` decimal(10,2) NOT NULL DEFAULT '0.00',
  `estado_pago` enum('Pendiente','Adelanto','Cancelado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `folio` (`folio`),
  KEY `cliente_id` (`cliente_id`),
  KEY `paquete_id` (`paquete_id`),
  KEY `fotografo_id` (`fotografo_id`),
  CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `sesiones_ibfk_2` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `sesiones_ibfk_3` FOREIGN KEY (`fotografo_id`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.sesiones: ~7 rows (aproximadamente)
DELETE FROM `sesiones`;
INSERT INTO `sesiones` (`id`, `folio`, `cliente_id`, `paquete_id`, `fotografo_id`, `fecha_sesion`, `hora_inicio`, `hora_fin`, `tipo_locacion`, `direccion_locacion`, `tematica`, `estado`, `precio_pactado`, `costo_adicionales`, `total`, `anticipo`, `saldo_pendiente`, `estado_pago`, `notas`, `created_at`) VALUES
	(1, 'SES-2026-081', 1, 4, 3, '2026-10-08', '10:00:00', '12:00:00', 'Estudio Principal', 'Sala A - Newborn Climatizada', 'Sesión Newborn bebé Mateo (10 días de nacido)', 'En Sesión', 750.00, 50.00, 800.00, 400.00, 400.00, 'Adelanto', 'Traer calentador encendido 30 min antes. Cliente solicitó tonos tierra y beige.', '2026-10-08 07:04:59'),
	(2, 'SES-2026-082', 3, 3, 2, '2026-10-08', '15:30:00', '19:00:00', 'Exteriores', 'Parque El Olivar, San Isidro', 'Sesión Pre-15 Vestido Azul Zafiro', 'Programada', 2100.00, 100.00, 2200.00, 1200.00, 1000.00, 'Adelanto', 'Llevar reflector 5 en 1, flash Godox AD600Pro con softbox octabox.', '2026-10-08 07:04:59'),
	(3, 'SES-2026-083', 4, 8, 2, '2026-10-08', '11:30:00', '14:30:00', 'Estudio Principal', 'Ciclorama Blanco Set B', 'Campaña Invierno Colección Velvet', 'Selección de Fotos', 980.00, 0.00, 980.00, 980.00, 0.00, 'Cancelado', '40 productos en total, cliente seleccionando tomas por portal online.', '2026-10-08 07:04:59'),
	(4, 'SES-2026-079', 2, 1, 2, '2026-10-05', '14:00:00', '22:00:00', 'Iglesia / Evento', 'Parroquia Santa María Reina & Hotel Westin', 'Boda Religiosa Alejandro & Daniela', 'En Edición/Retoque', 3200.00, 300.00, 3500.00, 2000.00, 1500.00, 'Adelanto', 'Diego en proceso de corrección de color y selección de 50 fotos para Photobook.', '2026-10-08 07:04:59'),
	(5, 'SES-2026-077', 5, 7, 3, '2026-10-03', '16:00:00', '17:30:00', 'Estudio Principal', 'Set Familiar Vintage', 'Retrato Aniversario Bodas de Plata', 'En Impresión/Lab', 490.00, 150.00, 640.00, 640.00, 0.00, 'Cancelado', 'Enviado a laboratorio para impresión en papel algodón Fine Art 20x30.', '2026-10-08 07:04:59'),
	(6, 'SES-2026-075', 1, 5, 3, '2026-09-30', '11:00:00', '12:30:00', 'Estudio Principal', 'Set Maternidad Boho Chic', 'Maternidad Dulce Espera', 'Lista para Entrega', 620.00, 0.00, 620.00, 620.00, 0.00, 'Cancelado', 'Caja de madera con impresiones y USB grabado listo en recepción.', '2026-10-08 07:04:59'),
	(7, 'SES-2026-084', 5, 6, 2, '2026-10-09', '09:30:00', '10:30:00', 'Estudio Principal', 'Set Ejecutivo Minimalista', 'Headshot Corporativo Directorio', 'Programada', 380.00, 0.00, 380.00, 200.00, 180.00, 'Adelanto', 'Fondo gris neutro y degradado azul suave para perfil LinkedIn corporativo.', '2026-10-08 07:04:59');

-- Volcando estructura para tabla sys_fotografia.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('admin','fotografo','recepcion','editor') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fotografo',
  `telefono` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `especialidad` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Fotografía General',
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla sys_fotografia.usuarios: ~5 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id`, `nombre`, `usuario`, `email`, `password`, `rol`, `telefono`, `avatar`, `especialidad`, `estado`, `created_at`) VALUES
	(1, 'Victor Administrador', 'admin', 'admin@studiofotopro.com', '$2y$10$a/Zo/cznuuEIMN2ODHUlh.AHlHkaSycdgkBclaoxt9b14rY2OcSlW', 'admin', '+51 987 111 222', NULL, 'Dirección General & Producción', 1, '2026-10-08 07:04:59'),
	(2, 'Carlos Mendoza', 'cmendoza', 'carlos@studiofotopro.com', '$2y$10$a/Zo/cznuuEIMN2ODHUlh.AHlHkaSycdgkBclaoxt9b14rY2OcSlW', 'fotografo', '+51 987 333 444', NULL, 'Bodas & Eventos Sociales', 1, '2026-10-08 07:04:59'),
	(3, 'Mariana Silva', 'msilva', 'mariana@studiofotopro.com', '$2y$10$a/Zo/cznuuEIMN2ODHUlh.AHlHkaSycdgkBclaoxt9b14rY2OcSlW', 'fotografo', '+51 987 555 666', NULL, 'Newborn, Maternidad & Infantil', 1, '2026-10-08 07:04:59'),
	(4, 'Valeria Ponce', 'vponce', 'recepcion@studiofotopro.com', '$2y$10$a/Zo/cznuuEIMN2ODHUlh.AHlHkaSycdgkBclaoxt9b14rY2OcSlW', 'recepcion', '+51 987 777 888', NULL, 'Atención al Cliente & Agenda', 1, '2026-10-08 07:04:59'),
	(5, 'Diego Rivas', 'drivas', 'editor@studiofotopro.com', '$2y$10$a/Zo/cznuuEIMN2ODHUlh.AHlHkaSycdgkBclaoxt9b14rY2OcSlW', 'editor', '+51 987 999 000', NULL, 'Retoque Fine Art & Color Grading', 1, '2026-10-08 07:04:59');

-- Volcando estructura para vista sys_fotografia.v_ia_cajas
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_ia_cajas` (
	`caja_id` INT NOT NULL,
	`fecha` DATE NOT NULL,
	`monto_apertura` DECIMAL(10,2) NOT NULL,
	`total_ingresos_efectivo` DECIMAL(10,2) NOT NULL,
	`total_ingresos_digital` DECIMAL(10,2) NOT NULL,
	`total_egresos` DECIMAL(10,2) NOT NULL,
	`saldo_esperado` DECIMAL(10,2) NOT NULL,
	`estado` ENUM('Abierta','Cerrada') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`notas` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista sys_fotografia.v_ia_clientes
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_ia_clientes` (
	`cliente_id` INT NOT NULL,
	`codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`tipo_doc` ENUM('DNI','RUC','CE','PASAPORTE') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`num_doc` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nombres` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`apellidos` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`telefono` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha_nacimiento` DATE NULL,
	`origen` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`registrado_en` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista sys_fotografia.v_ia_equipos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_ia_equipos` (
	`equipo_id` INT NOT NULL,
	`codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nombre` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`categoria` ENUM('Cámara','Lente / Óptica','Iluminación / Flash','Dron / Estabilizador','Audio & Grabación','Accesorios & Fondos') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`marca_modelo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`estado` ENUM('Disponible','En Uso / Sesión','En Mantenimiento','Inactivo') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fotografo_asignado` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha_adquisicion` DATE NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista sys_fotografia.v_ia_pagos
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_ia_pagos` (
	`pago_id` INT NOT NULL,
	`sesion_folio` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`cliente` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`monto` DECIMAL(10,2) NOT NULL,
	`metodo_pago` ENUM('Efectivo','Yape / Plin','Tarjeta Débito/Crédito','Transferencia Bancaria') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`concepto` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`comprobante_tipo` ENUM('Recibo','Boleta','Factura') NULL COLLATE 'utf8mb4_unicode_ci',
	`comprobante_numero` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha_pago` TIMESTAMP NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista sys_fotografia.v_ia_paquetes
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_ia_paquetes` (
	`paquete_id` INT NOT NULL,
	`codigo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`categoria` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nombre` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`precio` DECIMAL(10,2) NOT NULL,
	`duracion_min` INT NOT NULL,
	`fotos_digitales_hd` INT NOT NULL,
	`fotos_impresas` INT NOT NULL,
	`activo` TINYINT(1) NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista sys_fotografia.v_ia_sesiones
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_ia_sesiones` (
	`sesion_id` INT NOT NULL,
	`folio` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`cliente_nombres` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`cliente_apellidos` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`paquete` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fotografo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`fecha_sesion` DATE NOT NULL,
	`hora_inicio` TIME NOT NULL,
	`tipo_locacion` ENUM('Estudio Principal','Exteriores','Domicilio','Iglesia / Evento') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`estado` ENUM('Programada','En Sesión','Selección de Fotos','En Edición/Retoque','En Impresión/Lab','Lista para Entrega','Entregada','Cancelada') NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`precio_pactado` DECIMAL(10,2) NOT NULL,
	`total` DECIMAL(10,2) NOT NULL,
	`anticipo` DECIMAL(10,2) NOT NULL,
	`saldo_pendiente` DECIMAL(10,2) NOT NULL,
	`estado_pago` ENUM('Pendiente','Adelanto','Cancelado') NOT NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_ia_cajas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_ia_cajas` AS select `cajas`.`id` AS `caja_id`,`cajas`.`fecha` AS `fecha`,`cajas`.`monto_apertura` AS `monto_apertura`,`cajas`.`total_ingresos_efectivo` AS `total_ingresos_efectivo`,`cajas`.`total_ingresos_digital` AS `total_ingresos_digital`,`cajas`.`total_egresos` AS `total_egresos`,`cajas`.`saldo_esperado` AS `saldo_esperado`,`cajas`.`estado` AS `estado`,`cajas`.`notas` AS `notas` from `cajas`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_ia_clientes`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_ia_clientes` AS select `clientes`.`id` AS `cliente_id`,`clientes`.`codigo` AS `codigo`,`clientes`.`tipo_doc` AS `tipo_doc`,`clientes`.`num_doc` AS `num_doc`,`clientes`.`nombres` AS `nombres`,`clientes`.`apellidos` AS `apellidos`,`clientes`.`telefono` AS `telefono`,`clientes`.`fecha_nacimiento` AS `fecha_nacimiento`,`clientes`.`origen` AS `origen`,`clientes`.`created_at` AS `registrado_en` from `clientes`;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_ia_equipos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_ia_equipos` AS select `e`.`id` AS `equipo_id`,`e`.`codigo` AS `codigo`,`e`.`nombre` AS `nombre`,`e`.`categoria` AS `categoria`,`e`.`marca_modelo` AS `marca_modelo`,`e`.`estado` AS `estado`,`u`.`nombre` AS `fotografo_asignado`,`e`.`fecha_adquisicion` AS `fecha_adquisicion` from (`equipos` `e` left join `usuarios` `u` on((`u`.`id` = `e`.`fotografo_asignado_id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_ia_pagos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_ia_pagos` AS select `p`.`id` AS `pago_id`,`s`.`folio` AS `sesion_folio`,`c`.`nombres` AS `cliente`,`p`.`monto` AS `monto`,`p`.`metodo_pago` AS `metodo_pago`,`p`.`concepto` AS `concepto`,`p`.`comprobante_tipo` AS `comprobante_tipo`,`p`.`comprobante_numero` AS `comprobante_numero`,`p`.`fecha_pago` AS `fecha_pago` from ((`pagos` `p` join `sesiones` `s` on((`s`.`id` = `p`.`sesion_id`))) join `clientes` `c` on((`c`.`id` = `p`.`cliente_id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_ia_paquetes`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_ia_paquetes` AS select `p`.`id` AS `paquete_id`,`p`.`codigo` AS `codigo`,`cp`.`nombre` AS `categoria`,`p`.`nombre` AS `nombre`,`p`.`precio` AS `precio`,`p`.`duracion_min` AS `duracion_min`,`p`.`fotos_digitales_hd` AS `fotos_digitales_hd`,`p`.`fotos_impresas` AS `fotos_impresas`,`p`.`estado` AS `activo` from (`paquetes` `p` join `categorias_paquetes` `cp` on((`cp`.`id` = `p`.`categoria_id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_ia_sesiones`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_ia_sesiones` AS select `s`.`id` AS `sesion_id`,`s`.`folio` AS `folio`,`c`.`nombres` AS `cliente_nombres`,`c`.`apellidos` AS `cliente_apellidos`,`p`.`nombre` AS `paquete`,`u`.`nombre` AS `fotografo`,`s`.`fecha_sesion` AS `fecha_sesion`,`s`.`hora_inicio` AS `hora_inicio`,`s`.`tipo_locacion` AS `tipo_locacion`,`s`.`estado` AS `estado`,`s`.`precio_pactado` AS `precio_pactado`,`s`.`total` AS `total`,`s`.`anticipo` AS `anticipo`,`s`.`saldo_pendiente` AS `saldo_pendiente`,`s`.`estado_pago` AS `estado_pago` from (((`sesiones` `s` join `clientes` `c` on((`c`.`id` = `s`.`cliente_id`))) join `paquetes` `p` on((`p`.`id` = `s`.`paquete_id`))) join `usuarios` `u` on((`u`.`id` = `s`.`fotografo_id`)));

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
