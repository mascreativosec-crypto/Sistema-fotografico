# StudioFoto Pro · Sistema Integral para Estudio Fotográfico 📸

Sistema Web profesional para la administración integral de estudios fotográficos y agencias de producción visual. Desarrollado en **PHP Nativo con Arquitectura MVC**, interfaz moderna construida con **Bootstrap 5**, **Bootstrap Icons**, **Chart.js** y el sistema de diseño visual de alto impacto **Tema SysTienda** (SaaS Dashboard con gradientes violeta/índigo y soporte dual **Modo Claro / Modo Oscuro**).

---

## 🚀 Acceso Rápido a la Aplicación

- **URL Local:** `http://localhost/sys_fotografia/`
- **Servidor Web:** Apache (Laragon / XAMPP)
- **Base de Datos MySQL:** `sys_fotografia` (puerto `3306`)

### 🔑 Credenciales de Acceso (Cuentas Demo Preconfiguradas)

| Rol | Usuario / Email | Contraseña | Funciones |
| :--- | :--- | :--- | :--- |
| **Administrador** | `admin` | `admin123` | Control total, reportes, caja, configuración |
| **Fotógrafo Principal** | `cmendoza` | `admin123` | Agenda, sesiones asignadas, locaciones |
| **Recepción / Ventas** | `vponce` | `admin123` | Clientes, registro de citas, cobros y caja |
| **Editor / Retocador** | `drivas` | `admin123` | Flujo de laboratorio, selección y photobooks |

---

## 🎨 Características de Diseño (tema_sys_tienda)

- **Login Split-Screen de Alta Gama:**
  - Columna izquierda con gradiente violeta/índigo, orbes de luz, propuesta de valor y tarjetas métricas flotantes en tiempo real.
  - Columna derecha con credenciales, selector rápido de perfiles demo con un clic y toggle para ver contraseñas.
- **Modo Claro y Modo Oscuro Instantáneo:**
  - Botón de alternancia de tema sin parpadeo blanco (pre-render script con persistencia en `localStorage`).
- **Sidebar Jerárquico Completo:**
  - Menú lateral oscuro con diseño vertical, submenús desplegables, badges de estado en vivo y perfil del usuario en la parte inferior.
  - Modo colapsable a barra compacta (Mini Sidebar) y adaptación táctil para móviles.
- **Topbar Sticky Inteligente:**
  - Buscador global con atajo de teclado (`Ctrl + K`).
  - Reloj en vivo y fecha dinámica.
  - Botón de acción rápida con gradiente: `+ Nueva Sesión`.
  - Notificaciones de estudio en tiempo real.
- **Dashboard Principal Visual:**
  - **Banner Hero de Bienvenida:** Saludo dinámico según la hora del día, widget radial interactivo de cumplimiento de meta mensual y accesos directos.
  - **Widget de Caja de Turno:** Estado en vivo ("Abierta"), desglose de dinero en efectivo físico, ingresos por transferencias / Yape / POS y gastos.
  - **4 KPIs con Degradados Premium:** Ingresos del Mes (Violeta), Sesiones Activas (Cian), Retoque & Laboratorio (Verde Esmeralda) y Saldos por Cobrar (Naranja).
  - **Gráficos Interactivos (Chart.js):** Curva suave de evolución de facturación y gráfico de dona con desglose por categoría de eventos.
  - **Mesa de Producción & Agenda:** Tabla con estatus visuales de etapas y próximas citas del día.

---

## 💼 Módulos y Funcionalidades para Estudios Fotográficos

1. **Dashboard General:** Monitoreo financiero, citas del día, avance de metas y estado de taller.
2. **Agenda & Citas:** Calendario de turnos de estudio (Set A, Set B) y locaciones exteriores.
3. **Sesiones & Producción:** Control paso a paso del ciclo de vida fotográfico:
   - *1. Programada* → *2. En Sesión* → *3. Selección del Cliente* → *4. Retoque / Fine Art* → *5. Impresión & Lab* → *6. Entregada*.
4. **Galería & Selección Digital:** Gestión de links privados para que los novios/clientes elijan sus fotografías favoritas desde casa.
5. **Laboratorio & Entregas:** Control de ampliaciones en papel de algodón, lienzos, photobooks de piel y cajas de madera con USB.
6. **Control de Caja Chica & Arqueo:** Registro de movimientos diarios, compras de insumos (baterías, utilería), cafetín y rendición de cuentas.
7. **Pagos & Cobranzas:** Registro de señas iniciales, saldos contra entrega, métodos (Yape, Plin, Transferencias BCP/BBVA, Tarjetas, Efectivo).
8. **Paquetes & Servicios:** Catálogo configurado con precios y especificaciones:
   - Bodas & Matrimonios (Cobertura completa, Drone 4K, Photobook)
   - Quinceañeras (Estudio + exteriores con cambios de vestuario)
   - Newborn & Maternidad (Estudio climatizado, atrezzo)
   - Retrato Fine Art & Marca Personal (LinkedIn, corporativo)
   - E-commerce & Catálogo de Productos
9. **Cámaras & Equipos:** Inventario de cámaras Full Frame (Sony A7 IV, Canon R6 II), lentes G Master, flashes Godox AD600Pro y drones con control de disponibilidad y fotógrafo asignado.
10. **Clientes & Familias:** Directorio con teléfono, canal de captación (Instagram, TikTok, Recomendación) y botón directo a WhatsApp.
11. **Reportes & Exportación:** Ranking de paquetes más vendidos, ingresos por especialidad e impresión de reportes.
12. **Configuración del Estudio:** RUC, dirección, moneda (`S/`), metas y horarios.

---

## 🗄️ Estructura del Proyecto MVC

```
sys_fotografia/
├── app/
│   ├── config/
│   │   ├── config.php          # Detección dinámica de URL y parámetros
│   │   └── database.php        # Conexión Singleton PDO segura en UTF-8
│   ├── controllers/
│   │   ├── AuthController.php
│   │   ├── DashboardController.php
│   │   ├── SesionesController.php
│   │   ├── ClientesController.php
│   │   ├── PaquetesController.php
│   │   ├── EquiposController.php
│   │   └── CajaController.php
│   ├── models/
│   │   ├── User.php
│   │   ├── Sesion.php
│   │   ├── Cliente.php
│   │   ├── Paquete.php
│   │   ├── Equipo.php
│   │   └── Caja.php
│   └── views/
│       ├── layouts/
│       │   ├── header.php
│       │   ├── sidebar.php
│       │   ├── topbar.php
│       │   └── footer.php
│       ├── auth/
│       │   └── login.php
│       ├── dashboard/
│       │   └── index.php
│       ├── sesiones/
│       ├── clientes/
│       ├── paquetes/
│       ├── equipos/
│       ├── caja/
│       ├── agenda/
│       ├── galeria/
│       ├── laboratorio/
│       ├── pagos/
│       ├── personal/
│       ├── reportes/
│       └── config/
├── public/
│   ├── index.php               # Front Controller principal
│   └── assets/
│       ├── css/
│       │   └── theme-sys-tienda.css
│       └── js/
│           ├── app.js
│           └── dashboard.js
├── database/
│   └── schema.sql              # Script DDL + DML completo
├── index.php                   # Redirección amigable desde la raíz
└── README.md
```
