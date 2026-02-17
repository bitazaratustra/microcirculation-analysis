# Análisis Automatizado de Dinámicas Microvasculares Sublinguales


---

## 🎯 Objetivo

Desarrollar un sistema automatizado para el análisis cuantitativo de dinámicas microvasculares sublinguales a partir de videos de microscopia intravital.

---

## 📋 Tabla de Contenidos

1. [Estructura del Repositorio](#estructura-del-repositorio)
2. [Instalación](#instalación)
3. [Pipeline de Análisis](#pipeline-de-análisis)
4. [Uso](#uso)

---

## 📁 Estructura del Repositorio

```
microcirculation-analysis/
├── README.md                    # Este archivo
├── requirements.txt             # Dependencias Python
├── Makefile                     # Automatización
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
├── src/                         # Código de análisis
│   ├── data/
│   │   ├── segmentation_dataset.py
│   │   └── Grilla trauma SL - Lattanzio (1) - Sheet1.csv
│   └── features/
│       ├── compute_metrics.py
│       └── space_time_diagram.py
```

---

## ⚙️ Instalación

```bash
# Crear entorno virtual
python3 -m venv venv
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt
```

---

## 🚀 Pipeline de Análisis

El análisis se estructura en 9 notebooks secuenciales:

1. **Exploración de datos**: Caracterización de videos crudos
2. **Preprocesamiento**: Estabilización y normalización de frames
3. **Anotaciones**: Carga y visualización de datos manual
4. **Segmentación**: Desarrollo de métodos de segmentación automática
5. **Validación**: Comparación automático vs. manual
6. **Características**: Extracción de rasgos espacio-temporales
7. **Modelado**: Construcción de modelos de dinámicas
8. **Métricas clínicas**: Análisis de indicadores clínicos
9. **Síntesis**: Compilación de resultados

---

## 📖 Uso

**Ejecución interactiva:**
```bash
jupyter lab
# Abrir y ejecutar notebooks en orden
```

**Uso de Makefile:**
```bash
make help              # Ver tareas disponibles
make setup             # Configuración inicial
make jupyter           # Iniciar Jupyter Lab
```

---

**Última actualización**: Febrero 2026
