// Configuración de URLs de API (IE7)
//
// Objetivo:
// - Evitar IPs "hardcodeadas" en el código (mala práctica).
// - Permitir configurar las URLs por entorno (local / AWS).
//
// Prioridad:
// 1) env.js en producción (Docker + Nginx): window.__ENV__
// 2) Variables de Vite en desarrollo: import.meta.env

const env = (typeof window !== "undefined" && window.__ENV__) ? window.__ENV__ : {};

export const API_VENTAS =
  env.VENTAS_URL || import.meta.env.VITE_VENTAS_URL || "";

export const API_DESPACHOS =
  env.DESPACHOS_URL || import.meta.env.VITE_DESPACHOS_URL || "";

