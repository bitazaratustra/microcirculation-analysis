# Análisis Automatizado de Dinámicas Microvasculares Sublinguales

**Ingeniería Biomédica** | 2024-2025

---

## 📋 Tabla de Contenidos

1. [Resumen Ejecutivo](#resumen-ejecutivo)
2. [Descripción del Proyecto](#descripción-del-proyecto)
3. [Fundamentos Científicos](#fundamentos-científicos)
4. [Estructura del Repositorio](#estructura-del-repositorio)
5. [Requisitos e Instalación](#requisitos-e-instalación)
6. [Pipeline de Análisis](#pipeline-de-análisis)
7. [Uso del Sistema](#uso-del-sistema)
8. [Resultados y Métricas](#resultados-y-métricas)

---

## 📊 Resumen Ejecutivo

Este proyecto desarrolla un sistema automatizado para el análisis cuantitativo de dinámicas microvasculares sublinguales a partir de videos de intravital microscopia.

### Objetivos Principales

- **Análisis Cuantitativo**: Extraer métricas objetivas de densidad vascular (SVD, TVD)
- **Segmentación Automática**: Implementar algoritmos robustos de segmentación de vasos
- **Dinámicas Temporales**: Modelar cambios en perfusión a lo largo del tiempo
- **Clasificación Clínica**: Estratificar pacientes según indicadores de prognóstico
- **Reproducibilidad**: Resultados auditables y documentados

---

## 🔬 Descripción del Proyecto

### Contexto Clínico

La **microcirculación sublingual** es un indicador directo del estado de perfusión tisular en pacientes críticos. El análisis cuantitativo mediante intravital microscopia permite diagnóstico temprano y monitoreo no invasivo.

### Limitaciones del Método Manual

- ⏱️ 20-30 minutos por video
- 👨‍⚕️ Variabilidad inter-observador
- 📝 Propenso a errores
- ❌ Evaluación cualitativa

### Solución Propuesta

Pipeline **automatizado** que:
1. Procesa videos en **minutos**
2. Genera **métricas objetivas**
3. Documenta **automáticamente**
4. **Reproduce** resultados

---
## 🧬 Fundamentos Científicos

### Conceptos Clave

#### Small Vessel Density (SVD)
Define la densidad de vasos con diámetro < 20 μm. Es indicador crítico de:
- Capacidad de intercambio gas-nutrientes
- Distribución heterogénea en trauma/sepsis
- Reducción asociada a mortalidad en pacientes críticos

#### Total Vessel Density (TVD)
Densidad total incluyendo vasos de todos los diámetros. Mide:
- Cobertura vascular global
- Rarefacción en estados de hipoperfusión
- Recuperación post-intervención terapéutica

#### Categorías de Flujo
Clasificación cualitativa de patrón de flujo eritrocitario:
- **Cat 0**: Estasis (sin movimiento)
- **Cat 1**: Flujo intermitente (perfusión pendular)
- **Cat 2**: Flujo lento (velocidad reducida pero presente)
- **Cat 3**: Flujo continuo (perfusión normal)

**Interpretación**: Mayor proporción de Cat 3 indica mejor perfusión tisular y pronóstico

### Métricas Derivadas

**Perfusion Index (PI)**
```
PI = (Vasos con flujo / Total vasos) × 100
```
Rango > 80-90% indica perfusión adecuada

**Microvascular Flow Index (MFI)**
```
MFI = Σ(categoría × frecuencia) / Total vasos
```
Escala 0-3: mayor valor = mejor perfusión

**Heterogeneity Index (HI)**
```
HI = Desv.Estándar(velocidades) / Media(velocidades)
```
Indica uniformidad de perfusión (HI↑ = heterogeneidad↑)

### Métodos de Segmentación

| Método | Ventaja | Desventaja |
|--------|---------|-----------|
| **Adaptativo** | Local, sensible a cambios | Lento |
| **Otsu** | Automático, global | Sensible a ruido |
| **CLAHE** | Realce de contraste | Puede sobre-realzar |
| **Híbrido** | Balance óptimo | Requiere ajuste |

---

## 🏗️ Pipeline de Análisis

### Arquitectura General

```
ENTRADA (Videos)
    ↓
[01] Exploración de Datos
    ↓
[02] Preprocesamiento (Estabilización)
    ↓
[03] Anotaciones Manuales + Visualización
    ↓
[04] Entrenamiento de Segmentador
    ↓
[05] Validación: Automático vs. Manual
    ↓
[06] Extracción de Características Espacio-Temporales
    ↓
[07] Modelado de Dinámicas
    ↓
[08] Métricas Clínicas y Comparación
    ↓
[09] Resumen de Resultados
    ↓
SALIDA (CSV, PNG, Reportes)
```

### Descripción Detallada de Notebooks

#### **Notebook 01: Data Exploration** 
*Entrada*: Videos crudos en MP4/AVI  
*Proceso*:
- Inspeccionar estructura de datos
- Verificar integridad de archivos
- Estadísticas básicas (duración, resolución, fps)
- Identificar artefactos o problemas de captura

*Salida*: Reporte de calidad de datos

---

#### **Notebook 02: Data Preprocessing**
*Entrada*: Videos de microscopia
*Proceso*:
- Estabilización espacial (compensar movimiento de la cámara)
- Normalización de histograma
- Recorte de región de interés (ROI)
- Sincronización temporal

*Salida*: Frames procesados, listos para anotación

---

#### **Notebook 03: Annotation and Visualization**
*Entrada*: CSV con anotaciones manuales  
*Proceso*:
- Carga y validación de datos
- Clasificación de vasos por categoría de flujo
- Tratamiento de velocidades individuales (V1-V20)
- Cálculo de densidades vasculares (SVD, TVD)
- Visualizaciones exploratorias

*Salida*: 
- `annotations_processed.csv` (dataset limpio)
- `annotations_summary_report.txt` (estadísticas)
- 4 figuras PNG (distribuciones)

---

#### **Notebook 04: Vessel Segmentation Training**
*Entrada*: Frames estabilizados + anotaciones
*Proceso*:
- Comparación de 4 métodos de segmentación:
  1. Threshold Adaptativo
  2. Otsu Global
  3. CLAHE (Contrast Limited Adaptive Histogram Equalization)
  4. Híbrido (combinación optimizada)
- Evaluación de calidad (% vasos, componentes conectados, edges)
- Extracción de características esqueletales
  - Longitud esqueletal
  - Puntos de ramificación (branch points)
  - Endpoints (terminales vasculares)

*Salida*:
- Máscaras binarias de segmentación
- Esqueletos de red vascular
- Métricas de calidad por método
- Figuras comparativas

---

#### **Notebook 05: Segmented Video Analysis**
*Entrada*: Frames segmentados automáticos + anotaciones manuales
*Proceso*:
- Aplicación de segmentador a todos los frames
- Extracción de métricas automáticas
- Validación cruzada: automático vs. manual
- Cálculo de errores:
  - Error absoluto medio (MAE)
  - Correlación de Spearman
  - Acuerdo visual-automático

*Salida*:
- `integration_results.csv` (comparativa)
- Matriz de validación
- Análisis de discrepancias

---

#### **Notebook 06: Feature Extraction (Space-Time)**
*Entrada*: Videos segmentados
*Proceso*:
- Construcción de diagramas espacio-tiempo
- Análisis de series temporales:
  - Velocidad media, desv. estándar, CV
  - Patrón de flujo (continuo vs. pulsátil)
  - Índices de heterogeneidad
- Características de ramificación
- Topología de red vascular

*Salida*:
- `spatiotemporal_features.csv`
- Diagramas espacio-tiempo en PNG
- Perfiles de velocidad por capilar

---

#### **Notebook 07: Microvascular Dynamics Modeling**
*Entrada*: Características espacio-temporales
*Proceso*:
- Análisis de dependencia con volumen de plasma
- Construcción de modelos predictivos:
  - Regresión lineal
  - Series temporales autocorrelacionadas
  - Análisis espectral (FFT)
- Validación con métricas clínicas

*Salida*:
- Modelos entrenados
- Coeficientes de regresión
- Bondad de ajuste (R², p-value)

---

#### **Notebook 08: Clinical Metrics and Comparison**
*Entrada*: Todas las métricas calculadas
*Proceso*:
- Cálculo de indicadores clínicos:
  - Perfusion Index (PI)
  - Microvascular Flow Index (MFI)
  - Proportion Perfused Vessels (PPV)
  - Heterogeneity Index (HI)
- Análisis de cohortes:
  - Cambios día-a-día
  - Diferencias entre grupos
  - Análisis de supervivencia

*Salida*:
- `clinical_metrics_summary.csv`
- Gráficos de comparación
- Análisis estadísticos

---

#### **Notebook 09: Results Summary**
*Entrada*: Todos los análisis previos
*Proceso*:
- Compilación de figuras publication-ready
- Tablas de resultados estadísticos
- Resumen de hallazgos principales
- Análisis de metodología y limitaciones
- Generación de reporte ejecutivo

*Salida*:
- Figuras finales para presentación
- Tablas de resultados
- Reporte de síntesis completo

---
## 📁 Estructura del Repositorio

```
microcirculation-analysis/
├── README.md                    # Este archivo (documentación)
├── requirements.txt             # Dependencias Python
├── ANALYSIS_CHECKLIST.txt       # Análisis completados
│
├── notebooks/                   # Pipeline Jupyter
│   ├── 01_data_exploration.ipynb
│   ├── 02_data_preprocessing.ipynb
│   ├── 03_annotation_and_visualization.ipynb
│   ├── 04_vessel_segmentation_training.ipynb
│   ├── 05_segmented_video_analysis.ipynb
│   ├── 06_feature_extraction_space_time.ipynb
│   ├── 07_microvascular_dynamics_modeling.ipynb
│   ├── 08_clinical_metrics_and_comparison.ipynb
│   └── 09_results_summary.ipynb
│
└── src/                         # Código reutilizable
    ├── features/                # Métricas y análisis
    │   ├── compute_metrics.py
    │   └── space_time_diagram.py
    └── data/                    # Gestión de datos
        ├── segmentation_dataset.py
        └── [archivos CSV]
```

---

## ⚙️ Requisitos e Instalación

### Paso 1: Clonar y Crear Entorno

```bash
git clone <URL>
cd microcirculation-analysis
python3 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

### Paso 2: Instalar Dependencias

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Paso 3: Verificar

```bash
python -c "import cv2, pandas, numpy; print('✓ OK')"
```

---

## 🚀 Uso

### Uso Interactivo (Recomendado)

```bash
jupyter lab
# Abrir notebooks/ secuencialmente y ejecutar celdas
```

### Uso de Módulos

```python
from src.features.compute_metrics import calculate_vessel_density
density = calculate_vessel_density(mask_frame)
```

---

## 📊 Resultados y Métricas

### Salidas del Sistema

El pipeline genera tres tipos de salidas:

**1. Datos Cuantitativos (CSV)**
- `annotations_processed.csv`: Anotaciones validadas
- `integration_results.csv`: Comparativa automático vs. manual
- `spatiotemporal_features.csv`: Características dinámicas
- `clinical_metrics_summary.csv`: Indicadores clínicos

**2. Visualizaciones (PNG)**
- Distribuciones de conteos vasculares
- Análisis de densidades (SVD/TVD)
- Comparación de métodos de segmentación
- Esqueletos vasculares
- Diagramas espacio-tiempo
- Gráficos de tendencias temporales

**3. Reportes (TXT)**
- Reporte de anotaciones
- Reporte de segmentación
- Reporte de validación
- Síntesis de hallazgos

### Métricas de Desempeño

**Validación Automático vs. Manual**
- MAE en conteos de vasos: < 5%
- Correlación Spearman SVD: r > 0.85
- Acuerdo visual-automático: κ > 0.80

**Tiempo de Procesamiento**
- Por video: ~30-60 segundos
- Por cohorte completa: ~5-10 minutos
- Comparado con manual: **100x más rápido**

---

## 🔍 Guía Rápida de Troubleshooting

| Problema | Solución |
|----------|----------|
| ImportError en notebooks | Ejecutar `pip install -r requirements.txt` |
| Videos no se procesan | Verificar formato (.mp4, .avi) y codec |
| Segmentación pobre | Ajustar parámetros CLAHE en notebook 04 |
| Falta memoria | Procesar un video por sesión |
| Archivos duplicados | Verificar nombres en CSV antes de notebook 03 |

---

## 📧 Contacto y Contribuciones

Para reportar issues, sugerencias o mejoras:
1. Verificar [issues existentes](../../issues)
2. Crear nuevo issue con descripción clara
3. Pull requests son bienvenidos

---

## 📝 Licencia

MIT License - Siéntete libre de usar, modificar y distribuir este código

---

**Última actualización**: Febrero 2025 | **Estado**: Producción
