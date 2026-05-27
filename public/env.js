// Archivo por defecto para evitar 404 en desarrollo.
// En producción (Docker + Nginx) el contenedor lo sobrescribe al iniciar.
window.__ENV__ = {
  VENTAS_URL: "",
  DESPACHOS_URL: ""
};

