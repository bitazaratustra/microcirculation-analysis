import numpy as np
import cv2
from pathlib import Path
from tqdm import tqdm

def build_space_time_image(frame_dir, segmenter=None):
    """Asume frames ordenados frame_0000.png, frame_0001.png, etc."""
    frame_files = sorted(Path(frame_dir).glob("frame_*.png"))
    space_time_column = []

    for f in tqdm(frame_files):
        img = cv2.imread(str(f), cv2.IMREAD_GRAYSCALE)
        if segmenter:
            # Aplicar segmentador
            input_tensor = torch.tensor(img / 255.0, dtype=torch.float32).unsqueeze(0).unsqueeze(0)
            with torch.no_grad():
                output = segmenter(input_tensor)[0, 0].numpy()
            img = (output > 0.5).astype(np.uint8) * 255

        centerline = img[:, img.shape[1] // 2]
        space_time_column.append(centerline)

    return np.stack(space_time_column, axis=1)  # (altura, tiempo)
