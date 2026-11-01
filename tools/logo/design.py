"""The Riola mark: a music note inside a broken ring of two crescents.

Everything is in the reference image's pixel space (1254 square), centred on the ring.
The crescents are exact: one outer circle, and an inner circle chosen so the crescent is
T thick at its middle and its tips sit half_span either side of it.
"""
import json, math, os
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))

O = np.array([628.8, 633.3])       # ring centre (fitted to the reference)
R = 335.5                           # outer radius
T = 46.0                            # thickness at the middle of a crescent
HALF = math.radians(76)             # tips this far either side of the middle
MIDS = (-130.0, 50.0)               # middle directions: up-left, and its exact opposite

def arc(c, r, a0, a1):
    """cubic Beziers for a circular arc, in pieces of at most 90 degrees"""
    n = max(1, int(math.ceil(abs(a1 - a0) / (math.pi / 2) - 1e-9)))
    out = []
    for i in range(n):
        s = a0 + (a1 - a0) * i / n; e = a0 + (a1 - a0) * (i + 1) / n
        k = 4 / 3 * math.tan((e - s) / 4)
        p0 = c + r * np.array([math.cos(s), math.sin(s)]); p3 = c + r * np.array([math.cos(e), math.sin(e)])
        p1 = p0 + k * r * np.array([-math.sin(s), math.cos(s)]); p2 = p3 - k * r * np.array([-math.sin(e), math.cos(e)])
        out.append(np.array([p0, p1, p2, p3]))
    return out

def crescent(mid_deg):
    psi = math.pi - HALF
    e = (2 * R * T - T * T) / (2 * R * (1 + math.cos(psi)) - 2 * T)      # how far the inner circle is pushed off-centre
    ri = R + e - T                                                         # and its radius
    th = math.radians(mid_deg)
    m = np.array([math.cos(th), math.sin(th)])
    ci = O - e * m
    tip = lambda ang: O + R * np.array([math.cos(ang), math.sin(ang)])
    t1, t2 = tip(th - HALF), tip(th + HALF)
    outer = arc(O, R, th - HALF, th + HALF)                               # tip 1 -> tip 2 through the middle
    wrap = lambda a: (a + math.pi) % (2 * math.pi) - math.pi
    a2 = wrap(math.atan2(*(t2 - ci)[::-1]) - th); a1 = wrap(math.atan2(*(t1 - ci)[::-1]) - th)
    inner = arc(ci, ri, th + a2, th + a1)                                  # tip 2 -> tip 1 along the inner edge
    return outer + inner, dict(e=e, ri=ri)

def note():
    """the traced note, with the stem made truly vertical and its top-left cap rebuilt"""
    c = [np.array(x) for x in json.load(open(os.path.join(HERE, 'note_beziers.json')))]
    SX = 672.0                                                   # right edge of the stem
    LX = 629.5                                                   # left edge of the stem
    c[2] = np.array([c[2][0], c[2][1], c[2][2], [SX, 538.0]])    # flag's inner edge meets the stem
    c[3] = np.array([[SX, 538.0], [SX, 553.4], [SX, 570.3], [SX, 586.0]])
    c[4] = np.array([[SX, 586.0], [SX, 625.8], [SX, 690.0], [SX, 735.0]])
    c[5] = np.array([[SX, 735.0], [SX, 770.0], [657.0, 808.0], [643.7, 821.4]])   # stem flows into the head
    line = np.array([[LX, 489.9], [LX, 477.0], [LX, 464.0], [LX, 452.0]])
    cap = np.array([[LX, 452.0], [LX, 430.0], [649.8, 410.2], [663.6, 412.3]])      # the rounded top of the stem
    c[11] = np.array([c[11][0], c[11][1], c[11][2], [LX, c[11][3][1]]])
    c[12] = np.array([[LX, c[12][0][1]], [LX, c[12][1][1]], [LX, c[12][2][1]], [LX, 489.9]])
    c[10] = np.array([c[10][0], c[10][1], c[10][2], [LX, 665.0]])
    c[11] = np.array([[LX, 665.0], [LX, 645.0], [LX, 625.0], [LX, 607.9]])
    return c[:13] + [line, cap] + c[15:]

def shapes(note_shift=(-14.0, -10.0)):
    A, info = crescent(MIDS[0]); B, _ = crescent(MIDS[1])
    N = [c + np.array(note_shift) for c in note()]
    return {'ringA': A, 'ringB': B, 'note': N}, info

def flatten(curves, n=48):
    pts = []
    for c in curves:
        t = np.linspace(0, 1, n, endpoint=False)[:, None]
        pts.append((1 - t) ** 3 * c[0] + 3 * (1 - t) ** 2 * t * c[1] + 3 * (1 - t) * t ** 2 * c[2] + t ** 3 * c[3])
    return np.vstack(pts)

if __name__ == '__main__':
    sh, info = shapes()
    print('inner circle: pushed %.1f px off-centre, radius %.1f' % (info['e'], info['ri']))
    for k, v in sh.items(): print(k, len(v), 'segments')
