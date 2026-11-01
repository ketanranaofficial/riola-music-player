import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from PIL import Image, ImageDraw
from design import shapes, flatten, O

STOPS = [(0.00, (0x0B, 0x8F, 0xD6)), (0.28, (0x00, 0xC4, 0xE8)), (0.52, (0x03, 0xF0, 0xD2)),
         (0.78, (0x3D, 0xF2, 0x9A)), (1.00, (0x9A, 0xFA, 0x78))]

def gradient(w, h, start, end, stops=STOPS):
    ys, xs = np.mgrid[0:h, 0:w].astype(float)
    d = np.array(end, float) - np.array(start, float)
    t = np.clip(((xs - start[0]) * d[0] + (ys - start[1]) * d[1]) / (d @ d), 0, 1)
    out = np.zeros((h, w, 3))
    offs = [s[0] for s in stops]
    for ch in range(3):
        out[:, :, ch] = np.interp(t, offs, [s[1][ch] for s in stops])
    return out

def mask_of(polys, size, scale, offset, ss=4):
    img = Image.new('L', (size * ss, size * ss), 0)
    dr = ImageDraw.Draw(img)
    for p in polys:
        q = (np.asarray(p) - np.asarray(offset)) * scale * ss
        dr.polygon([tuple(v) for v in q], fill=255)
    return np.asarray(img.resize((size, size), Image.LANCZOS)).astype(float) / 255

def radial(w, h, centre, radius, rgb, alpha0):
    ys, xs = np.mgrid[0:h, 0:w].astype(float)
    t = np.clip(np.hypot(xs - centre[0], ys - centre[1]) / radius, 0, 1)
    return (1 - t) * alpha0, np.array(rgb, float)

def background(size, pad=0):
    """deep navy with a blue glow on the left and a green glow bottom-right, like the reference tile"""
    img = np.zeros((size, size, 3)); img[:] = (0x00, 0x13, 0x1D)
    for centre, radius, rgb, a in (((0.0, 0.62), 0.85, (0x00, 0x3B, 0x63), 0.9),
                                   ((1.0, 1.0), 0.80, (0x01, 0x6A, 0x58), 0.95),
                                   ((0.1, 0.05), 0.65, (0x02, 0x2E, 0x3A), 0.8)):
        al, col = radial(size, size, (centre[0] * size, centre[1] * size), radius * size, rgb, a)
        img = img * (1 - al[..., None]) + col * al[..., None]
    return img

def mark_layer(size, scale, centre, note_shift=None):
    """-> (rgb gradient image, coverage mask) of the whole mark; centre = where the ring centre lands"""
    sh, _ = shapes() if note_shift is None else shapes(note_shift)
    polys = [flatten(v) for v in sh.values()]
    off = O - np.array(centre) / scale
    cov = mask_of(polys, size, scale, off)
    # gradient runs bottom-left -> top-right between the mark's own extremes along that diagonal
    allp = np.vstack(polys); d = np.array([1.0, -1.0]) / np.sqrt(2); pr = allp @ d
    s = (d * pr.min() - off) * scale; e = (d * pr.max() - off) * scale
    return gradient(size, size, s, e), cov

def compose(size, scale, centre, note_shift=None, bg=None):
    rgb, cov = mark_layer(size, scale, centre, note_shift)
    base = background(size) if bg is None else bg
    return np.clip(base * (1 - cov[..., None]) + rgb * cov[..., None], 0, 255).astype(np.uint8)

if __name__ == '__main__':
    size = 1254
    mine = compose(size, 1.0, tuple(O))
    ref = np.asarray(Image.open('/home/ketan/Downloads/file_00000000388882118aa290f3ef878a78.png').convert('RGB'))
    side = np.hstack([ref[::2, ::2], mine[::2, ::2]])
    Image.fromarray(side).save('preview_side.png')
    Image.fromarray(mine).resize((900, 900), Image.LANCZOS).save('preview_mark.png')
    print('ok')
