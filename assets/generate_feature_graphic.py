"""Generates the Play Store Feature Graphic (1024x500 PNG) for Excel Guru."""
from PIL import Image, ImageDraw, ImageFont

W, H = 1024, 500
GREEN = (29, 111, 66)
GREEN_DARK = (15, 81, 50)
ACCENT = (255, 193, 7)
WHITE = (255, 255, 255)
HEADER_BG = (231, 240, 235)
GRID_LINE = (218, 227, 222)
TEXT_GREY = (100, 118, 109)

FONT_DIR = "C:\\Windows\\Fonts\\"


def F(name, size):
    try:
        return ImageFont.truetype(FONT_DIR + name, size)
    except Exception:
        return ImageFont.load_default()


def text(draw, xy, s, fnt, fill, anchor=None):
    draw.text(xy, s, font=fnt, fill=fill, anchor=anchor)


# Gradient background
img = Image.new("RGB", (W, H), GREEN)
draw = ImageDraw.Draw(img)
for x in range(W):
    t = x / W
    r = int(GREEN[0] + (GREEN_DARK[0] - GREEN[0]) * t)
    g = int(GREEN[1] + (GREEN_DARK[1] - GREEN[1]) * t)
    b = int(GREEN[2] + (GREEN_DARK[2] - GREEN[2]) * t)
    draw.line([(x, 0), (x, H)], fill=(r, g, b))

# Left side: Title + tagline
text(draw, (60, 130), "Excel Guru", F("segoeuib.ttf", 72), WHITE)
text(draw, (60, 220), "Excel Seekhein Hindi Mein", F("segoeui.ttf", 34), (225, 238, 230))
text(draw, (60, 268), "Lessons \u2022 Quiz \u2022 Practice Simulator", F("segoeui.ttf", 26), (200, 222, 210))

# Small badge row
badge_y = 360
badges = ["50 Levels", "Free Lessons", "Hindi+Marathi"]
bx = 60
for b in badges:
    bw = len(b) * 13 + 36
    draw.rounded_rectangle([bx, badge_y, bx + bw, badge_y + 46], radius=23, fill=(50, 128, 88))
    draw.rounded_rectangle([bx, badge_y, bx + bw, badge_y + 46], radius=23, outline=(255, 255, 255), width=2)
    text(draw, (bx + bw / 2, badge_y + 23), b, F("segoeuib.ttf", 18), WHITE, anchor="mm")
    bx += bw + 14

# Right side: mini spreadsheet card (like the icon)
card_x0, card_y0 = 700, 70
card_w, card_h = 260, 360
draw.rounded_rectangle([card_x0, card_y0, card_x0 + card_w, card_y0 + card_h], radius=24, fill=WHITE)

header_h = 44
row_label_w = 44
draw.rounded_rectangle([card_x0, card_y0, card_x0 + card_w, card_y0 + header_h], radius=24, fill=HEADER_BG)
draw.rectangle([card_x0, card_y0 + header_h - 24, card_x0 + card_w, card_y0 + header_h], fill=HEADER_BG)
draw.rounded_rectangle([card_x0, card_y0, card_x0 + row_label_w, card_y0 + header_h], radius=24, fill=HEADER_BG)
draw.rectangle([card_x0, card_y0, card_x0 + row_label_w, card_y0 + card_h], fill=HEADER_BG)
draw.rounded_rectangle([card_x0, card_y0, card_x0 + row_label_w, card_y0 + header_h], radius=24, fill=HEADER_BG)

cols, rows = ["A", "B", "C"], ["1", "2", "3"]
gx0, gy0 = card_x0 + row_label_w, card_y0 + header_h
gx1, gy1 = card_x0 + card_w, card_y0 + card_h
cw, rh = (gx1 - gx0) / 3, (gy1 - gy0) / 3
label_font = F("segoeuib.ttf", 18)
for i, c in enumerate(cols):
    text(draw, (gx0 + cw * i + cw / 2, card_y0 + header_h / 2), c, label_font, TEXT_GREY, anchor="mm")
for i, r in enumerate(rows):
    text(draw, (card_x0 + row_label_w / 2, gy0 + rh * i + rh / 2), r, label_font, TEXT_GREY, anchor="mm")
for i in range(1, 3):
    draw.line([(gx0 + cw * i, card_y0), (gx0 + cw * i, gy1)], fill=GRID_LINE, width=2)
    draw.line([(card_x0, gy0 + rh * i), (gx1, gy0 + rh * i)], fill=GRID_LINE, width=2)
draw.line([(card_x0, card_y0 + header_h), (gx1, card_y0 + header_h)], fill=GRID_LINE, width=2)
draw.line([(gx0, card_y0), (gx0, gy1)], fill=GRID_LINE, width=2)

sel = [gx0 + cw, gy0 + rh, gx0 + 2 * cw, gy0 + 2 * rh]
draw.rectangle(sel, fill=(255, 250, 227))
draw.rectangle(sel, outline=ACCENT, width=4)
text(draw, ((sel[0] + sel[2]) / 2, (sel[1] + sel[3]) / 2), "fx", F("segoeuib.ttf", 34), GREEN_DARK, anchor="mm")

img.save("feature_graphic.png")
print("Saved feature_graphic.png")
