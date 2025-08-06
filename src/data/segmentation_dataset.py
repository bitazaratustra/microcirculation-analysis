import torch
from torch.utils.data import Dataset
import os
from PIL import Image
import numpy as np
import albumentations as A
from albumentations.pytorch import ToTensorV2

class SegmentationDataset(Dataset):
    def __init__(self, img_dir, mask_dir, transform=None):
        self.img_dir = img_dir
        self.mask_dir = mask_dir
        self.transform = transform or A.Compose([
            A.Resize(256, 256),
            A.Normalize(mean=0.0, std=1.0),
            ToTensorV2()
        ])
        self.images = []
        for subdir, _, files in os.walk(img_dir):
            for file in files:
                if file.endswith(".png"):
                    img_path = os.path.join(subdir, file)
                    mask_path = img_path.replace("processed", "annotations").replace(".png", "_mask.png")
                    if os.path.exists(mask_path):
                        self.images.append((img_path, mask_path))

    def __len__(self):
        return len(self.images)

    def __getitem__(self, idx):
        img_path, mask_path = self.images[idx]
        image = np.array(Image.open(img_path).convert("L"))
        mask = np.array(Image.open(mask_path).convert("L")) > 0

        augmented = self.transform(image=image, mask=mask.astype(np.float32))
        return augmented['image'].unsqueeze(0), augmented['mask'].unsqueeze(0)
