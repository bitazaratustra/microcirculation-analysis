# Documentación Completa del Pipeline de Análisis de Microcirculación

**Proyecto de Tesis :** Análisis Automatizado de Dinámicas Microvasculares Sublinguales  
**Versión:** 1.0.0  
**Última actualización:** Febrero 2025  
**Estado:** Listo para fase de validación con datos reales

---

## 📋 Índice Ejecutivo

Este proyecto implementa un **pipeline completo de análisis de microcirculación** que:
- ✅ Procesa videos de microscopia intravital en formato estabilizado
- ✅ Segmenta automáticamente vasos sanguíneos
- ✅ Valida contra anotaciones manuales  
- ✅ Extrae características espacio-temporales
- ✅ Genera reportes para tesis

---

## 🔬 Arquitectura del Pipeline

```
ENTRADA: Video de Intravital Microscopia
    ↓
[Notebook 01] Exploración de Datos
    ↓
[Notebook 02] Pre-procesamiento y Estabilización
    ↓
[Notebook 03] Anotación y Visualización (Datos Manuales)
    ↓
[Notebook 04] Segmentación de Vasos (Automática)
    ↓
[Notebook 05] Validación: Segmentación vs. Anotaciones
    ↓
[Notebook 06] Extracción de Características Espacio-Temporales
    ↓
[Notebook 07] Modelado de Dinámicas Microvasculares
    ↓
[Notebook 08] Métricas Clínicas y Estratificación de Pacientes
    ↓
[Notebook 09] Resumen de Resultados para Tesis
    ↓
SALIDA: Reportes, Gráficos, CSV de Métricas
```

---

## 📊 Descripción de Cada Notebook

### Notebook 01: Exploración de Datos
**Objetivo:** Inspección inicial de estructura de datos  
**Entradas:** Video en formato original  
**Salidas:** Historamas, metadatos de video  

---

### Notebook 02: Pre-procesamiento y Estabilización
**Objetivo:** Preparar frames para análisis  
**Entradas:** Video bruto  
**Procesamiento:**
- Conversión a escala de grises
- Estabilización de movimiento (image registration)
- Normalización de brillo
**Salidas:** Frames estabilizados guardados como PNG

---

### **Notebook 03: Anotación y Visualización**
**Objetivo:** Cargar y validar anotaciones manuales de microcirculación  

#### Entradas:
- CSV con mediciones manuales de densidad vascular
- Conteos de vasos por categoría de flujo (0-3)
- Velocidades individuales de 20 vasos

#### Etapas:
1. **Tarea 1:** Carga de CSV
   - Importación con pandas
   - Inspección de estructura

2. **Tarea 2:** Limpieza y Reestructuración
   - Renombrado de columnas
   - Eliminación de filas vacías
   - Extracción temporal (día/video)

3. **Tarea 2B:** Validación de Calidad
   - Detección de valores faltantes
   - Validación lógica (suma categorías = total)
   - Estadísticas descriptivas

4. **Tarea 3:** Resumen del Cohorte
   - Análisis por paciente
   - Estadísticas agregadas
   - Información temporal

5. **Tarea 4:** Distribución por Categoría
   - Visualización de densidades por flujo
   - Boxplots por paciente
   - Proporciones de categorías

6. **Tarea 5:** Análisis de Densidades (SVD/TVD)
   - Correlación entre métricas
   - Distribuciones visuales
   - Estadísticas por paciente

7. **Tarea 6:** Velocidades Individuales
   - Análisis de 20 mediciones por registro
   - Detección de outliers
   - Variabilidad inter-paciente

8. **Tarea 7:** Tendencias Temporales
   - Análisis multi-día (≥3 días)
   - Gráficos de evolución
   - Respuesta a intervención

9. **Tarea 8:** Reportes y Guardado
   - CSV procesado: `annotations_processed.csv`
   - Reporte TXT: `annotations_summary_report.txt`
   - Gráficos PNG publication-ready

#### Documentación Agregada:
- ✅ Docstrings en células explicando qué/por qué/cómo
- ✅ Comentarios en línea en español (dialectoargentino)
- ✅ Notas clínicas explicando significado de cada métrica
- ✅ Validaciones y chequeos de calidad documentados
- ✅ Salidas claramente especificadas

#### Salidas:
```
src/data/
├── annotations_processed.csv (dataset limpio)
├── annotations_summary_report.txt (reporte ejecutivo)
├── 04_vessel_category_distribution.png
├── 05_vessel_density_analysis.png
├── 06_vessel_velocity_analysis.png
└── 07_temporal_trends.png
```

---

### **Notebook 04: Segmentación de Vasos** 
**Objetivo:** Implementar y comparar métodos de segmentación automática

#### Entradas:
- Frames estabilizados (notebook 02)

#### Métodos Implementados:

| Método | Técnica | Parámetros | Uso |
|--------|---------|-----------|-----|
| **Adaptativo** | Threshold local gaussiano | block=11, C=2 | Iluminación no-uniforme |
| **Otsu** | Threshold global automático | - | Rápido, simplificado |
| **CLAHE** | Realce adaptativo + Otsu | clipLimit=2.0 | Contraste mejorado |
| **Híbrido** | CLAHE + Adaptativo | block=15, C=3 | ✅ **ELEGIDO** |

#### Etapas:

1. **Tarea 1:** Carga de Frames
   - Cargar desde notebook 02
   - Demo con frames sintéticos si no disponibles
   - Validación de formato

2. **Tarea 2:** Pipeline de Segmentación
   - Explicación teórica de cada método
   - Código anotado para cada algoritmo
   - Post-procesamiento morfológico documentado

3. **Tarea 3:** Comparación Visual
   - Gráficos lado-a-lado
   - % de píxeles de vaso reportado
   - Inspección cualitativa

4. **Tarea 4:** Métricas de Calidad
   - vessel_percentage (rango óptimo 10-20%)
   - num_components (conectividad)
   - connectivity (tamaño promedio)
   - edge_pixels (regularidad)
   - Selección de mejor método

5. **Tarea 5:** Características 
   - Detección de puntos de ramificación
   - Cálculo de longitud y área de vasos

6. **Tarea 6:** Aplicación a todos los Frames
   - Procesamiento batch
   - Guardado de máscaras binarias
   - Validación de salida

#### Salidas:
```
src/data/
├── segmented/
│   ├── video_0/
│   │   ├── segmented_frame_0000.png
│   │   ├── segmented_frame_0001.png
│   │   └── ...
│   └── video_1/
│       └── ...
├── segmentation_summary_report.txt
├── 08_segmentation_methods_comparison.png
└── 09_skeleton_extraction.png
```

---

### **Notebook 05: Análisis del Video Segmentado** 
**Objetivo:** Validar segmentación automática contra anotaciones manuales

#### Etapas:

1. **Tarea 1:** Carga y Procesamiento
   - Cargar anotaciones procesadas (notebook 03)
   - Cargar frames segmentados (notebook 04)
   - Extraer métricas de segmentación por video

2. **Tarea 2:** Integración y Validación
   - Matching automático-manual
   - Cálculo de errores (MAE)
   - Ratios de componentes vs. vasos
   - Matriz de validación cruzada

#### Salidas:
```
src/data/
└── segmentation_annotation_integration.csv
    (Comparativa automático vs manual)
```

---

### **Notebook 06: Extracción de Características Espacio-Temporales**
**Objetivo:** Extraer características dinámicas de flujo vascular

#### Características Extraídas:
- **SVD temporal:** Evolución de densidad pequeños vasos
- **TVD temporal:** Evolución de densidad total
- **Velocidad promedio:** Media móvil de velocidad del flujo
- **Variabilidad:** Desv. estándar de parámetros
- **Proporciones:** Cambios en categorías de flujo
- **Diagramas espacio-tiempo:** Líneas de evolución temporal

#### Metodología:
- Análisis frame-a-frame
- Agregación temporal
- Normalización por paciente
- Extracción de transiciones

---

### **Notebook 07: Modelado de Dinámicas Microvasculares** 
**Objetivo:** Modelar cambios temporales en perfusión

#### Modelos Implementados:
- **Regresión lineal:** Cambio temporal de densidades
- **Seasonal decomposition:** Ciclos de perfusión
- **Correlación multivarariable:** Relaciones entre métricas
- **Series temporales:** Pronóstico de evolución

#### Salidas:
- Parámetros de modelo por paciente
- Predicciones de densidad futura
- Índices de estabilidad de perfusión

---

### **Notebook 08: Métricas Clínicas y Estratificación**
**Objetivo:** Comparación clínica entre pacientes

#### Indicadores Calculados:
- **Índice de perfusión microvascular:** SVD/TVD ratio
- **Severidad de hipoperfusión:** % Cat0+Cat1
- **Respuesta terapéutica:** Cambio temporal de métricas
- **Riesgo pronóstico:** Clasificación simplificada

#### Estratificación:
- Pacientes respondedores vs. no-respondedores
- Severidad inicial vs. evolución
- Correlación con desenlaces clínicos

---

### **Notebook 09: Resumen de Resultados para Tesis**
**Objetivo:** Síntesis de hallazgos

#### Contenido:
- Resumen de metodología
- Tablas de resultados clave
- Gráficos publication-ready
- Discusión de hallazgos
- Limitaciones y perspectivas futuras

---

## 📁 Estructura de Directorios

```
microcirculation-analysis/
├── README.md                          
├── requirements.txt                  
├── PIPELINE_DOCUMENTATION.md         
│
├── notebooks/
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
├── src/
│   ├── features/
│   │   ├── compute_metrics.py
│   │   └── space_time_diagram.py
│   │
│   └── data/
│       ├── segmentation_dataset.py
│       ├── [CSV files]
│       ├── Salidas/
│       │   ├── annotations_processed.csv
│       │   ├── annotations_summary_report.txt
│       │   ├── segmented/
│       │   ├── *.png (gráficos)
│       │   └── ...
│       └── [datos de entrada]
│
└── LICENSE, GITIGNORE, etc.
```

---

## ⚙️ Requisitos Instalados

**Ver:** `requirements.txt` (completamente anotado)

**Grupos principales:**
- **Computación:** numpy, pandas, scipy
- **Procesamiento:** opencv-python, scikit-image, Pillow, imageio
- **Visualización:** matplotlib, seaborn, plotly
- **ML/Stats:** scikit-learn, statsmodels
- **Jupyter:** jupyter, jupyterlab
- **Utilidades:** tqdm, tabulate, python-dotenv

---

## 🚀 Uso del Pipeline

### Instalación Rápida

```bash
# Crear env
python3 -m venv venv
source venv/bin/activate  # (o venv\Scripts\activate en Windows)

# Instalar dependencias
pip install -r requirements.txt

# Iniciar Jupyter
jupyter lab
```

### Ejecución Secuencial

```
1. Notebook 01: Ejecutar para conocer estructura de datos
2. Notebook 02: Pre-procesar y estabilizar videos
3. Notebook 03: Cargar y validar anotaciones manuales
4. Notebook 04: Entrenar/tunar métodos de segmentación
5. Notebook 05: Validar segmentación automática
6. Notebook 06: Extraer características dinámicas
7. Notebook 07: Modelar dinámicas vasculares
8. Notebook 08: Análisis clínico
9. Notebook 09: Generar resumen para tesis
```

---

## 📊 Métricas Principales

### Métricas de Segmentación:
- **SVD** (Small Vessel Density): mm/mm² de vasos < 20 μm
- **TVD** (Total Vessel Density): mm/mm² de todos los vasos
- **Flujo por categoría:** % de vasos en cada estado

### Métricas Clínicas:
- **PVD** (Perfused Vessel Density)
- **Heterogeneity index:** Variabilidad espacial de perfusión
- **Microcirculatory flow index:** Media de categorías de flujo

### Validación:
- **Sensitivity/Specificity** vs. anotaciones manuales
- **MAE** (Mean Absolute Error) de densidades
- **Correlación Spearman** automático-manual

---

## ✍️ Anotaciones Implementadas

### Documentación Agregada (Notebooks 03-05):

✅ **Notebook 03 (8 Tareas):**
- Docstrings completos explicando ¿qué? ¿por qué? ¿cómo?
- Notas clínicas en cada sección
- Comentarios en español con dialectoargentino
- Validaciones explicadas paso-a-paso
- Interpretación de resultados

✅ **Notebook 04 (6 Tareas):**
- Teoría de cada método de segmentación
- Parámetros y su significado explicado
- Comparativas lado-a-lado con análisis
- Métricas de calidad documentadas
- Selección de mejor método fundamentada

✅ **Notebook 05 (2 Tareas):**
- Carga y procesamiento documentado
- Integración automático-manual
- Estadísticas de validación
- Listos para análisis avanzado

**Pendientes:**
- 🔄 Notebooks 06-09: Anotaciones en progreso
  (Funcionalidad: 100% | Documentación: ~60%)

