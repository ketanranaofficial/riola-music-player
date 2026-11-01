"""Traces the music note out of the reference artwork into a short chain of cubic Beziers (sharp corners kept).

usage: trace_note.py <reference.png>   (the flat one-colour version works best); writes note_beziers.json next to it
"""
import json, os, sys
import numpy as np
from PIL import Image

REF = sys.argv[1]
G = np.asarray(Image.open(REF).convert('RGB')).astype(float)[:, :, 1]
X0, X1, Y0, Y1 = 425, 885, 395, 890                 # a window around the note
F = G[Y0:Y1, X0:X1]
LEVEL = 135.0

# ---- marching squares ------------------------------------------------------
def march(F, level):
    H, W = F.shape
    b = F > level
    pts = {}        # edge key -> (x, y) of the crossing
    def cross(key, p, q, fp, fq):
        t = (level - fp) / (fq - fp)
        pts[key] = (p[0] + t * (q[0] - p[0]), p[1] + t * (q[1] - p[1]))
    segs = []
    for y in range(H - 1):
        for x in range(W - 1):
            tl, tr, br, bl = b[y, x], b[y, x + 1], b[y + 1, x + 1], b[y + 1, x]
            case = tl * 8 + tr * 4 + br * 2 + bl * 1
            if case in (0, 15): continue
            top, right, bottom, left = ('h', y, x), ('v', y, x + 1), ('h', y + 1, x), ('v', y, x)
            if top not in pts and tl != tr: cross(top, (x, y), (x + 1, y), F[y, x], F[y, x + 1])
            if bottom not in pts and bl != br: cross(bottom, (x, y + 1), (x + 1, y + 1), F[y + 1, x], F[y + 1, x + 1])
            if left not in pts and tl != bl: cross(left, (x, y), (x, y + 1), F[y, x], F[y + 1, x])
            if right not in pts and tr != br: cross(right, (x + 1, y), (x + 1, y + 1), F[y, x + 1], F[y + 1, x + 1])
            table = {1: [(left, bottom)], 2: [(bottom, right)], 3: [(left, right)], 4: [(top, right)],
                     5: [(top, left), (bottom, right)], 6: [(top, bottom)], 7: [(top, left)], 8: [(top, left)],
                     9: [(top, bottom)], 10: [(top, right), (left, bottom)], 11: [(top, right)], 12: [(left, right)],
                     13: [(bottom, right)], 14: [(left, bottom)]}
            segs += table[case]
    adj = {}
    for a, c in segs:
        adj.setdefault(a, []).append(c); adj.setdefault(c, []).append(a)
    seen, loops = set(), []
    for start in adj:
        if start in seen: continue
        loop, prev, cur = [start], None, start
        seen.add(start)
        while True:
            nxt = [n for n in adj[cur] if n != prev and n not in seen]
            if not nxt: break
            prev, cur = cur, nxt[0]; seen.add(cur); loop.append(cur)
        loops.append(np.array([pts[k] for k in loop]))
    return loops

loops = march(F, LEVEL)
loop = max(loops, key=len)
loop = loop + np.array([X0, Y0])
print('contour points', len(loop))

# ---- resample uniformly (closed) ------------------------------------------
def resample(P, step=1.0):
    Q = np.vstack([P, P[:1]])
    d = np.r_[0, np.cumsum(np.linalg.norm(np.diff(Q, axis=0), axis=1))]
    n = int(d[-1] / step)
    s = np.linspace(0, d[-1], n, endpoint=False)
    return np.c_[np.interp(s, d, Q[:, 0]), np.interp(s, d, Q[:, 1])]

def smooth_closed(P, sigma):
    r = int(4 * sigma) + 1
    k = np.exp(-0.5 * (np.arange(-r, r + 1) / sigma) ** 2); k /= k.sum()
    return np.c_[[np.convolve(np.r_[P[-r:, i], P[:, i], P[:r, i]], k, mode='valid') for i in range(2)]].T

P = smooth_closed(resample(loop), 1.5)
N = len(P)

# ---- corners: where the heading changes sharply over a short span -----------
K = 9
def heading(a, b): return np.arctan2(b[1] - a[1], b[0] - a[0])
turn = np.zeros(N)
for i in range(N):
    h1 = heading(P[i - K], P[i]); h2 = heading(P[i], P[(i + K) % N])
    d = (h2 - h1 + np.pi) % (2 * np.pi) - np.pi
    turn[i] = abs(d)
corners = []
for i in range(N):
    win = [turn[(i + j) % N] for j in range(-K, K + 1)]
    if turn[i] > np.radians(32) and turn[i] == max(win):
        if not corners or (i - corners[-1]) > 2 * K: corners.append(i)
print('corners at', [(int(P[i][0]), int(P[i][1])) for i in corners], [round(float(np.degrees(turn[i]))) for i in corners])

# ---- split at corners, smooth each piece with its ends pinned, fit Beziers --
def piece(i, j):
    return P[i:j + 1] if j > i else np.vstack([P[i:], P[:j + 1]])

def smooth_open(Pc, sigma):
    r = int(3 * sigma) + 1
    k = np.exp(-0.5 * (np.arange(-r, r + 1) / sigma) ** 2); k /= k.sum()
    pad_l = 2 * Pc[0] - Pc[1:r + 1][::-1]; pad_r = 2 * Pc[-1] - Pc[-r - 1:-1][::-1]
    Q = np.vstack([pad_l, Pc, pad_r])
    out = np.c_[[np.convolve(Q[:, i], k, mode='valid') for i in range(2)]].T
    out[0], out[-1] = Pc[0], Pc[-1]
    return out

def unit(v): return v / (np.linalg.norm(v) + 1e-12)
def bez(c, t):
    t = np.asarray(t)[:, None]
    return (1 - t) ** 3 * c[0] + 3 * (1 - t) ** 2 * t * c[1] + 3 * (1 - t) * t ** 2 * c[2] + t ** 3 * c[3]
def d1(c, t):
    t = np.asarray(t)[:, None]
    return 3 * (1 - t) ** 2 * (c[1] - c[0]) + 6 * (1 - t) * t * (c[2] - c[1]) + 3 * t ** 2 * (c[3] - c[2])
def d2(c, t):
    t = np.asarray(t)[:, None]
    return 6 * (1 - t) * (c[2] - 2 * c[1] + c[0]) + 6 * t * (c[3] - 2 * c[2] + c[1])
def chord(Pc):
    d = np.r_[0, np.cumsum(np.linalg.norm(np.diff(Pc, axis=0), axis=1))]; return d / d[-1]
def gen(Pc, u, lt, rt):
    p0, p3 = Pc[0], Pc[-1]
    b0 = (1 - u) ** 3; b1 = 3 * u * (1 - u) ** 2; b2 = 3 * u ** 2 * (1 - u); b3 = u ** 3
    A1 = lt[None, :] * b1[:, None]; A2 = rt[None, :] * b2[:, None]
    C = np.array([[(A1 * A1).sum(), (A1 * A2).sum()], [(A1 * A2).sum(), (A2 * A2).sum()]])
    tmp = Pc - (p0[None, :] * (b0 + b1)[:, None] + p3[None, :] * (b2 + b3)[:, None])
    X = np.array([(A1 * tmp).sum(), (A2 * tmp).sum()])
    det = C[0, 0] * C[1, 1] - C[0, 1] * C[1, 0]
    seg = np.linalg.norm(p3 - p0)
    if abs(det) > 1e-9:
        al = (X[0] * C[1, 1] - X[1] * C[0, 1]) / det; ar = (C[0, 0] * X[1] - C[1, 0] * X[0]) / det
    else: al = ar = 0
    if al < 1e-6 * seg or ar < 1e-6 * seg: al = ar = seg / 3
    return np.array([p0, p0 + lt * al, p3 + rt * ar, p3])
def fit(Pc, lt, rt, err):
    if len(Pc) == 2:
        d = np.linalg.norm(Pc[1] - Pc[0]) / 3
        return [np.array([Pc[0], Pc[0] + lt * d, Pc[1] + rt * d, Pc[1]])]
    u = chord(Pc); c = gen(Pc, u, lt, rt)
    e = np.linalg.norm(bez(c, u) - Pc, axis=1); m = e.max(); sp = int(np.clip(e.argmax(), 1, len(Pc) - 2))
    if m < err: return [c]
    if m < err * 6:
        for _ in range(25):
            dd = bez(c, u) - Pc; a = d1(c, u); b = d2(c, u)
            den = (a * a).sum(1) + (dd * b).sum(1)
            u = np.clip(np.where(np.abs(den) > 1e-12, u - (dd * a).sum(1) / den, u), 0, 1)
            u[0], u[-1] = 0, 1
            c = gen(Pc, u, lt, rt)
            e = np.linalg.norm(bez(c, u) - Pc, axis=1); m = e.max(); sp = int(np.clip(e.argmax(), 1, len(Pc) - 2))
            if m < err: return [c]
    ct = unit(Pc[sp - 1] - Pc[sp + 1])
    return fit(Pc[:sp + 1], lt, ct, err) + fit(Pc[sp:], -ct, rt, err)

TOL = 0.9
curves = []
for a, bidx in zip(corners, corners[1:] + corners[:1]):
    Pc = smooth_open(piece(a, bidx), 3.0)
    lt = unit(Pc[min(6, len(Pc) - 1)] - Pc[0]); rt = unit(Pc[-7 if len(Pc) > 7 else 0] - Pc[-1])
    curves += fit(Pc, lt, rt, TOL)
print('bezier segments', len(curves))
json.dump([c.tolist() for c in curves], open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'note_beziers.json'), 'w'))

# how far is the fitted outline from the real edge?
dense = np.vstack([bez(c, np.linspace(0, 1, 60)) for c in curves])
dist = np.sqrt(((P[:, None, :] - dense[None, ::3, :]) ** 2).sum(2)).min(1)
print('fit error vs the reference edge: mean %.2f px, max %.2f px' % (dist.mean(), dist.max()))
