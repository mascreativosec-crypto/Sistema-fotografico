-- Base de datos: sys_fotografia
-- Sistema de Estudio Fotográfico Profesional (SysFoto Studio)

CREATE DATABASE IF NOT EXISTS `sys_fotografia` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `sys_fotografia`;

-- Tabla de Configuración General
CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `clave` VARCHAR(50) NOT NULL UNIQUE,
  `valor` TEXT,
  `descripcion` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `configuracion` (`clave`, `valor`, `descripcion`) VALUES
('empresa_nombre', 'StudioFoto Pro · Estudio Fotográfico', 'Nombre comercial del estudio'),
('empresa_slogan', 'Capturando momentos inolvidables con arte y pasión', 'Eslogan publicitario'),
('empresa_ruc', '20601234567', 'RUC o Identificación fiscal'),
('empresa_direccion', 'Av. Larco 742, Miraflores, Lima - Perú', 'Dirección física principal'),
('empresa_telefono', '+51 987 654 321', 'Teléfono de contacto'),
('empresa_email', 'contacto@studiofotopro.com', 'Email corporativo'),
('moneda_simbolo', 'S/', 'Símbolo monetario (Soles, USD $, etc.)'),
('moneda_codigo', 'PEN', 'Código ISO de la moneda'),
('meta_mensual', '25000.00', 'Meta financiera mensual de ingresos'),
('horario_estudio', '09:00 - 20:00', 'Horario habitual de atención')
ON DUPLICATE KEY UPDATE `valor` = VALUES(`valor`);

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL,
  `usuario` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `rol` ENUM('admin', 'fotografo', 'recepcion', 'editor') NOT NULL DEFAULT 'fotografo',
  `telefono` VARCHAR(30) DEFAULT NULL,
  `avatar` VARCHAR(255) DEFAULT NULL,
  `especialidad` VARCHAR(100) DEFAULT 'Fotografía General',
  `estado` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Usuarios de prueba (contraseña para todos: admin123)
INSERT INTO `usuarios` (`id`, `nombre`, `usuario`, `email`, `password`, `rol`, `telefono`, `especialidad`, `estado`) VALUES
(1, 'Victor Administrador', 'admin', 'admin@studiofotopro.com', '$2y$10$HmtQms/kpvXXaSyAceKRvu6.h5fXpV.PbUmv9TvRWaAGAy59Eix8a', 'admin', '+51 987 111 222', 'Dirección General & Producción', 1),
(2, 'Carlos Mendoza', 'cmendoza', 'carlos@studiofotopro.com', '$2y$10$HmtQms/kpvXXaSyAceKRvu6.h5fXpV.PbUmv9TvRWaAGAy59Eix8a', 'fotografo', '+51 987 333 444', 'Bodas & Eventos Sociales', 1),
(3, 'Mariana Silva', 'msilva', 'mariana@studiofotopro.com', '$2y$10$HmtQms/kpvXXaSyAceKRvu6.h5fXpV.PbUmv9TvRWaAGAy59Eix8a', 'fotografo', '+51 987 555 666', 'Newborn, Maternidad & Infantil', 1),
(4, 'Valeria Ponce', 'vponce', 'recepcion@studiofotopro.com', '$2y$10$HmtQms/kpvXXaSyAceKRvu6.h5fXpV.PbUmv9TvRWaAGAy59Eix8a', 'recepcion', '+51 987 777 888', 'Atención al Cliente & Agenda', 1),
(5, 'Diego Rivas', 'drivas', 'editor@studiofotopro.com', '$2y$10$HmtQms/kpvXXaSyAceKRvu6.h5fXpV.PbUmv9TvRWaAGAy59Eix8a', 'editor', '+51 987 999 000', 'Retoque Fine Art & Color Grading', 1)
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- Tabla de Clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `codigo` VARCHAR(20) NOT NULL UNIQUE,
  `tipo_doc` ENUM('DNI', 'RUC', 'CE', 'PASAPORTE') NOT NULL DEFAULT 'DNI',
  `num_doc` VARCHAR(20) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `direccion` VARCHAR(255) DEFAULT NULL,
  `fecha_nacimiento` DATE DEFAULT NULL,
  `fecha_aniversario` DATE DEFAULT NULL,
  `origen` VARCHAR(50) DEFAULT 'Instagram',
  `notas` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `clientes` (`id`, `codigo`, `tipo_doc`, `num_doc`, `nombres`, `apellidos`, `telefono`, `email`, `direccion`, `fecha_nacimiento`, `origen`, `notas`) VALUES
(1, 'CLI-001', 'DNI', '74839201', 'Lucía Fernanda', 'Morales Benítez', '993412567', 'lucia.morales@gmail.com', 'Calle Los Pinos 340, San Isidro', '1996-05-14', 'Instagram', 'Cliente de sesión premamá y seguimiento mensual'),
(2, 'CLI-002', 'DNI', '45892014', 'Alejandro y Daniela', 'Vargas & Ruiz', '981234567', 'boda.vargasruiz@gmail.com', 'Av. Primavera 1280, Surco', '1992-09-20', 'Recomendación', 'Boda Civil y Religiosa con cobertura Drone'),
(3, 'CLI-003', 'DNI', '78901234', 'Camila Nicole', 'Paredes Cárdenas', '972345678', 'camila.paredes@hotmail.com', 'Jr. Batalla de Junín 210, Barranco', '2009-11-03', 'TikTok', 'Sesión de Quince Años en exteriores y estudio'),
(4, 'CLI-004', 'RUC', '20556789123', 'Inversiones y Moda', 'Velvet S.A.C.', '984567890', 'marketing@velvetstore.pe', 'Av. Conquistadores 650, San Isidro', NULL, 'Facebook Ads', 'Fotografía de catálogo lookbook y e-commerce'),
(5, 'CLI-005', 'DNI', '71234567', 'Renato André', 'Salazar Quiroga', '995678123', 'renato.salazar@outlook.com', 'Av. Brasil 2450, Jesús María', '1988-02-18', 'Google Maps', 'Sesión familiar navideña con photobook premium')
ON DUPLICATE KEY UPDATE `codigo` = VALUES(`codigo`);

-- Categorías de Paquetes
CREATE TABLE IF NOT EXISTS `categorias_paquetes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(50) NOT NULL,
  `icono` VARCHAR(50) DEFAULT 'bi-camera',
  `color` VARCHAR(20) DEFAULT '#5b5ef4',
  `descripcion` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `categorias_paquetes` (`id`, `nombre`, `icono`, `color`, `descripcion`) VALUES
(1, 'Bodas & Matrimonios', 'bi-hearts', '#f43f5e', 'Cobertura completa pre-boda, ceremonia y fiesta'),
(2, 'Quinceañeras', 'bi-gem', '#8b5cf6', 'Sesiones temáticas, estudio y fiesta de 15 años'),
(3, 'Newborn & Maternidad', 'bi-balloon-heart', '#0ea5e9', 'Fotografía especializada de recién nacidos y embarazo'),
(4, 'Estudio & Retrato Fine Art', 'bi-person-bounding-box', '#5b5ef4', 'Retrato artístico, graduaciones y fotos profesionales'),
(5, 'Corporativo & Producto', 'bi-briefcase', '#10b981', 'Catálogo publicitario, marcas y fotografía de negocios')
ON DUPLICATE KEY UPDATE `nombre` = VALUES(`nombre`);

-- Paquetes y Servicios
CREATE TABLE IF NOT EXISTS `paquetes` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `categoria_id` INT NOT NULL,
  `codigo` VARCHAR(20) NOT NULL UNIQUE,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT,
  `precio` DECIMAL(10,2) NOT NULL,
  `duracion_min` INT NOT NULL DEFAULT 60,
  `fotos_digitales_hd` INT NOT NULL DEFAULT 15,
  `fotos_impresas` INT NOT NULL DEFAULT 0,
  `tamanio_impresion` VARCHAR(50) DEFAULT '15x20 cm',
  `incluye_photobook` TINYINT(1) DEFAULT 0,
  `incluye_drone` TINYINT(1) DEFAULT 0,
  `cambios_vestuario` INT DEFAULT 1,
  `estado` TINYINT(1) DEFAULT 1,
  FOREIGN KEY (`categoria_id`) REFERENCES `categorias_paquetes`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `paquetes` (`id`, `categoria_id`, `codigo`, `nombre`, `descripcion`, `precio`, `duracion_min`, `fotos_digitales_hd`, `fotos_impresas`, `tamanio_impresion`, `incluye_photobook`, `incluye_drone`, `cambios_vestuario`, `estado`) VALUES
(1, 1, 'PK-BOD-01', 'Boda Golden Love (Completa)', 'Cobertura de preparativos, ceremonia religiosa y fiesta. Galería online privada + Photobook piel 30x30cm + Cobertura con Dron 4K', 3200.00, 480, 250, 40, '20x30 cm Fine Art', 1, 1, 3, 1),
(2, 1, 'PK-BOD-02', 'Boda Civil & Mini Sesión', 'Cobertura de firma civil + 90 min de sesión exterior en locación elegida. Entrega digital rápida', 1150.00, 150, 80, 15, '15x21 cm', 0, 0, 2, 1),
(3, 2, 'PK-15-01', 'Quinceañera Princesa Deluxe', 'Sesión previa en exteriores y estudio con 3 vestuarios + Cobertura del evento y vals. Photobook acrílico + Cuadro Lienzo 50x70cm', 2100.00, 360, 180, 30, 'Lienzo 50x70 + 20x30', 1, 0, 4, 1),
(4, 3, 'PK-NEW-01', 'Newborn Pure Sweetness', 'Sesión para bebés de 5 a 15 días en estudio climatizado, incluye atrezzo, telas orgánicas y vestuario. Fotos con padres y hermanos', 750.00, 120, 25, 10, '15x20 cm montadas', 0, 0, 3, 1),
(5, 3, 'PK-MAT-01', 'Maternidad Glow & Milk Bath', 'Sesión en estudio o exteriores semana 28-34 de gestación. Acceso al vestidor de vestidos de alta costura para embarazadas', 620.00, 90, 20, 8, '15x20 cm', 0, 0, 3, 1),
(6, 4, 'PK-RET-01', 'Retrato Profesional & Marca Personal', 'Headshots de alto impacto para LinkedIn, CEOs y médicos. Asesoría de poses e iluminación cinematográfica', 380.00, 60, 10, 0, 'Digital HD', 0, 0, 2, 1),
(7, 4, 'PK-FAM-01', 'Retrato Familiar de Estudio', 'Sesión cálida para hasta 6 integrantes familiares con fondos temáticos contemporáneos', 490.00, 75, 18, 5, '20x30 cm', 0, 0, 2, 1),
(8, 5, 'PK-CORP-01', 'E-commerce & Producto Pro', 'Fotografía de producto con fondo blanco puro y bodegón creativo para redes sociales y tiendas online', 980.00, 180, 40, 0, 'Digital Optimizado Web', 0, 0, 1, 1)
ON DUPLICATE KEY UPDATE `codigo` = VALUES(`codigo`);

-- Tabla de Sesiones Fotográficas
CREATE TABLE IF NOT EXISTS `sesiones` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `folio` VARCHAR(20) NOT NULL UNIQUE,
  `cliente_id` INT NOT NULL,
  `paquete_id` INT NOT NULL,
  `fotografo_id` INT NOT NULL,
  `fecha_sesion` DATE NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `tipo_locacion` ENUM('Estudio Principal', 'Exteriores', 'Domicilio', 'Iglesia / Evento') NOT NULL DEFAULT 'Estudio Principal',
  `direccion_locacion` VARCHAR(255) DEFAULT NULL,
  `tematica` VARCHAR(150) DEFAULT NULL,
  `estado` ENUM('Programada', 'En Sesión', 'Selección de Fotos', 'En Edición/Retoque', 'En Impresión/Lab', 'Lista para Entrega', 'Entregada', 'Cancelada') NOT NULL DEFAULT 'Programada',
  `precio_pactado` DECIMAL(10,2) NOT NULL,
  `costo_adicionales` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total` DECIMAL(10,2) NOT NULL,
  `anticipo` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `saldo_pendiente` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `estado_pago` ENUM('Pendiente', 'Adelanto', 'Cancelado') NOT NULL DEFAULT 'Pendiente',
  `notas` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`cliente_id`) REFERENCES `clientes`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`paquete_id`) REFERENCES `paquetes`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`fotografo_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Registros de Sesiones con datos realistas
INSERT INTO `sesiones` (`id`, `folio`, `cliente_id`, `paquete_id`, `fotografo_id`, `fecha_sesion`, `hora_inicio`, `hora_fin`, `tipo_locacion`, `direccion_locacion`, `tematica`, `estado`, `precio_pactado`, `costo_adicionales`, `total`, `anticipo`, `saldo_pendiente`, `estado_pago`, `notas`) VALUES
(1, 'SES-2026-081', 1, 4, 3, CURDATE(), '10:00:00', '12:00:00', 'Estudio Principal', 'Sala A - Newborn Climatizada', 'Sesión Newborn bebé Mateo (10 días de nacido)', 'En Sesión', 750.00, 50.00, 800.00, 400.00, 400.00, 'Adelanto', 'Traer calentador encendido 30 min antes. Cliente solicitó tonos tierra y beige.'),
(2, 'SES-2026-082', 3, 3, 2, CURDATE(), '15:30:00', '19:00:00', 'Exteriores', 'Parque El Olivar, San Isidro', 'Sesión Pre-15 Vestido Azul Zafiro', 'Programada', 2100.00, 100.00, 2200.00, 1200.00, 1000.00, 'Adelanto', 'Llevar reflector 5 en 1, flash Godox AD600Pro con softbox octabox.'),
(3, 'SES-2026-083', 4, 8, 2, CURDATE(), '11:30:00', '14:30:00', 'Estudio Principal', 'Ciclorama Blanco Set B', 'Campaña Invierno Colección Velvet', 'Selección de Fotos', 980.00, 0.00, 980.00, 980.00, 0.00, 'Cancelado', '40 productos en total, cliente seleccionando tomas por portal online.'),
(4, 'SES-2026-079', 2, 1, 2, DATE_SUB(CURDATE(), INTERVAL 3 DAY), '14:00:00', '22:00:00', 'Iglesia / Evento', 'Parroquia Santa María Reina & Hotel Westin', 'Boda Religiosa Alejandro & Daniela', 'En Edición/Retoque', 3200.00, 300.00, 3500.00, 2000.00, 1500.00, 'Adelanto', 'Diego en proceso de corrección de color y selección de 50 fotos para Photobook.'),
(5, 'SES-2026-077', 5, 7, 3, DATE_SUB(CURDATE(), INTERVAL 5 DAY), '16:00:00', '17:30:00', 'Estudio Principal', 'Set Familiar Vintage', 'Retrato Aniversario Bodas de Plata', 'En Impresión/Lab', 490.00, 150.00, 640.00, 640.00, 0.00, 'Cancelado', 'Enviado a laboratorio para impresión en papel algodón Fine Art 20x30.'),
(6, 'SES-2026-075', 1, 5, 3, DATE_SUB(CURDATE(), INTERVAL 8 DAY), '11:00:00', '12:30:00', 'Estudio Principal', 'Set Maternidad Boho Chic', 'Maternidad Dulce Espera', 'Lista para Entrega', 620.00, 0.00, 620.00, 620.00, 0.00, 'Cancelado', 'Caja de madera con impresiones y USB grabado listo en recepción.'),
(7, 'SES-2026-084', 5, 6, 2, DATE_ADD(CURDATE(), INTERVAL 1 DAY), '09:30:00', '10:30:00', 'Estudio Principal', 'Set Ejecutivo Minimalista', 'Headshot Corporativo Directorio', 'Programada', 380.00, 0.00, 380.00, 200.00, 180.00, 'Adelanto', 'Fondo gris neutro y degradado azul suave para perfil LinkedIn corporativo.')
ON DUPLICATE KEY UPDATE `folio` = VALUES(`folio`);

-- Tabla de Pagos
CREATE TABLE IF NOT EXISTS `pagos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `sesion_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `metodo_pago` ENUM('Efectivo', 'Yape / Plin', 'Tarjeta Débito/Crédito', 'Transferencia Bancaria') NOT NULL,
  `referencia` VARCHAR(100) DEFAULT NULL,
  `fecha_pago` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `usuario_id` INT NOT NULL,
  `concepto` VARCHAR(150) NOT NULL,
  `comprobante_tipo` ENUM('Recibo', 'Boleta', 'Factura') DEFAULT 'Boleta',
  `comprobante_numero` VARCHAR(30) DEFAULT NULL,
  FOREIGN KEY (`sesion_id`) REFERENCES `sesiones`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`cliente_id`) REFERENCES `clientes`(`id`) ON DELETE RESTRICT,
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `pagos` (`id`, `sesion_id`, `cliente_id`, `monto`, `metodo_pago`, `referencia`, `usuario_id`, `concepto`, `comprobante_tipo`, `comprobante_numero`) VALUES
(1, 1, 1, 400.00, 'Yape / Plin', 'OPE-839201', 1, 'Anticipo 50% Sesión Newborn', 'Boleta', 'B001-000491'),
(2, 2, 3, 1200.00, 'Transferencia Bancaria', 'BCP-992014', 1, 'Anticipo Reserva Paquete Quinceañera', 'Boleta', 'B001-000492'),
(3, 3, 4, 980.00, 'Tarjeta Débito/Crédito', 'POS-VISA-551', 1, 'Liquidación 100% Fotografía Lookbook Velvet', 'Factura', 'F001-000188'),
(4, 4, 2, 2000.00, 'Transferencia Bancaria', 'BBVA-441029', 1, 'Anticipo Cobertura Boda Alejandro & Daniela', 'Factura', 'F001-000189'),
(5, 5, 5, 640.00, 'Tarjeta Débito/Crédito', 'POS-MASTERCARD-88', 1, 'Pago Total Retrato Familiar Aniversario', 'Boleta', 'B001-000493'),
(6, 6, 1, 620.00, 'Yape / Plin', 'OPE-448123', 1, 'Pago Total Sesión Maternidad Boho', 'Boleta', 'B001-000494'),
(7, 7, 5, 200.00, 'Efectivo', 'CAJA-DIR', 1, 'Seña reserva Headshots Ejecutivos', 'Recibo', 'REC-0012')
ON DUPLICATE KEY UPDATE `monto` = VALUES(`monto`);

-- Tabla de Equipos Fotográficos e Inventario de Producción
CREATE TABLE IF NOT EXISTS `equipos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `codigo` VARCHAR(20) NOT NULL UNIQUE,
  `nombre` VARCHAR(100) NOT NULL,
  `categoria` ENUM('Cámara', 'Lente / Óptica', 'Iluminación / Flash', 'Dron / Estabilizador', 'Audio & Grabación', 'Accesorios & Fondos') NOT NULL,
  `marca_modelo` VARCHAR(100) NOT NULL,
  `num_serie` VARCHAR(50) DEFAULT NULL,
  `estado` ENUM('Disponible', 'En Uso / Sesión', 'En Mantenimiento', 'Reservado') NOT NULL DEFAULT 'Disponible',
  `fotografo_asignado_id` INT DEFAULT NULL,
  `fecha_adquisicion` DATE DEFAULT NULL,
  `valor_estimado` DECIMAL(10,2) DEFAULT 0.00,
  `notas` TEXT,
  FOREIGN KEY (`fotografo_asignado_id`) REFERENCES `usuarios`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `equipos` (`id`, `codigo`, `nombre`, `categoria`, `marca_modelo`, `num_serie`, `estado`, `fotografo_asignado_id`, `fecha_adquisicion`, `valor_estimado`, `notas`) VALUES
(1, 'EQ-CAM-01', 'Cámara Mirrorless Sony Alpha 7 IV (Cuerpo)', 'Cámara', 'Sony A7 IV 33MP Full Frame', 'SN-8492019', 'En Uso / Sesión', 2, '2024-03-15', 9800.00, 'Cámara principal para bodas y eventos en exteriores'),
(2, 'EQ-CAM-02', 'Cámara Canon EOS R6 Mark II', 'Cámara', 'Canon EOS R6 II 24.2MP', 'SN-5521904', 'Disponible', 3, '2024-06-20', 9200.00, 'Excelente para sesiones infantiles y retratos continuos'),
(3, 'EQ-LEN-01', 'Lente Sony FE 24-70mm f/2.8 GM II', 'Lente / Óptica', 'Sony G Master 24-70mm f/2.8', 'SN-GM29401', 'En Uso / Sesión', 2, '2024-03-15', 7800.00, 'Óptica todoterreno de máxima nitidez'),
(4, 'EQ-LEN-02', 'Lente Sony FE 85mm f/1.4 GM (Retrato)', 'Lente / Óptica', 'Sony G Master 85mm f/1.4', 'SN-GM85012', 'Disponible', NULL, '2023-11-10', 5600.00, 'Bokeh cremoso para retratos de novias y graduaciones'),
(5, 'EQ-ILU-01', 'Flash de Estudio Godox AD600Pro TTL (Batería)', 'Iluminación / Flash', 'Godox Witstro AD600Pro 600W', 'SN-GD60012', 'En Uso / Sesión', 2, '2024-01-20', 3200.00, 'Incluye montura Bowens y trigger inalámbrico Godox XPro II'),
(6, 'EQ-ILU-02', 'Kit de 2 Flashes Godox SK400II con Softbox', 'Iluminación / Flash', 'Godox SK400II Studio Strobe', 'SN-SK400SET', 'Disponible', NULL, '2023-08-14', 1850.00, 'Instalados fijos en ciclorama del Set A'),
(7, 'EQ-DRN-01', 'Dron DJI Mavic 3 Pro Cine Combo', 'Dron / Estabilizador', 'DJI Mavic 3 Pro Tri-Cámara Hasselblad', 'SN-DJI98210', 'Disponible', NULL, '2024-05-10', 11500.00, 'Para tomas aéreas de bodas campestres y haciendas'),
(8, 'EQ-GMB-01', 'Gimbal DJI RS 3 Pro Combo', 'Dron / Estabilizador', 'DJI RS3 Pro con motor Focus', 'SN-RS399120', 'Disponible', NULL, '2024-02-18', 3400.00, 'Estabilizador de 3 ejes para video cinemático')
ON DUPLICATE KEY UPDATE `codigo` = VALUES(`codigo`);

-- Control de Caja y Finanzas Diarias
CREATE TABLE IF NOT EXISTS `cajas` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `fecha` DATE NOT NULL,
  `monto_apertura` DECIMAL(10,2) NOT NULL DEFAULT 300.00,
  `total_ingresos_efectivo` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total_ingresos_digital` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total_egresos` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `saldo_esperado` DECIMAL(10,2) NOT NULL DEFAULT 300.00,
  `estado` ENUM('Abierta', 'Cerrada') NOT NULL DEFAULT 'Abierta',
  `usuario_id` INT NOT NULL,
  `notas` VARCHAR(255) DEFAULT 'Apertura de turno de estudio',
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `cajas` (`id`, `fecha`, `monto_apertura`, `total_ingresos_efectivo`, `total_ingresos_digital`, `total_egresos`, `saldo_esperado`, `estado`, `usuario_id`, `notas`) VALUES
(1, CURDATE(), 300.00, 200.00, 1380.00, 53.90, 446.10, 'Abierta', 1, 'Caja de turno matutino / vespertino en operación normal')
ON DUPLICATE KEY UPDATE `fecha` = VALUES(`fecha`);

-- Movimientos de Caja Chica / Gastos del Estudio
CREATE TABLE IF NOT EXISTS `caja_movimientos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `caja_id` INT NOT NULL,
  `tipo` ENUM('Ingreso', 'Egreso') NOT NULL,
  `categoria` VARCHAR(50) NOT NULL,
  `concepto` VARCHAR(255) NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `metodo_pago` VARCHAR(50) DEFAULT 'Efectivo',
  `comprobante` VARCHAR(50) DEFAULT NULL,
  `usuario_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`caja_id`) REFERENCES `cajas`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `caja_movimientos` (`id`, `caja_id`, `tipo`, `categoria`, `concepto`, `monto`, `metodo_pago`, `comprobante`, `usuario_id`) VALUES
(1, 1, 'Egreso', 'Insumos Estudio', 'Compra de baterías recargables Eneloop Pro AA y pilas 9V para disparadores', 38.90, 'Efectivo', 'B002-9912', 1),
(2, 1, 'Egreso', 'Cafetería Clientes', 'Agua mineral y café gourmet para sala de espera de novios', 15.00, 'Efectivo', 'Ticket-0091', 1),
(3, 1, 'Ingreso', 'Anticipo Sesión', 'Seña en efectivo Headshot Ejecutivo (SES-2026-084)', 200.00, 'Efectivo', 'REC-0012', 1)
ON DUPLICATE KEY UPDATE `concepto` = VALUES(`concepto`);

-- Módulo CRM: Leads y Prospectos
CREATE TABLE IF NOT EXISTS `crm_leads` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `interes` VARCHAR(150) NOT NULL,
  `etapa` ENUM('Nuevo', 'Contactado', 'Cotizado', 'Negociacion', 'Ganado', 'Perdido') NOT NULL DEFAULT 'Nuevo',
  `origen` VARCHAR(50) DEFAULT 'WhatsApp',
  `valor_estimado` DECIMAL(10,2) DEFAULT 0.00,
  `notas` TEXT,
  `creado_en` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `crm_leads` (`nombre`, `telefono`, `email`, `interes`, `etapa`, `origen`, `valor_estimado`) VALUES 
('Valeria Torres', '987654321', 'valeria.t@gmail.com', 'Sesión de Embarazo en playa', 'Nuevo', 'Instagram', 650.00),
('Empresa XYZ', '999888777', 'contacto@xyz.com', 'Fotografía de Productos', 'Contactado', 'Web', 1200.00),
('Familia Rojas', '912345678', NULL, 'Sesión Familiar Navideña', 'Cotizado', 'WhatsApp', 450.00),
('Carla y Pedro', '998877665', 'carla.bodas@gmail.com', 'Cobertura Matrimonio Civil', 'Negociacion', 'Recomendacion', 2500.00),
('Sofía Mendoza', '981122334', NULL, 'Fotos para LinkedIn', 'Ganado', 'Instagram', 200.00);

-- Módulo CRM: Historial de Actividades
CREATE TABLE IF NOT EXISTS `crm_actividades` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `lead_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `tipo` ENUM('Llamada', 'WhatsApp', 'Email', 'Reunion', 'Nota') NOT NULL DEFAULT 'Nota',
  `descripcion` TEXT NOT NULL,
  `fecha` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`lead_id`) REFERENCES `crm_leads`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
