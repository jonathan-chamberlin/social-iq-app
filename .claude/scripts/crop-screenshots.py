"""Crop simulator screenshots to App Store sizes (1242x2688).

Usage: python3 .claude/scripts/crop-screenshots.py <folder>

Scales from iPhone 17 Pro (1206x2622) to 1242 wide, then symmetrically
crops 6px top + 6px bottom to hit 1242x2688.
"""

import sys
import os
from PIL import Image

TARGET = (1242, 2688)

folder = sys.argv[1] if len(sys.argv) > 1 else "."

for f in sorted(os.listdir(folder)):
    if not f.endswith(".png"):
        continue
    path = os.path.join(folder, f)
    img = Image.open(path)

    scale_w, scale_h = TARGET[0], int(img.height * TARGET[0] / img.width)
    scaled = img.resize((scale_w, scale_h), Image.LANCZOS)

    crop_y = (scale_h - TARGET[1]) // 2
    cropped = scaled.crop((0, crop_y, TARGET[0], crop_y + TARGET[1]))

    cropped.save(path)
    print(f"{f}: {img.size} -> {cropped.size}")
