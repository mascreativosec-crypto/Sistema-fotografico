<?php
/**
 * Front Controller & Router · SysFoto Studio
 * Arquitectura MVC PHP Nativo con Enrutamiento Extendido para CRUD
 */

require_once __DIR__ . '/../app/config/config.php';
require_once __DIR__ . '/../app/config/database.php';

// Controladores
require_once __DIR__ . '/../app/controllers/AuthController.php';
require_once __DIR__ . '/../app/controllers/DashboardController.php';
require_once __DIR__ . '/../app/controllers/SesionesController.php';
require_once __DIR__ . '/../app/controllers/ClientesController.php';
require_once __DIR__ . '/../app/controllers/PaquetesController.php';
require_once __DIR__ . '/../app/controllers/EquiposController.php';
require_once __DIR__ . '/../app/controllers/CajaController.php';
require_once __DIR__ . '/../app/controllers/PagosController.php';
require_once __DIR__ . '/../app/controllers/PersonalController.php';
require_once __DIR__ . '/../app/controllers/ConfigController.php';
require_once __DIR__ . '/../app/controllers/IaController.php';
require_once __DIR__ . '/../app/controllers/CrmController.php';
require_once __DIR__ . '/../app/controllers/EmpresaController.php';

// Obtener ruta solicitada
$route = $_GET['r'] ?? 'dashboard';

// Enrutamiento MVC
switch ($route) {
    // Autenticación
    case 'login':
        (new AuthController())->login();
        break;
    case 'logout':
        (new AuthController())->logout();
        break;

    // Dashboard
    case 'dashboard':
        (new DashboardController())->index();
        break;

    // Módulo Clientes CRUD
    case 'clientes':
        (new ClientesController())->index();
        break;
    case 'nuevo_cliente':
        (new ClientesController())->create();
        break;
    case 'clientes_edit':
        (new ClientesController())->edit();
        break;
    case 'clientes_toggle':
        (new ClientesController())->toggle();
        break;
    case 'clientes_delete':
        (new ClientesController())->delete();
        break;
    case 'clientes_detail':
        (new ClientesController())->detail();
        break;

    // Módulo Sesiones CRUD
    case 'sesiones':
        (new SesionesController())->index();
        break;
    case 'nueva_sesion':
        (new SesionesController())->create();
        break;
    case 'sesiones_edit':
        (new SesionesController())->edit();
        break;
    case 'sesiones_estado':
        (new SesionesController())->cambiar_estado();
        break;
    case 'sesiones_delete':
        (new SesionesController())->delete();
        break;
    case 'sesiones_detail':
        (new SesionesController())->detail();
        break;

    // Módulo Paquetes CRUD
    case 'paquetes':
        (new PaquetesController())->index();
        break;
    case 'paquetes_create':
        (new PaquetesController())->create();
        break;
    case 'paquetes_edit':
        (new PaquetesController())->edit();
        break;
    case 'paquetes_toggle':
        (new PaquetesController())->toggle();
        break;
    case 'paquetes_delete':
        (new PaquetesController())->delete();
        break;
    case 'paquetes_detail':
        (new PaquetesController())->detail();
        break;

    // Módulo Equipos CRUD
    case 'equipos':
        (new EquiposController())->index();
        break;
    case 'equipos_create':
        (new EquiposController())->create();
        break;
    case 'equipos_edit':
        (new EquiposController())->edit();
        break;
    case 'equipos_estado':
        (new EquiposController())->cambiar_estado();
        break;
    case 'equipos_delete':
        (new EquiposController())->delete();
        break;
    case 'equipos_detail':
        (new EquiposController())->detail();
        break;

    // Módulo Caja
    case 'caja':
        (new CajaController())->index();
        break;
    case 'caja_movimiento':
        (new CajaController())->movimiento();
        break;
    case 'caja_delete':
        (new CajaController())->delete();
        break;
    case 'caja_cerrar':
        (new CajaController())->cerrar();
        break;

    // Módulo Agenda
    case 'agenda':
        if (empty($_SESSION['user'])) { header('Location: ' . BASE_URL . '/?r=login'); exit; }
        $currentUser = $_SESSION['user'];
        $currentRoute = 'agenda';
        $pageTitle = 'Agenda & Citas · StudioFoto Pro';
        require_once APP_PATH . '/views/layouts/header.php';
        require_once APP_PATH . '/views/layouts/sidebar.php';
        require_once APP_PATH . '/views/agenda/index.php';
        require_once APP_PATH . '/views/layouts/footer.php';
        break;

    // Módulo Galería
    case 'galeria':
        if (empty($_SESSION['user'])) { header('Location: ' . BASE_URL . '/?r=login'); exit; }
        $currentUser = $_SESSION['user'];
        $currentRoute = 'galeria';
        $pageTitle = 'Galería & Selección · StudioFoto Pro';
        require_once APP_PATH . '/views/layouts/header.php';
        require_once APP_PATH . '/views/layouts/sidebar.php';
        require_once APP_PATH . '/views/galeria/index.php';
        require_once APP_PATH . '/views/layouts/footer.php';
        break;

    // Módulo Laboratorio
    case 'laboratorio':
        if (empty($_SESSION['user'])) { header('Location: ' . BASE_URL . '/?r=login'); exit; }
        $currentUser = $_SESSION['user'];
        $currentRoute = 'laboratorio';
        $pageTitle = 'Laboratorio & Entregas · StudioFoto Pro';
        require_once APP_PATH . '/views/layouts/header.php';
        require_once APP_PATH . '/views/layouts/sidebar.php';
        require_once APP_PATH . '/views/laboratorio/index.php';
        require_once APP_PATH . '/views/layouts/footer.php';
        break;

    // Módulo Pagos & Cobranzas CRUD
    case 'pagos':
        (new PagosController())->index();
        break;
    case 'pagos_create':
        (new PagosController())->create();
        break;
    case 'pagos_delete':
        (new PagosController())->delete();
        break;
    case 'pagos_detail':
        (new PagosController())->detail();
        break;

    // Módulo Personal & Staff CRUD
    case 'personal':
        (new PersonalController())->index();
        break;
    case 'personal_create':
        (new PersonalController())->create();
        break;
    case 'personal_edit':
        (new PersonalController())->edit();
        break;
    case 'personal_toggle':
        (new PersonalController())->toggle();
        break;
    case 'personal_delete':
        (new PersonalController())->delete();
        break;
    case 'personal_detail':
        (new PersonalController())->detail();
        break;

    // Módulo Reportes
    case 'reportes':
        if (empty($_SESSION['user'])) { header('Location: ' . BASE_URL . '/?r=login'); exit; }
        $currentUser = $_SESSION['user'];
        $currentRoute = 'reportes';
        $pageTitle = 'Reportes & Estadísticas · StudioFoto Pro';
        require_once APP_PATH . '/views/layouts/header.php';
        require_once APP_PATH . '/views/layouts/sidebar.php';
        require_once APP_PATH . '/views/reportes/index.php';
        require_once APP_PATH . '/views/layouts/footer.php';
        break;

    // Módulo Configuración
    case 'config':
        (new ConfigController())->index();
        break;
    case 'config_save':
        (new ConfigController())->save();
        break;

    // Módulo Empresa & Marca
    case 'empresa':
        (new EmpresaController())->index();
        break;
    case 'empresa_save':
        (new EmpresaController())->save();
        break;

    // Módulo Copia de Seguridad & Restauración
    case 'backup':
        (new EmpresaController())->backupIndex();
        break;
    case 'backup_download':
        (new EmpresaController())->backupDownload();
        break;
    case 'backup_restore':
        (new EmpresaController())->backupRestore();
        break;
    case 'backup_reset':
        (new EmpresaController())->backupReset();
        break;
    case 'backup_clear_demo':
        (new EmpresaController())->backupClearDemo();
        break;

    // Módulo IA
    case 'ia':
        (new IaController())->index();
        break;
    case 'ia_chat':
        (new IaController())->chat();
        break;
    case 'ia_ask':
        (new IaController())->ask();
        break;
    case 'ia_api_chat':
        (new IaController())->api_chat();
        break;
    case 'ia_config':
        (new IaController())->saveConfig();
        break;
    case 'ia_has_key':
        (new IaController())->hasKey();
        break;


    // Módulo CRM
    case 'crm_panel':
        (new CrmController())->panel();
        break;
    case 'crm_clientes':
        (new CrmController())->clientes();
        break;
    case 'crm_segmentos':
        (new CrmController())->segmentos();
        break;
    case 'crm_pipeline':
        (new CrmController())->pipeline();
        break;
    case 'crm_tareas':
        (new CrmController())->tareas();
        break;
    case 'crm_campanas':
        (new CrmController())->campanas();
        break;
    case 'crm_update_etapa':
        (new CrmController())->updateEtapa();
        break;
    case 'crm_create_oportunidad':
        (new CrmController())->createOportunidad();
        break;


    default:
        if (empty($_SESSION['user'])) {
            (new AuthController())->login();
        } else {
            (new DashboardController())->index();
        }
        break;
}
