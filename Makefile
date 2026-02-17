# Makefile para Pipeline de Análisis Automatizado de Dinámicas Microvasculares
# Proyecto de Tesis Doctoral
# ============================================================================
# Este Makefile automatiza tareas comunes del proyecto:
# - Instalación de dependencias
# - Configuración de ambiente virtual
# - Ejecución de Jupyter notebooks
# - Limpieza de archivos generados
# - Generación de reportes
#
# Uso: make [target]
# Ejemplo: make install
#          make run-notebook-03
#          make clean
# ============================================================================

.PHONY: help install venv setup clean run-all run-notebook-03 run-notebook-04 \
        run-notebook-05 run-notebook-06 run-notebook-07 run-notebook-08 \
        run-notebook-09 jupyter check-deps docs

# Variables
PYTHON := python3
PIP := pip
VENV := venv
JUPYTER := jupyter
NOTEBOOKS_DIR := notebooks
DATA_DIR := src/data
REQUIREMENTS := requirements.txt

# Colores para output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
NC := \033[0m # No Color

# ============================================================================
# AYUDA Y INFORMACIÓN
# ============================================================================

help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Pipeline de Análisis de Microcirculación - Makefile           ║$(NC)"
	@echo "$(BLUE)║  Proyecto de Tesis Doctoral - Dinámicas Microvasculares       ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)OBJETIVOS DISPONIBLES:$(NC)"
	@echo ""
	@echo "  $(YELLOW)Instalación y Configuración:$(NC)"
	@echo "    make setup              → Configuración inicial completa (venv + dependencias)"
	@echo "    make venv               → Crear ambiente virtual Python"
	@echo "    make install            → Instalar dependencias en ambiente actual"
	@echo "    make check-deps         → Verificar dependencias instaladas"
	@echo ""
	@echo "  $(YELLOW)Ejecución de Notebooks:$(NC)"
	@echo "    make jupyter            → Iniciar Jupyter Lab"
	@echo "    make run-notebook-03    → Ejecutar: Anotación y Visualización"
	@echo "    make run-notebook-04    → Ejecutar: Segmentación de Vasos"
	@echo "    make run-notebook-05    → Ejecutar: Análisis Video Segmentado"
	@echo "    make run-notebook-06    → Ejecutar: Extracción Espacio-Temporal"
	@echo "    make run-notebook-07    → Ejecutar: Modelado de Dinámicas"
	@echo "    make run-notebook-08    → Ejecutar: Métricas Clínicas"
	@echo "    make run-notebook-09    → Ejecutar: Resumen para Tesis"
	@echo "    make run-all            → Ejecutar TODOS los notebooks (03-09)"
	@echo ""
	@echo "  $(YELLOW)Mantenimiento:$(NC)"
	@echo "    make clean              → Limpiar archivos generados (__pycache__, .ipynb_checkpoints)"
	@echo "    make clean-all          → Limpiar TODO incluyendo src/data/segmented"
	@echo "    make docs               → Mostrar documentación disponible"
	@echo ""
	@echo "  $(YELLOW)Información:$(NC)"
	@echo "    make help               → Mostrar esta ayuda"
	@echo ""
	@echo "$(GREEN)EJEMPLOS DE USO:$(NC)"
	@echo "    $$ make setup"
	@echo "    $$ make run-notebook-03"
	@echo "    $$ make jupyter"
	@echo "    $$ make clean"
	@echo ""

# ============================================================================
# CONFIGURACIÓN INICIAL
# ============================================================================

setup: venv install
	@echo ""
	@echo "$(GREEN)✓ Configuración inicial completada$(NC)"
	@echo ""
	@echo "$(BLUE)Próximos pasos:$(NC)"
	@echo "  1. Activar ambiente virtual:"
	@echo "     source $(VENV)/bin/activate"
	@echo ""
	@echo "  2. Iniciar Jupyter:"
	@echo "     make jupyter"
	@echo ""
	@echo "  3. Ejecutar primer notebook:"
	@echo "     make run-notebook-03"
	@echo ""

venv:
	@echo "$(BLUE)→ Creando ambiente virtual Python...$(NC)"
	@if [ ! -d "$(VENV)" ]; then \
		$(PYTHON) -m venv $(VENV); \
		echo "$(GREEN)✓ Ambiente virtual creado en: $(VENV)$(NC)"; \
	else \
		echo "$(YELLOW)⚠ Ambiente virtual ya existe en: $(VENV)$(NC)"; \
	fi

install:
	@echo "$(BLUE)→ Instalando dependencias...$(NC)"
	$(PIP) install --upgrade pip setuptools wheel
	$(PIP) install -r $(REQUIREMENTS)
	@echo "$(GREEN)✓ Dependencias instaladas$(NC)"

check-deps:
	@echo "$(BLUE)→ Verificando dependencias instaladas...$(NC)"
	@echo ""
	@$(PYTHON) -c "\
		import sys; \
		deps = ['pandas', 'numpy', 'cv2', 'matplotlib', 'seaborn', 'scipy', 'scikit-image', 'scikit-learn']; \
		missing = []; \
		for dep in deps: \
			try: __import__(dep); print('$(GREEN)✓$(NC) ' + dep); \
			except: missing.append(dep); print('$(RED)✗$(NC) ' + dep); \
		if missing: sys.exit(1)" || true
	@echo ""
	@echo "$(GREEN)Verificación completada$(NC)"

# ============================================================================
# JUPYTER Y NOTEBOOKS
# ============================================================================

jupyter:
	@echo "$(BLUE)→ Iniciando Jupyter Lab...$(NC)"
	@echo "$(YELLOW)Abre tu navegador en: http://localhost:8888$(NC)"
	@echo ""
	$(JUPYTER) lab

# Ejecutar notebooks individuales
run-notebook-03:
	@echo "$(BLUE)→ Ejecutando Notebook 03: Anotación y Visualización$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/03_annotation_and_visualization.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 03 completado$(NC)"

run-notebook-04:
	@echo "$(BLUE)→ Ejecutando Notebook 04: Segmentación de Vasos$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/04_vessel_segmentation_training.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 04 completado$(NC)"

run-notebook-05:
	@echo "$(BLUE)→ Ejecutando Notebook 05: Análisis Video Segmentado$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/05_segmented_video_analysis.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 05 completado$(NC)"

run-notebook-06:
	@echo "$(BLUE)→ Ejecutando Notebook 06: Extracción Espacio-Temporal$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/06_feature_extraction_space_time.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 06 completado$(NC)"

run-notebook-07:
	@echo "$(BLUE)→ Ejecutando Notebook 07: Modelado de Dinámicas$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/07_microvascular_dynamics_modeling.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 07 completado$(NC)"

run-notebook-08:
	@echo "$(BLUE)→ Ejecutando Notebook 08: Métricas Clínicas$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/08_clinical_metrics_and_comparison.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 08 completado$(NC)"

run-notebook-09:
	@echo "$(BLUE)→ Ejecutando Notebook 09: Resumen para Tesis$(NC)"
	$(JUPYTER) nbconvert --to notebook --execute $(NOTEBOOKS_DIR)/09_results_summary_for_thesis.ipynb --output-dir=$(NOTEBOOKS_DIR)
	@echo "$(GREEN)✓ Notebook 09 completado$(NC)"

run-all: run-notebook-03 run-notebook-04 run-notebook-05 run-notebook-06 \
         run-notebook-07 run-notebook-08 run-notebook-09
	@echo ""
	@echo "$(GREEN)╔════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(GREEN)║  ✓ Todos los notebooks ejecutados exitosamente                ║$(NC)"
	@echo "$(GREEN)╚════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(BLUE)Salidas generadas en: $(DATA_DIR)/$(NC)"

# ============================================================================
# LIMPIEZA
# ============================================================================

clean:
	@echo "$(BLUE)→ Limpiando archivos temporales...$(NC)"
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ipynb_checkpoints" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	find . -type f -name ".DS_Store" -delete
	@echo "$(GREEN)✓ Archivos temporales eliminados$(NC)"

clean-all: clean
	@echo "$(BLUE)→ Limpiando TODOS los archivos generados...$(NC)"
	@echo "$(YELLOW)Esto incluye: src/data/segmented/, gráficos, reportes$(NC)"
	@echo ""
	@read -p "¿Estás seguro? [s/N] " -n 1 -r; \
	echo ""; \
	if [[ $$REPLY =~ ^[Ss]$$ ]]; then \
		rm -rf $(DATA_DIR)/segmented $(DATA_DIR)/*.png $(DATA_DIR)/*.csv $(DATA_DIR)/*.txt 2>/dev/null || true; \
		echo "$(GREEN)✓ Archivos generados eliminados$(NC)"; \
	else \
		echo "$(YELLOW)Operación cancelada$(NC)"; \
	fi

# ============================================================================
# DOCUMENTACIÓN
# ============================================================================

docs:
	@echo "$(GREEN)╔════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(GREEN)║  Documentación del Proyecto                                    ║$(NC)"
	@echo "$(GREEN)╚════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(BLUE)Archivos principales:$(NC)"
	@echo "  • README.md                    - Descripción general (español)"
	@echo "  • PIPELINE_DOCUMENTATION.md    - Documentación completa del pipeline"
	@echo "  • requirements.txt             - Dependencias (anotadas)"
	@echo ""
	@echo "$(BLUE)Notebooks del pipeline:$(NC)"
	@echo "  01. data_exploration.ipynb           - Exploración inicial"
	@echo "  02. data_preprocessing.ipynb         - Pre-procesamiento y estabilización"
	@echo "  03. annotation_and_visualization     - Anotaciones manuales (✓ ANOTADO)"
	@echo "  04. vessel_segmentation_training     - Segmentación automática (✓ ANOTADO)"
	@echo "  05. segmented_video_analysis         - Validación (✓ ANOTADO)"
	@echo "  06. feature_extraction_space_time    - Características dinámicas"
	@echo "  07. microvascular_dynamics_modeling  - Modelado temporal"
	@echo "  08. clinical_metrics_and_comparison  - Análisis clínico"
	@echo "  09. results_summary_for_thesis       - Síntesis de resultados"
	@echo ""
	@echo "$(BLUE)Para más información:$(NC)"
	@echo "  $$ less README.md"
	@echo "  $$ less PIPELINE_DOCUMENTATION.md"
	@echo ""

# ============================================================================
# TARGETS POR DEFECTO
# ============================================================================

.DEFAULT_GOAL := help

# ============================================================================
# INFORMACIÓN DE PROYECTO
# ============================================================================

.PHONY: info
info:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  Información del Proyecto                                      ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(GREEN)Proyecto:$(NC) Análisis Automatizado de Dinámicas Microvasculares"
	@echo "$(GREEN)Tipo:$(NC)      Tesis Doctoral - Ingeniería Biomédica"
	@echo "$(GREEN)Lenguaje:$(NC)  Python 3.9+"
	@echo "$(GREEN)Framework:$(NC) Jupyter Notebooks"
	@echo ""
	@echo "$(GREEN)Etapas del Pipeline:$(NC)"
	@echo "  01. Exploración de datos"
	@echo "  02. Pre-procesamiento y estabilización"
	@echo "  03. Anotación manual y validación"
	@echo "  04. Segmentación automática de vasos"
	@echo "  05. Validación cruzada (automático vs. manual)"
	@echo "  06. Extracción de características espacio-temporales"
	@echo "  07. Modelado de dinámicas microvasculares"
	@echo "  08. Análisis clínico y estratificación"
	@echo "  09. Resumen ejecutivo para tesis"
	@echo ""
	@echo "$(GREEN)Archivos generados:$(NC)"
	@echo "  • CSV: datasets procesados y resultados"
	@echo "  • PNG: gráficos publication-ready"
	@echo "  • TXT: reportes de análisis"
	@echo "  • Máscaras binarias de segmentación"
	@echo ""

# ============================================================================
# NOTARGET (mostrar ayuda si no se especifica target)
# ============================================================================

.PHONY: .notarget
.notarget:
	@make help
