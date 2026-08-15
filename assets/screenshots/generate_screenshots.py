"""Generates 4 Play Store screenshot mockups (1080x1920) matching the
real app's design system. Pure PIL drawing, hand-drawn vector icons
(no emoji font available on this machine, so emoji are avoided).
Run: python generate_screenshots.py
"""
from PIL import Image, ImageDraw, ImageFont

W, H = 1080, 1920
GREEN = (29, 111, 66)
GREEN_DARK = (15, 81, 50)
ACCENT = (255, 193, 7)
WHITE = (255, 255, 255)
BG = (246, 248, 246)
GREY = (136, 136, 136)
DARK = (34, 34, 34)

FONT_DIR = "C:\\Windows\\Fonts\\"


def F(name, size):
    try:
        return ImageFont.truetype(FONT_DIR + name, size)
    except Exception:
        return ImageFont.load_default()


REG, BOLD, MONO = "segoeui.ttf", "segoeuib.ttf", "consola.ttf"


def text(draw, xy, s, fnt, fill, anchor=None):
    draw.text(xy, s, font=fnt, fill=fill, anchor=anchor)


def rrect(draw, box, radius, **kw):
    draw.rounded_rectangle(box, radius=radius, **kw)


def gradient_bg(w, h, c1, c2):
    im = Image.new("RGB", (w, h), c1)
    d = ImageDraw.Draw(im)
    for i in range(h):
        t = i / h
        r = int(c1[0] + (c2[0] - c1[0]) * t)
        g = int(c1[1] + (c2[1] - c1[1]) * t)
        b = int(c1[2] + (c2[2] - c1[2]) * t)
        d.line([(0, i), (w, i)], fill=(r, g, b))
    return im


def draw_icon(draw, cx, cy, kind, color, s=1.0):
    """Simple vector icons (no emoji font available on this machine)."""
    if kind == "flame":
        pts = [(cx, cy - 30 * s), (cx + 16 * s, cy - 6 * s), (cx + 10 * s, cy + 24 * s),
               (cx, cy + 30 * s), (cx - 10 * s, cy + 24 * s), (cx - 16 * s, cy - 6 * s)]
        draw.polygon(pts, fill=color)
        draw.ellipse([cx - 7 * s, cy, cx + 7 * s, cy + 16 * s], fill=(255, 235, 205))
    elif kind == "bulb":
        r = 14 * s
        draw.ellipse([cx - r, cy - r - 4 * s, cx + r, cy + r - 4 * s], fill=color)
        draw.rectangle([cx - 6 * s, cy + r - 8 * s, cx + 6 * s, cy + r + 2 * s], fill=color)
    elif kind == "book":
        w, h = 26 * s, 22 * s
        draw.rounded_rectangle([cx - w, cy - h, cx + w, cy + h], radius=4 * s, fill=color)
        draw.line([(cx, cy - h + 4 * s), (cx, cy + h - 4 * s)], fill=WHITE, width=int(3 * s))
    elif kind == "check":
        draw.line([(cx - 16 * s, cy), (cx - 4 * s, cy + 14 * s), (cx + 18 * s, cy - 14 * s)],
                   fill=color, width=int(6 * s), joint="curve")
    elif kind == "grid":
        w = 26 * s
        draw.rounded_rectangle([cx - w, cy - w, cx + w, cy + w], radius=4 * s, outline=color, width=int(4 * s))
        draw.line([(cx - w, cy), (cx + w, cy)], fill=color, width=int(3 * s))
        draw.line([(cx, cy - w), (cx, cy + w)], fill=color, width=int(3 * s))
    elif kind == "wand":
        draw.line([(cx - 16 * s, cy + 16 * s), (cx + 16 * s, cy - 16 * s)], fill=color, width=int(5 * s))
        for dx, dy in [(-16, 16), (10, -22), (20, -6)]:
            draw.line([(cx + dx * s - 5 * s, cy + dy * s), (cx + dx * s + 5 * s, cy + dy * s)], fill=color, width=int(3 * s))
            draw.line([(cx + dx * s, cy + dy * s - 5 * s), (cx + dx * s, cy + dy * s + 5 * s)], fill=color, width=int(3 * s))
    elif kind == "gear":
        r = 13 * s
        draw.ellipse([cx - r, cy - r, cx + r, cy + r], outline=WHITE, width=int(3 * s))
        draw.ellipse([cx - 4 * s, cy - 4 * s, cx + 4 * s, cy + 4 * s], fill=WHITE)
    elif kind == "chart":
        bw = 10 * s
        heights = [16 * s, 26 * s, 20 * s]
        x = cx - 22 * s
        for h in heights:
            draw.rectangle([x, cy + 18 * s - h, x + bw, cy + 18 * s], fill=color)
            x += bw + 6 * s
    elif kind == "sparkle":
        for ang, ln in [(0, 16), (90, 16), (180, 16), (270, 16)]:
            import math
            rad = math.radians(ang)
            x2, y2 = cx + ln * s * math.cos(rad), cy + ln * s * math.sin(rad)
            draw.line([(cx, cy), (x2, y2)], fill=color, width=int(3 * s))
    elif kind == "trash":
        w, h = 14 * s, 18 * s
        draw.rectangle([cx - w, cy - h, cx + w, cy + h], outline=color, width=int(3 * s))
        draw.line([(cx - w - 4 * s, cy - h), (cx + w + 4 * s, cy - h)], fill=color, width=int(3 * s))


def app_bar(draw, title, icon_kind=None):
    draw.rectangle([0, 0, W, 150], fill=GREEN)
    text(draw, (W / 2, 75), title, F(BOLD, 40), WHITE, anchor="mm")
    if icon_kind:
        draw_icon(draw, W - 60, 75, icon_kind, WHITE, 1.0)


# ---------------------------------------------------------------
def make_home():
    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)
    app_bar(draw, "Excel Guru", "gear")

    wx0, wy0, wx1, wy1 = 40, 190, W - 40, 470
    grad = gradient_bg(wx1 - wx0, wy1 - wy0, GREEN, GREEN_DARK)
    mask = Image.new("L", (wx1 - wx0, wy1 - wy0), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, wx1 - wx0, wy1 - wy0], radius=28, fill=255)
    img.paste(grad, (wx0, wy0), mask)
    draw = ImageDraw.Draw(img)

    text(draw, (wx0 + 36, wy0 + 40), "Namaste!", F(BOLD, 44), WHITE)
    rrect(draw, [wx1 - 250, wy0 + 40, wx1 - 36, wy0 + 90], 24, fill=(60, 140, 100))
    text(draw, (wx1 - 143, wy0 + 65), "Intermediate", F(BOLD, 22), WHITE, anchor="mm")
    text(draw, (wx0 + 36, wy0 + 118), "Excel seekhein, practice karein, expert banein.", F(REG, 26), (230, 240, 234))

    bar_y = wy0 + 175
    rrect(draw, [wx0 + 36, bar_y, wx1 - 36, bar_y + 18], 9, fill=(70, 130, 100))
    rrect(draw, [wx0 + 36, bar_y, wx0 + 36 + int((wx1 - wx0 - 72) * 0.35), bar_y + 18], 9, fill=ACCENT)
    text(draw, (wx0 + 36, bar_y + 34), "4 / 11 lessons complete", F(REG, 22), (220, 232, 224))

    ry0 = wy1 + 26
    sx0, sx1 = 40, 330
    rrect(draw, [sx0, ry0, sx1, ry0 + 190], 22, fill=(255, 224, 178))
    draw_icon(draw, sx0 + 46, ry0 + 55, "flame", (255, 110, 40), 1.1)
    text(draw, (sx0 + 24, ry0 + 95), "5 din", F(BOLD, 32), DARK)
    text(draw, (sx0 + 24, ry0 + 140), "Streak", F(REG, 22), GREY)

    fx0, fx1 = 350, W - 40
    rrect(draw, [fx0, ry0, fx1, ry0 + 190], 22, fill=(224, 236, 229))
    draw_icon(draw, fx0 + 30, ry0 + 34, "bulb", (255, 180, 40), 0.9)
    text(draw, (fx0 + 54, ry0 + 22), "FORMULA OF THE DAY", F(BOLD, 20), (90, 105, 97))
    text(draw, (fx0 + 24, ry0 + 62), "=TRIM(A1)", F(MONO, 30), GREEN_DARK)
    text(draw, (fx0 + 24, ry0 + 112), "Extra spaces hata deta hai\u2014", F(REG, 20), (80, 90, 84))
    text(draw, (fx0 + 24, ry0 + 142), "messy data clean karne ke liye.", F(REG, 20), (80, 90, 84))

    sy = ry0 + 230
    text(draw, (40, sy), "Seekhna shuru karein", F(BOLD, 32), DARK)

    tiles = [
        ("grid", (0, 150, 136), "50 Levels \u2014 Step-by-Step Path", "12 / 50 levels complete"),
        ("book", GREEN, "Lessons", "11 topics \u2014 basics se advanced tak"),
        ("check", (255, 87, 34), "Quiz", "9 quiz sets \u2014 apna score check karein"),
        ("chart", (33, 150, 243), "Practice Simulator", "Live spreadsheet me formulas try karein"),
        ("wand", (63, 81, 181), "Formula Builder", "Function choose karein, formula ban jaayega"),
    ]
    ty = sy + 50
    for icon_kind, color, title_t, sub_t in tiles:
        rrect(draw, [40, ty, W - 40, ty + 140], 20, fill=WHITE)
        draw.ellipse([70, ty + 34, 140, ty + 104], fill=tuple(int(c * 0.18 + 255 * 0.82) for c in color))
        draw_icon(draw, 105, ty + 69, icon_kind, color, 0.85)
        text(draw, (168, ty + 42), title_t, F(BOLD, 27), DARK)
        text(draw, (168, ty + 84), sub_t, F(REG, 21), GREY)
        ty += 160

    img.save("screenshot_1_home.png")
    print("Saved screenshot_1_home.png")


# ---------------------------------------------------------------
def make_lesson():
    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)
    app_bar(draw, "Excel Basics")

    hx0, hy0, hx1, hy1 = 40, 190, W - 40, 340
    grad = gradient_bg(hx1 - hx0, hy1 - hy0, GREEN, GREEN_DARK)
    mask = Image.new("L", (hx1 - hx0, hy1 - hy0), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, hx1 - hx0, hy1 - hy0], radius=24, fill=255)
    img.paste(grad, (hx0, hy0), mask)
    draw = ImageDraw.Draw(img)
    draw.ellipse([hx0 + 24, hy0 + 24, hx0 + 96, hy0 + 96], fill=(60, 140, 100))
    draw_icon(draw, hx0 + 60, hy0 + 60, "chart", WHITE, 1.0)
    text(draw, (hx0 + 120, hy0 + 40), "Excel Basics", F(BOLD, 32), WHITE)
    text(draw, (hx0 + 120, hy0 + 85), "Cell, Row, Column aur Sheet samjhein", F(REG, 22), (225, 238, 230))

    def section(y, num, heading, body_lines, formula=None, fun=None):
        card_h = 100 + 34 * len(body_lines) + 20
        if formula:
            card_h += 95
        if fun:
            card_h += 34 * len(fun) + 40
        rrect(draw, [40, y, W - 40, y + card_h], 22, fill=WHITE)
        draw.ellipse([76, y + 32, 124, y + 80], fill=(210, 228, 217))
        text(draw, (100, y + 56), str(num), F(BOLD, 24), GREEN_DARK, anchor="mm")
        text(draw, (144, y + 40), heading, F(BOLD, 30), DARK)
        yy = y + 100
        for line in body_lines:
            text(draw, (76, yy), line, F(REG, 24), (50, 50, 50))
            yy += 34
        if formula:
            rrect(draw, [76, yy + 10, W - 76, yy + 90], 14, fill=(224, 236, 229))
            text(draw, (100, yy + 34), formula, F(MONO, 26), GREEN_DARK)
            yy += 105
        if fun:
            box_h = 34 * len(fun) + 26
            rrect(draw, [76, yy + 10, W - 76, yy + 10 + box_h], 14, fill=(255, 236, 199))
            draw_icon(draw, 100, yy + 10 + box_h / 2, "bulb", (230, 160, 20), 0.7)
            fy = yy + 24
            for line in fun:
                text(draw, (140, fy), line, F(REG, 20), (60, 55, 40))
                fy += 30
        return y + card_h + 24

    y = 366
    y = section(
        y, 2, "Cell Reference",
        ["Har cell ka apna address hota hai \u2014 Column letter + Row", "number. Jaise pehla column A, pehli row 1."],
        formula="A1, B2, C10",
        fun=["Socho Excel ek city hai \u2014 Column letters \"streets\"", "hain aur Row numbers \"house numbers\"!"],
    )
    y = section(
        y, 3, "Sheet aur Workbook",
        ["Ek Workbook (file) me multiple Sheets ho sakti hain.", "Har sheet apna alag data rakh sakti hai."],
    )

    img.save("screenshot_2_lesson.png")
    print("Saved screenshot_2_lesson.png")


# ---------------------------------------------------------------
def make_quiz():
    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)
    app_bar(draw, "Logical Functions Quiz")

    bx0, bx1 = 44, W - 44
    rrect(draw, [bx0, 200, bx1, 216], 8, fill=(220, 220, 220))
    rrect(draw, [bx0, 200, bx0 + int((bx1 - bx0) * 0.4), 216], 8, fill=GREEN)
    text(draw, (bx0, 236), "Question 2 / 5", F(REG, 24), GREY)

    text(draw, (bx0, 300), "=IF(A1>50,\"Pass\",\"Fail\") \u2014", F(BOLD, 34), DARK)
    text(draw, (bx0, 350), "agar A1 = 40 hai to result?", F(BOLD, 34), DARK)

    opts = [("Pass", None), ("Fail", "correct"), ("Error", None), ("Blank", None)]
    y = 470
    for label, state in opts:
        fill = (200, 230, 201) if state == "correct" else WHITE
        rrect(draw, [bx0, y, bx1, y + 110], 18, fill=fill)
        text(draw, (bx0 + 32, y + 55), label, F(REG, 30), DARK, anchor="lm")
        if state == "correct":
            draw_icon(draw, bx1 - 50, y + 55, "check", (56, 142, 60), 1.0)
        y += 130

    rrect(draw, [bx0, y + 10, bx1, y + 220], 18, fill=(224, 232, 229))
    text(draw, (bx0 + 28, y + 40), "40, 50 se chhota hai isliye condition", F(REG, 24), (60, 60, 60))
    text(draw, (bx0 + 28, y + 76), "FALSE \u2014 \"Fail\" milega.", F(REG, 24), (60, 60, 60))

    by = y + 250
    rrect(draw, [bx0, by, bx1, by + 110], 18, fill=GREEN)
    text(draw, (W / 2, by + 55), "Next Question", F(BOLD, 30), WHITE, anchor="mm")

    img.save("screenshot_3_quiz.png")
    print("Saved screenshot_3_quiz.png")


# ---------------------------------------------------------------
def make_simulator():
    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)
    app_bar(draw, "Practice Simulator")
    draw_icon(draw, W - 60, 75, "sparkle", WHITE, 0.9)
    draw_icon(draw, W - 120, 75, "trash", WHITE, 0.9)

    fy0, fy1 = 150, 240
    draw.rectangle([0, fy0, W, fy1], fill=(238, 238, 238))
    rrect(draw, [24, fy0 + 22, 150, fy1 - 22], 10, fill=GREEN)
    text(draw, (87, (fy0 + fy1) / 2), "B5", F(BOLD, 28), WHITE, anchor="mm")
    rrect(draw, [172, fy0 + 22, W - 24, fy1 - 22], 10, fill=WHITE, outline=(200, 200, 200), width=2)
    text(draw, (200, (fy0 + fy1) / 2), "=SUM(B2:B4)", F(MONO, 26), (50, 50, 50), anchor="lm")

    headers = ["", "A", "B", "C", "D"]
    rows_data = [
        ["1", "Item", "Price", "", ""],
        ["2", "Pen", "10", "", ""],
        ["3", "Notebook", "40", "", ""],
        ["4", "Bag", "250", "", ""],
        ["5", "Total", "300", "", ""],
        ["6", "Average", "100", "", ""],
        ["7", "Status", "Costly", "", ""],
        ["8", "", "", "", ""],
        ["9", "", "", "", ""],
    ]
    col_x = [0, 70, 340, 610, 845, 1080]
    row_h = 110
    ty = fy1

    for i, h in enumerate(headers):
        draw.rectangle([col_x[i], ty, col_x[i + 1], ty + 70], fill=(232, 232, 232), outline=(210, 210, 210), width=2)
        text(draw, ((col_x[i] + col_x[i + 1]) / 2, ty + 35), h, F(BOLD, 26), DARK, anchor="mm")
    ty += 70

    for row in rows_data:
        is_selected_row = row[0] == "5"
        for i, val in enumerate(row):
            box = [col_x[i], ty, col_x[i + 1], ty + row_h]
            bgc = (232, 232, 232) if i == 0 else WHITE
            if i == 2 and is_selected_row:
                bgc = (224, 236, 229)
            draw.rectangle(box, fill=bgc, outline=(224, 224, 224), width=2)
            if i == 0:
                text(draw, ((box[0] + box[2]) / 2, ty + row_h / 2), val, F(BOLD, 24), DARK, anchor="mm")
            elif val:
                fnt = F(BOLD, 26) if (i == 2 and is_selected_row) else F(REG, 26)
                text(draw, (box[0] + 20, ty + row_h / 2), val, fnt, DARK, anchor="lm")
        ty += row_h

    img.save("screenshot_4_simulator.png")
    print("Saved screenshot_4_simulator.png")


if __name__ == "__main__":
    make_home()
    make_lesson()
    make_quiz()
    make_simulator()
    print("All screenshots generated.")
