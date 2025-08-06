import numpy as np
from scipy.signal import find_peaks

def extract_metrics(space_time_img, px_per_um=1.0, fps=10):
    velocity_list = []
    density_list = []

    # Detectar trazas (líneas diagonales)
    for i in range(space_time_img.shape[0]):
        line = space_time_img[i, :]
        peaks, _ = find_peaks(line, height=100)
        if len(peaks) > 1:
            diffs = np.diff(peaks)
            if np.all(diffs > 0):
                velocity = px_per_um * np.mean(diffs) * fps
                velocity_list.append(velocity)

    density = np.count_nonzero(space_time_img > 100, axis=0) / space_time_img.shape[0]
    supply_rate = len(velocity_list) / (space_time_img.shape[1] / fps)

    return {
        "velocity": float(np.mean(velocity_list)),
        "density": float(np.mean(density)),
        "supply_rate": float(supply_rate)
    }
