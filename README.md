# Análisis Automatizado de Dinámicas Microvasculares Sublinguales

**Tesis Doctoral en Ingeniería Biomédica** | 2024-2026

---

## 📋 Tabla de Contenidos

1. [Resumen Ejecutivo](#resumen-ejecutivo)
2. [Marco Teórico](#marco-teórico)
3. [Metodología](#metodología)
4. [Estructura del Repositorio](#estructura-del-repositorio)
5. [Instalación y Requisitos](#instalación-y-requisitos)
6. [Pipeline de Análisis](#pipeline-de-análisis)
7. [Descripción de Notebooks](#descripción-de-notebooks)
8. [Uso del Sistema](#uso-del-sistema)
9. [Validación y Resultados](#validación-y-resultados)
10. [Limitaciones](#limitaciones)

---

## 📊 Resumen Ejecutivo

Este trabajo propone un sistema para el análisis cuantitativo de dinámicas microvasculares sublinguales mediante procesamiento automatizado de videos de microscopia intravital.

### Hipótesis

[TODO: AGREGAR HIPÓTESIS PRINCIPAL DEL TRABAJO]

### Objetivos

**Objetivo General:**  
[TODO: AGREGAR OBJETIVO GENERAL]

**Objetivos Específicos:**
- [TODO: OBJETIVO ESPECÍFICO 1]
- [TODO: OBJETIVO ESPECÍFICO 2]
- [TODO: OBJETIVO ESPECÍFICO 3]

---

## 🔬 Marco Teórico

### Microcirculación Sublingual como Indicador Clínico

La microcirculación sublingual ha sido propuesta en la literatura como un indicador accesible del estado de perfusión tisular sistémica. Su análisis mediante intravital microscopia permite la evaluación no-invasiva de:

- [TODO: INDICADORES ESPECÍFICOS ESTUDIADOS]
- [TODO: PARÁMETROS CLÍNICOS DE INTERÉS]
- [TODO: RELEVANCIA CLÍNICA EN LA POBLACIÓN DE ESTUDIO]

### Antecedentes de Análisis Manual

El análisis cuantitativo manual de videos de microcirculación sublingual presenta limitaciones bien documentadas:

- [TODO: ESPECIFICAR LIMITACIONES IDENTIFICADAS]
- [TODO: FUENTES BIBLIOGRÁFICAS]
- [TODO: BRECHA IDENTIFICADA QUE JUSTIFICA LA AUTOMATIZACIÓN]

### Fundamentos de Procesamiento de Imágenes

Los métodos de segmentación y análisis de imágenes aplicados en este trabajo incluyen:

#### Preprocesamiento
- [TODO: TÉCNICAS DE ESTABILIZACIÓN UTILIZADAS]
- [TODO: JUSTIFICACIÓN DE MÉTODOS ELEGIDOS]

#### Segmentación
El objetivo de la segmentación es extraer automáticamente las estructuras vasculares de las imágenes de microscopia. Se evaluaron los siguientes métodos:

- **Threshold Adaptativo**: [TODO: DESCRIPCIÓN, PARÁMETROS, JUSTIFICACIÓN]
- **Threshold Global (Otsu)**: [TODO: DESCRIPCIÓN, PARÁMETROS, JUSTIFICACIÓN]
- **CLAHE**: [TODO: DESCRIPCIÓN, PARÁMETROS, JUSTIFICACIÓN]
- **Método Híbrido**: [TODO: DESCRIPCIÓN, PARÁMETROS, JUSTIFICACIÓN]

#### Análisis de características
[TODO: DESCRIBIR CARACTERÍSTICAS EXTRAÍDAS Y SUS LIMITACIONES]

---

## 🧪 Metodología

### Población de Estudio

[TODO: CRITERIOS DE INCLUSIÓN/EXCLUSIÓN]
[TODO: NÚMERO DE SUJETOS]
[TODO: CARACTERÍSTICAS DEMOGRÁFICAS]
[TODO: APROBACIÓN ÉTICA]

### Protocolo de Adquisición de Datos

[TODO: EQUIPO UTILIZADO]
[TODO: PARÁMETROS DE CAPTURA]
[TODO: RESOLUCIÓN ESPACIAL Y TEMPORAL]
[TODO: NÚMERO DE VIDEOS POR SUJETO]
[TODO: PROCEDIMIENTO DE MEDICIÓN]

### Anotación Manual de Referencia

[TODO: CRITERIOS DE CLASIFICACIÓN]
[TODO: NÚMERO DE OBSERVADORES]
[TODO: PROTOCOLO DE VALIDACIÓN INTER-OBSERVADOR]
[TODO: ENTRENAMIENTO DE ANOTADORES]

### Implementación de Algoritmos

[TODO: BIBLIOTECAS Y LENGUAJES UTILIZADOS]
[TODO: JUSTIFICACIÓN DE DECISIONES TÉCNICAS]
[TODO: PARÁMETROS DE ALGORITMOS]

### Análisis Estadístico

[TODO: MÉTODOS DE VALIDACIÓN]
[TODO: CRITERIOS PARA EVALUACIÓN DE DESEMPEÑO]
[TODO: ANÁLISIS DE CONCORDANCIA]

---

## 📁 Estructura del Repositorio

```
microcirculation-analysis/
├── README.md                    # Este archivo
├── requirements.txt             # Dependencias Python
├── Makefile                     # Automatización de tareas
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
│   │   └── [datos procesados]
│   └── features/
│       ├── compute_metrics.py
│       └── space_time_diagram.py
│
└── output/                      # Resultados generados
    ├── figures/
    ├── data/
    └── reports/
```

---

## ⚙️ Instalación y Requisitos

### Requisitos del Sistema

- Python 3.9 o superior
- [TODO: ESPECIFICAR OTROS REQUISITOS]

### Instalación

**Paso 1: Clonar y crear entorno virtual**
```bash
git clone <repositorio>
cd microcirculation-analysis
python3 -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

**Paso 2: Instalar dependencias**
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

**Paso 3: Verificar instalación**
```bash
python -c "import cv2, pandas, numpy; print('✓ Librerías instaladas correctamente')"
```

---

## 🏗️ Pipeline de Análisis

### Flujo General

```
ENTRADA (Videos de microscopia)
    ↓
[01] Exploración y caracterización de datos
    ↓
[02] Preprocesamiento (estabilización, normalización)
    ↓
[03] Anotaciones manuales y visualización
    ↓
[04] Desarrollo y comparación de métodos de segmentación
    ↓
[05] Validación de segmentación automática
    ↓
[06] Extracción de características espacio-temporales
    ↓
[07] Modelado de dinámicas microvasculares
    ↓
[08] Cálculo de métricas clínicas y análisis de grupos
    ↓
[09] Síntesis de resultados
    ↓
SALIDA (Tablas, figuras, reportes)
```

---

## 📓 Descripción de Notebooks

### Notebook 01: Data Exploration
**Propósito**: Caracterizar la estructura y calidad de datos crudos

**Entrada**: Videos de microscopia intravital

**Proceso**:
- Inspección de estructura de archivos
- Verificación de integridad
- [TODO: DESCRIBIR PASOS ESPECÍFICOS DE EXPLORACIÓN]

**Salida**: Reporte de características de datos

---

### Notebook 02: Data Preprocessing
**Propósito**: Preparar videos para análisis posterior

**Entrada**: Videos crudos

**Proceso**:
- [TODO: DESCRIBIR TÉCNICAS DE ESTABILIZACIÓN]
- [TODO: DESCRIBIR NORMALIZACIÓN APLICADA]
- [TODO: DESCRIBIR RECORTE DE ROI]

**Salida**: Frames preprocesados

---

### Notebook 03: Annotation and Visualization
**Propósito**: Integrar anotaciones manuales y generar análisis exploratorio

**Entrada**: Archivo CSV con anotaciones manual

**Proceso**:
- Carga y validación de datos
- [TODO: DESCRIBIR CLASIFICACIONES REALIZADAS]
- [TODO: DESCRIBIR CÁLCULOS DE MÉTRICAS]
- Visualizaciones de exploración

**Salida**:
- `annotations_processed.csv`
- `annotations_summary_report.txt`
- Figuras de análisis exploratorio

---

### Notebook 04: Vessel Segmentation Training
**Propósito**: Desarrollar y evaluar métodos de segmentación automática

**Entrada**: Frames preprocesados + anotaciones

**Proceso**:
- Evaluación comparativa de métodos
- [TODO: DESCRIBIR CRITERIOS DE EVALUACIÓN]
- Extracción de características topológicas

**Salida**:
- Máscaras de segmentación
- Esqueletos vasculares
- Métricas de calidad por método
- Figuras comparativas

---

### Notebook 05: Segmented Video Analysis
**Propósito**: Validar segmentación automática contra anotaciones manuales

**Entrada**: Segmentaciones automáticas + anotaciones manuales

**Proceso**:
- Cálculo de métricas automáticas
- [TODO: DESCRIBIR MÉTODOS DE VALIDACIÓN]
- Análisis de discrepancias

**Salida**:
- `integration_results.csv`
- Matriz de validación
- [TODO: DESCRIBIR ANÁLISIS DE ERRORES]

---

### Notebook 06: Feature Extraction (Space-Time)
**Propósito**: Extraer características dinámicas de videos segmentados

**Entrada**: Videos segmentados

**Proceso**:
- [TODO: DESCRIBIR CARACTERÍSTICAS EXTRAÍDAS]
- [TODO: DESCRIBIR ANÁLISIS DE SERIES TEMPORALES]
- [TODO: DESCRIBIR TOPOLOGÍA DE RED]

**Salida**:
- `spatiotemporal_features.csv`
- Diagramas y visualizaciones

---

### Notebook 07: Microvascular Dynamics Modeling
**Propósito**: Construir modelos de dinámicas microvasculares

**Entrada**: Características espacio-temporales

**Proceso**:
- [TODO: DESCRIBIR TÉCNICAS DE MODELADO]
- [TODO: DESCRIBIR VALIDACIÓN DE MODELOS]

**Salida**:
- Coeficientes de modelos
- Métricas de bondad de ajuste

---

### Notebook 08: Clinical Metrics and Comparison
**Propósito**: Calcular indicadores clínicos y comparar grupos

**Entrada**: Todas las métricas calculadas

**Proceso**:
- [TODO: DESCRIBIR INDICADORES CLÍNICOS DERIVADOS]
- [TODO: DESCRIBIR ANÁLISIS DE GRUPOS]
- [TODO: DESCRIBIR ANÁLISIS ESTADÍSTICO]

**Salida**:
- `clinical_metrics.csv`
- Gráficos de comparación
- Tablas estadísticas

---

### Notebook 09: Results Summary
**Propósito**: Sintetizar resultados para presentación

**Entrada**: Todos los análisis previos

**Proceso**:
- Compilación de figuras
- Generación de tablas sumarias
- Síntesis de hallazgos

**Salida**:
- Figuras finales
- Tablas de resultados
- Reporte de síntesis

---

## 🚀 Uso del Sistema

### Ejecución Interactiva (Recomendado)

```bash
jupyter lab
# Abrir y ejecutar notebooks secuencialmente
```

### Ejecución de Notebooks Específicos

```bash
# Ejecutar un notebook específico
jupyter nbconvert --to notebook --execute 01_data_exploration.ipynb
```

### Uso Automatizado

```bash
make help              # Ver todas las tareas disponibles
make setup             # Configuración inicial
make run-all           # Ejecutar pipeline completo
```

---

## 📊 Validación y Resultados

### Métricas de Desempeño

[TODO: AGREGAR MÉTRICAS OBTENIDAS DE LA VALIDACIÓN]
- [TODO: MÉTRICA 1 - DESCRIPCIÓN Y VALOR]
- [TODO: MÉTRICA 2 - DESCRIPCIÓN Y VALOR]
- [TODO: MÉTRICA 3 - DESCRIPCIÓN Y VALOR]

### Validación de Segmentación

[TODO: DESCRIBIR EVALUACIÓN DE SEGMENTACIÓN]
- [TODO: MÉTODO DE EVALUACIÓN 1]
- [TODO: RESULTADOS]
- [TODO: COMPARACIÓN CON LITERATURA]

### Análisis de Dinámicas

[TODO: DESCRIBIR HALLAZGOS DEL ANÁLISIS DINÁMICO]

### Indicadores Clínicos

[TODO: DESCRIBIR INDICADORES CALCULADOS Y HALLAZGOS]

---

## ⚠️ Limitaciones

### Limitaciones Técnicas

- [TODO: LIMITACIONES DE MÉTODOS DE PROCESAMIENTO]
- [TODO: LIMITACIONES DEL EQUIPO UTILIZADO]
- [TODO: LIMITACIONES DE RESOLUCIÓN ESPACIAL/TEMPORAL]

### Limitaciones Metodológicas

- [TODO: LIMITACIONES DE POBLACIÓN DE ESTUDIO]
- [TODO: LIMITACIONES DE PROTOCOLO]
- [TODO: LIMITACIONES DE VALIDACIÓN]

### Alcance del Trabajo

- [TODO: DESCRIBIR QUÉ NO SE CUBRE EN ESTE TRABAJO]

---

## 📚 Referencias Bibliográficas

[TODO: AGREGAR REFERENCIAS CITADAS EN EL TRABAJO]

---

## 🤝 Agradecimientos

[TODO: AGREGAR AGRADECIMIENTOS SEGÚN CORRESPONDA]

---

**Última actualización**: Febrero 2026  
**Estado**: [TODO: ESPECIFICAR ESTADO DEL TRABAJO - Protocolo/En ejecución/Terminado]
