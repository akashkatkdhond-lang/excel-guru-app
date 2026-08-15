"""Generates the Play Store app icon (512x512 PNG) for Excel Guru —
a spreadsheet grid with column/row headers, soft shadow and a subtle
growth accent, styled like a real sheet.
Run: python generate_icon.py
"""
from PIL import Image, ImageDraw, ImageFont, ImageFilter

SIZE = 512
GREEN = (34, 128, 76)
GREEN_LIGHT = (52, 155, 97)
GREEN_DARK = (13, 71, 43)
ACCENT = (255, 193, 7)
ACCENT_DARK = (230, 160, 0)
WHITE = (255, 255, 255)
HEADER_BG = (231, 240, 235)
GRID_LINE = (218, 227, 222)
TEXT_GREY = (100, 118, 109)


def font(path, size):
    try:
        return ImageFont.truetype(path, size)
    except Exception:
        return ImageFont.load_default()


def centered_text(draw, box, text, fnt, fill):
    x0, y0, x1, y1 = box
    bbox = draw.textbbox((0, 0), text, font=fnt)
    tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
    tx = x0 + ((x1 - x0) - tw) / 2 - bbox[0]
    ty = y0 + ((y1 - y0) - th) / 2 - bbox[1]
    draw.text((tx, ty), text, fill=fill, font=fnt)


# --- Background: diagonal gradient (light -> dark green), rounded square ---
grad = Image.new("RGB", (SIZE, SIZE), GREEN)
gdraw = ImageDraw.Draw(grad)
for y in range(SIZE):
    for_t = y / SIZE
    r = int(GREEN_LIGHT[0] + (GREEN_DARK[0] - GREEN_LIGHT[0]) * for_t)
    g = int(GREEN_LIGHT[1] + (GREEN_DARK[1] - GREEN_LIGHT[1]) * for_t)
    b = int(GREEN_LIGHT[2] + (GREEN_DARK[2] - GREEN_LIGHT[2]) * for_t)
    gdraw.line([(0, y), (SIZE, y)], fill=(r, g, b))

mask = Image.new("L", (SIZE, SIZE), 0)
ImageDraw.Draw(mask).rounded_rectangle([0, 0, SIZE, SIZE], radius=112, fill=255)
base = Image.new("RGB", (SIZE, SIZE), GREEN)
base.paste(grad, (0, 0), mask)

# Soft diagonal gloss highlight (top-left glow)
gloss = Image.new("L", (SIZE, SIZE), 0)
gdraw2 = ImageDraw.Draw(gloss)
gdraw2.ellipse([-160, -200, 420, 260], fill=70)
gloss = gloss.filter(ImageFilter.GaussianBlur(90))
white_layer = Image.new("RGB", (SIZE, SIZE), WHITE)
base = Image.composite(white_layer, base, gloss)
base.paste(base, (0, 0), mask)  # re-clip to rounded corners

img = base.convert("RGBA")

# --- Drop shadow for the sheet card ---
margin = 62
sheet_box = [margin, margin, SIZE - margin, SIZE - margin]
shadow_layer = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
sdraw = ImageDraw.Draw(shadow_layer)
shadow_offset = 14
sdraw.rounded_rectangle(
    [sheet_box[0], sheet_box[1] + shadow_offset, sheet_box[2], sheet_box[3] + shadow_offset],
    radius=30, fill=(0, 0, 0, 110),
)
shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(16))
img = Image.alpha_composite(img, shadow_layer)

draw = ImageDraw.Draw(img)
draw.rounded_rectangle(sheet_box, radius=28, fill=WHITE)
sx0, sy0, sx1, sy1 = sheet_box

header_h = 56
row_label_w = 56

draw.rounded_rectangle([sx0, sy0, sx1, sy0 + header_h], radius=28, fill=HEADER_BG)
draw.rectangle([sx0, sy0 + header_h - 28, sx1, sy0 + header_h], fill=HEADER_BG)
draw.rounded_rectangle([sx0, sy0, sx0 + row_label_w, sy0 + header_h], radius=28, fill=HEADER_BG)
draw.rectangle([sx0, sy0, sx0 + row_label_w, sy1], fill=HEADER_BG)
draw.rounded_rectangle([sx0, sy0, sx0 + row_label_w, sy0 + header_h], radius=28, fill=HEADER_BG)

label_font = font("C:\\Windows\\Fonts\\arialbd.ttf", 26)
cols, rows = ["A", "B", "C"], ["1", "2", "3"]
grid_x0, grid_y0 = sx0 + row_label_w, sy0 + header_h
grid_x1, grid_y1 = sx1, sy1
col_w = (grid_x1 - grid_x0) / len(cols)
row_h = (grid_y1 - grid_y0) / len(rows)

for i, c in enumerate(cols):
    box = [grid_x0 + i * col_w, sy0, grid_x0 + (i + 1) * col_w, sy0 + header_h]
    centered_text(draw, box, c, label_font, TEXT_GREY)
for i, r in enumerate(rows):
    box = [sx0, grid_y0 + i * row_h, sx0 + row_label_w, grid_y0 + (i + 1) * row_h]
    centered_text(draw, box, r, label_font, TEXT_GREY)

for i in range(1, len(cols)):
    x = grid_x0 + col_w * i
    draw.line([(x, sy0), (x, grid_y1)], fill=GRID_LINE, width=3)
for i in range(1, len(rows)):
    y = grid_y0 + row_h * i
    draw.line([(sx0, y), (grid_x1, y)], fill=GRID_LINE, width=3)
draw.line([(sx0, sy0 + header_h), (sx1, sy0 + header_h)], fill=GRID_LINE, width=3)
draw.line([(sx0 + row_label_w, sy0), (sx0 + row_label_w, sy1)], fill=GRID_LINE, width=3)

# Highlighted "selected" cell = B2, with its own soft shadow + glossy gold border
sel_box = [grid_x0 + col_w, grid_y0 + row_h, grid_x0 + 2 * col_w, grid_y0 + 2 * row_h]
sel_shadow = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
ssd = ImageDraw.Draw(sel_shadow)
ssd.rectangle([sel_box[0] - 2, sel_box[1] + 4, sel_box[2] + 2, sel_box[3] + 8], fill=(230, 160, 0, 90))
sel_shadow = sel_shadow.filter(ImageFilter.GaussianBlur(8))
img = Image.alpha_composite(img, sel_shadow)
draw = ImageDraw.Draw(img)

draw.rectangle(sel_box, fill=(255, 250, 227))
draw.rectangle(sel_box, outline=ACCENT, width=3)
draw.rectangle([sel_box[0] - 3, sel_box[1] - 3, sel_box[2] + 3, sel_box[3] + 3], outline=ACCENT_DARK, width=2)

fx_font = font("C:\\Windows\\Fonts\\arialbd.ttf", int(row_h * 0.55))
centered_text(draw, sel_box, "fx", fx_font, GREEN_DARK)

# Small upward "growth" trend accent in the bottom-right, outside the card
tx0, ty0 = SIZE - 118, SIZE - 96
pts = [(tx0, ty0 + 34), (tx0 + 24, ty0 + 12), (tx0 + 44, ty0 + 26), (tx0 + 72, ty0 - 6)]
draw.line(pts, fill=ACCENT, width=7, joint="curve")
# little dot markers + arrowhead
for p in pts:
    draw.ellipse([p[0] - 5, p[1] - 5, p[0] + 5, p[1] + 5], fill=ACCENT)
ax, ay = pts[-1]
draw.polygon([(ax, ay), (ax - 14, ay - 2), (ax - 4, ay + 12)], fill=ACCENT)

img.convert("RGB").save("icon_512.png", "PNG")
print("Saved icon_512.png")
