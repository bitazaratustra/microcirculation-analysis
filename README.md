# Análisis Automatizado de Dinámicas Microvasculares Sublinguales

**Proyecto de Tesis Doctoral** | Ingeniería Biomédica | 2024-2025

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
- **Reproducibilidad**: Resultados auditables y documentados para tesis doctoral

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
│   └── 09_results_summary_for_thesis.ipynb
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

## ⚙️ Instalación Rápida

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

## 📊 Salidas del Sistema

- **CSV**: Métricas cuantitativas por paciente
- **PNG**: Figuras publication-ready
- **TXT**: Reporte final resumido

---

## 📝 Licencia

MIT License - Citar proyecto en tesis

---

**Última actualización**: Febrero 2025 | **Estado**: Desarrollo para Tesis Doctoral
