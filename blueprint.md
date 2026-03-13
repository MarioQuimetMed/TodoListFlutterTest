
# Blueprint: Flutter TODO List App

## Visión General

Esta es una aplicación de lista de tareas (TODO list) creada con Flutter. El objetivo es proporcionar una experiencia de usuario limpia, moderna y agradable para gestionar tareas diarias. La aplicación permite a los usuarios crear, ver, marcar como completadas y eliminar tareas. Los datos se guardan localmente en una base de datos SQLite para que sean persistentes entre sesiones.

## Características Implementadas

*   **Crear Tareas:** Los usuarios pueden agregar nuevas tareas a través de un diálogo.
*   **Ver Tareas:** Las tareas se muestran en una lista en la pantalla principal.
*   **Marcar como Completadas:** Cada tarea tiene un checkbox para marcarla como completada. Las tareas completadas se muestran visualmente diferentes (tachadas).
*   **Eliminar Tareas:** Los usuarios pueden eliminar tareas de la lista.
*   **Persistencia de Datos:** Las tareas se almacenan en una base de datos SQLite local usando el paquete `sqflite`, por lo que no se pierden al cerrar la aplicación.

## Estilo y Diseño (Versión Inicial)

*   **UI:** Basada en `Scaffold`, `AppBar`, `ListView`, y `FloatingActionButton`.
*   **Componentes:** `ListTile` dentro de un `Card` para cada tarea.
*   **Colores:** Tema principal por defecto de Flutter (azul).
*   **Tipografía:** Fuente por defecto del sistema.

## Plan de Mejoras (Iteración Actual)

El objetivo de esta iteración es mejorar drásticamente la interfaz de usuario (UI) y la experiencia de usuario (UX) para que la aplicación se sienta moderna, profesional y agradable de usar.

1.  **Instalar Dependencias:**
    *   `flutter_animate`: Para agregar animaciones fluidas y atractivas.
    *   `google_fonts`: Para usar tipografías personalizadas y mejorar la legibilidad y el estilo.

2.  **Renovar el Tema Global (`main.dart`):**
    *   Definir una paleta de colores más sofisticada y moderna.
    *   Utilizar `GoogleFonts` para establecer una tipografía base para toda la aplicación (por ejemplo, `Poppins` o `Montserrat`).
    *   Activar `Material 3` para un look más actual.

3.  **Rediseñar la Pantalla de Tareas (`firstscreen.dart`):**
    *   **Animación de Entrada:** Animar la lista de tareas cuando aparece en pantalla para dar una sensación de fluidez.
    *   **Mejorar el Diseño de las Tareas:**
        *   Reemplazar el `ListTile` estándar con un diseño personalizado.
        *   Usar mejores márgenes, sombreados y colores para cada tarea.
        *   Diseñar un checkbox más estilizado.
    *   **Mejorar el Mensaje de "No hay tareas":** Hacerlo más visual y amigable.
    *   **Mejorar el Diálogo para Agregar Tareas:** Aplicar el nuevo estilo de colores y fuentes.
    *   **Efectos Visuales:** Añadir sutiles efectos de "hover" o al presionar los elementos para una mejor retroalimentación visual.
