# Microcirculation Analysis using Deep Learning

## 🎯 Descripción

Este proyecto de tesis de maestría en Data Science tiene como objetivo desarrollar un modelo automatizado para la evaluación de la microcirculación sublingual en pacientes críticamente enfermos, utilizando técnicas de visión por computadora y aprendizaje profundo.

Se busca reemplazar o mejorar herramientas existentes (como AVA 3.2), mediante un pipeline reproducible que incluye segmentación vascular, análisis espacio-temporal y modelado de variables fisiológicas como velocidad de eritrocitos, densidad capilar y tasa de suministro.

---

## 📁 Estructura del Proyecto

microcirculation-analysis/
├── data/ # Datos (no versionados por git)
├── notebooks/ # Notebooks Jupyter por etapas
├── src/ # Código fuente (segmentación, métricas, modelos)
├── scripts/ # Entrenamiento desde línea de comandos
├── tests/ # Tests unitarios
├── configs/ # Configuraciones YAML
├── requirements.txt # Dependencias
├── README.md # Este archivo
├── .gitignore # Exclusiones de git


---

## 🧪 Instalación

1. Crear y activar un entorno virtual con `pyenv` o `venv`
2. Instalar dependencias:

```bash
pip install -r requirements.txt
🚀 Ejecución rápida
bash
Copy
Edit
# Entrenar modelo de segmentación
python scripts/train_segmenter.py

# Aplicar segmentador a videos
python scripts/evaluate.py

# Extraer métricas fisiológicas
python scripts/extract_metrics.py