"""Writes the Android vector drawables and the store/readme PNGs for the mark.

usage: export_android.py <repo dir> [--preview sheet.png]
"""
import os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from PIL import Image, ImageDraw
from design import shapes, flatten, O
from render import STOPS, compose, background

repo = sys.argv[1]
res = os.path.join(repo, 'app', 'res', 'drawable')
docs = os.path.join(repo, 'docs')
sh, _ = shapes()
RING_D = 2 * 335.5            # outer diameter of the ring, in design units

def num(v):
    s = ('%.2f' % v).rstrip('0').rstrip('.')
    return '0' if s in ('-0', '') else s

def path_data(curves, f):
    p = [f(c) for c in curves]
    d = 'M%s,%s' % (num(p[0][0][0]), num(p[0][0][1]))
    for c in p:
        d += 'C%s,%s %s,%s %s,%s' % tuple(num(v) for v in (c[1][0], c[1][1], c[2][0], c[2][1], c[3][0], c[3][1]))
    return d + 'Z'

def mapper(diameter, centre):
    s = diameter / RING_D
    return s, (lambda c: (c - O) * s + np.array(centre, float))

def gradient_xml(f, indent):
    allp = np.vstack([flatten(v) for v in sh.values()]); d = np.array([1.0, -1.0]) / np.sqrt(2); pr = allp @ d
    s = f(np.array([O + d * (pr.min() - O @ d)])).reshape(2); e = f(np.array([O + d * (pr.max() - O @ d)])).reshape(2)
    pad = ' ' * indent
    out = '%s<aapt:attr name="android:fillColor">\n%s    <gradient android:type="linear" android:startX="%s" android:startY="%s" android:endX="%s" android:endY="%s">\n' % (
        pad, pad, num(s[0]), num(s[1]), num(e[0]), num(e[1]))
    for off, (r, g, b) in STOPS:
        out += '%s        <item android:offset="%s" android:color="#FF%02X%02X%02X" />\n' % (pad, num(off), r, g, b)
    return out + '%s    </gradient>\n%s</aapt:attr>\n' % (pad, pad)

def vector(size_dp, viewport, body):
    return ('<?xml version="1.0" encoding="utf-8"?>\n'
            '<vector xmlns:android="http://schemas.android.com/apk/res/android"\n'
            '    xmlns:aapt="http://schemas.android.com/aapt"\n'
            '    android:width="%sdp" android:height="%sdp"\n'
            '    android:viewportWidth="%s" android:viewportHeight="%s">\n%s</vector>\n') % (size_dp, size_dp, viewport, viewport, body)

def gradient_mark(diameter, centre, viewport, size_dp):
    s, f = mapper(diameter, centre)
    body = ''
    for name in ('ringA', 'ringB', 'note'):
        body += '    <path android:pathData="%s">\n%s    </path>\n' % (path_data(sh[name], f), gradient_xml(f, 8))
    return vector(size_dp, viewport, body)

def flat_mark(diameter, centre, viewport, size_dp, colour, tint=False):
    s, f = mapper(diameter, centre)
    body = ''.join('    <path android:fillColor="%s" android:pathData="%s" />\n' % (colour, path_data(sh[n], f)) for n in ('ringA', 'ringB', 'note'))
    x = vector(size_dp, viewport, body)
    return x.replace('android:viewportHeight="%s">' % viewport, 'android:viewportHeight="%s"\n    android:tint="%s">' % (viewport, colour)) if tint else x

def background_xml():
    def glow(cx, cy, r, rgb, a):
        return ('    <path android:pathData="M0,0h108v108h-108z">\n'
                '        <aapt:attr name="android:fillColor">\n'
                '            <gradient android:type="radial" android:centerX="%s" android:centerY="%s" android:gradientRadius="%s">\n'
                '                <item android:offset="0" android:color="#%02X%s" />\n'
                '                <item android:offset="1" android:color="#00%s" />\n'
                '            </gradient>\n        </aapt:attr>\n    </path>\n') % (num(cx), num(cy), num(r), int(round(a * 255)), rgb, rgb)
    body = '    <path android:fillColor="#FF00131D" android:pathData="M0,0h108v108h-108z" />\n'
    body += glow(0, 0.62 * 108, 0.85 * 108, '003B63', 0.9)
    body += glow(108, 108, 0.80 * 108, '016A58', 0.95)
    body += glow(0.1 * 108, 0.05 * 108, 0.65 * 108, '022E3A', 0.8)
    return vector(108, 108, body)

FG_D = 60.0
files = {
    'ic_launcher_fg.xml': gradient_mark(FG_D, (54, 54), 108, 108),
    'ic_launcher_bg.xml': background_xml(),
    'ic_launcher_mono.xml': flat_mark(FG_D, (54, 54), 108, 108, '#FFFFFFFF'),
    'ic_note.xml': flat_mark(22.0, (12, 12), 24, 24, '#FFFFFFFF', tint=True),
}
def java_source():
    s, f = mapper(94.0, (50, 50))
    allp = np.vstack([flatten(v) for v in sh.values()]); d = np.array([1.0, -1.0]) / np.sqrt(2); pr = allp @ d
    g0 = f(np.array([O + d * (pr.min() - O @ d)])).reshape(2); g1 = f(np.array([O + d * (pr.max() - O @ d)])).reshape(2)
    def arr(name, curves):
        p = [f(c) for c in curves]
        nums = [p[0][0][0], p[0][0][1]]
        for c in p: nums += [c[1][0], c[1][1], c[2][0], c[2][1], c[3][0], c[3][1]]
        body = ', '.join(num(v) + 'f' for v in nums)
        return '    static final float[] %s = { %s };\n' % (name, body)
    return ('package com.riola.player;\n\n'
            'import android.graphics.Path;\n\n'
            '/**\n * The Riola mark as cubic Beziers in a 100 x 100 box, and the line its gradient runs along.\n'
            ' * Generated by tools/logo/export_android.py: change the design there, not here.\n */\n'
            'final class LogoPaths {\n    private LogoPaths() { }\n\n'
            + arr('RING_A', sh['ringA']) + arr('RING_B', sh['ringB']) + arr('NOTE', sh['note'])
            + '    static final float GX0 = %sf, GY0 = %sf, GX1 = %sf, GY1 = %sf;\n\n' % (num(g0[0]), num(g0[1]), num(g1[0]), num(g1[1]))
            + '    /** a closed path from {x0, y0, then c1x, c1y, c2x, c2y, x, y for each curve} */\n'
            '    static Path path(float[] d) {\n'
            '        Path p = new Path();\n'
            '        p.moveTo(d[0], d[1]);\n'
            '        for (int i = 2; i + 5 < d.length; i += 6) p.cubicTo(d[i], d[i + 1], d[i + 2], d[i + 3], d[i + 4], d[i + 5]);\n'
            '        p.close();\n'
            '        return p;\n'
            '    }\n}\n')

os.makedirs(res, exist_ok=True)
for name, xml in files.items():
    open(os.path.join(res, name), 'w').write(xml)
    print('wrote %-22s %5d bytes' % (name, len(xml)))

# ---- PNGs: store icon, readme logo, and a legibility sheet -------------------
def icon_image(px):
    """the full-bleed launcher icon at px pixels: the background with the mark in the middle"""
    return compose(px, (FG_D / RING_D) * px / 108.0, (px / 2, px / 2), bg=background(px))

os.makedirs(docs, exist_ok=True)
store = icon_image(512)
Image.fromarray(store).save(os.path.join(docs, 'icon-512.png'))
logo = Image.fromarray(store).convert('RGBA')
m = Image.new('L', (512 * 4, 512 * 4), 0); ImageDraw.Draw(m).rounded_rectangle([0, 0, 512 * 4 - 1, 512 * 4 - 1], radius=int(512 * 4 * 0.225), fill=255)
logo.putalpha(m.resize((512, 512), Image.LANCZOS)); logo.save(os.path.join(docs, 'logo.png'))
print('wrote docs/icon-512.png, docs/logo.png')
java_dir = os.path.join(repo, 'app', 'src', 'com', 'riola', 'player')
open(os.path.join(java_dir, 'LogoPaths.java'), 'w').write(java_source())
print('wrote LogoPaths.java')

# how it looks under the usual launcher masks, at real sizes
def masked(px, shape):
    im = Image.fromarray(icon_image(px)).convert('RGBA')
    vis = px * 72 / 108                                   # the launcher shows the middle 72 of 108
    c = px / 2; box = [c - vis / 2, c - vis / 2, c + vis / 2, c + vis / 2]
    mm = Image.new('L', (px * 4, px * 4), 0); d = ImageDraw.Draw(mm); b4 = [v * 4 for v in box]
    if shape == 'circle': d.ellipse(b4, fill=255)
    else: d.rounded_rectangle(b4, radius=int(vis * 4 * (0.30 if shape == 'squircle' else 0.18)), fill=255)
    im.putalpha(mm.resize((px, px), Image.LANCZOS)); return im.crop([int(v) for v in box])
sheet = Image.new('RGBA', (3 * 300 + 40, 300 + 2 * 120), (40, 44, 52, 255))
x = 20
for shape in ('circle', 'squircle', 'rounded'):
    big = masked(432, shape).resize((280, 280), Image.LANCZOS); sheet.alpha_composite(big, (x, 10))
    for i, px in enumerate((96, 48, 32)):
        small = masked(px * 108 // 72 + 1, shape).resize((px, px), Image.LANCZOS)
        sheet.alpha_composite(small, (x + [0, 110, 180][i], 310 + (96 - px) // 2))
    x += 300
if '--preview' in sys.argv:
    sheet.convert('RGB').save(sys.argv[sys.argv.index('--preview') + 1])
    print('preview sheet written')
