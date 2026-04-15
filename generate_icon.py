"""ZenSutra - Warm amber gradient with enso circle and lotus"""
from PIL import Image, ImageDraw, ImageFont
import math
import os

SIZE = 1024
img = Image.new('RGB', (SIZE, SIZE), (255, 245, 220))
draw = ImageDraw.Draw(img)

# Warm amber/cream gradient
for y in range(SIZE):
    ratio = y / SIZE
    r = int(255 - 20 * ratio)
    g = int(245 - 55 * ratio)
    b = int(220 - 100 * ratio)
    draw.line([(0, y), (SIZE, y)], fill=(r, g, b))

amber = (200, 120, 30)
amber_dark = (160, 85, 15)
amber_light = (230, 160, 60)
ink = (45, 28, 10)
cream = (255, 248, 230)
rust = (170, 75, 25)

cx, cy = SIZE // 2, SIZE // 2 - 40

# Enso circle (zen brush circle - incomplete at top-right)
# Simulate brush stroke with varying width arc
enso_r = 320
stroke_width_base = 28

# Draw the enso as a thick arc (open circle, gap at top-right ~30 degrees)
# Use multiple overlapping lines at increasing angles for brush feel
gap_start = 310  # degrees where gap begins
gap_end = 345    # degrees where gap ends

for pass_i in range(3):
    offset = (pass_i - 1) * 4
    for deg in range(gap_end, gap_start + 360, 2):
        actual_deg = deg % 360
        if gap_start <= actual_deg <= gap_end:
            continue
        angle1 = math.radians(actual_deg)
        angle2 = math.radians(actual_deg + 2)
        # Varying width for brush feel - thicker at sides, thinner at ends
        progress = (actual_deg - gap_end) % 360 / ((gap_start - gap_end) % 360 + 360)
        taper = math.sin(progress * math.pi)
        w = int(stroke_width_base * (0.4 + 0.8 * taper)) + offset
        w = max(2, w)
        x1 = cx + (enso_r + offset) * math.cos(angle1)
        y1 = cy + (enso_r + offset) * math.sin(angle1)
        x2 = cx + (enso_r + offset) * math.cos(angle2)
        y2 = cy + (enso_r + offset) * math.sin(angle2)
        draw.line([(x1, y1), (x2, y2)], fill=ink, width=w)

# Lotus flower in center
def draw_petal(draw, cx, cy, angle_deg, length, width_half, color, outline):
    angle = math.radians(angle_deg)
    perp = math.radians(angle_deg + 90)
    tip_x = cx + length * math.cos(angle)
    tip_y = cy + length * math.sin(angle)
    left_x = cx + width_half * math.cos(perp)
    left_y = cy + width_half * math.sin(perp)
    right_x = cx - width_half * math.cos(perp)
    right_y = cy - width_half * math.sin(perp)
    # Draw as a simple ellipse rotated
    pts = []
    for t in range(37):
        frac = t / 36
        blend_x = (left_x + right_x) / 2 + (tip_x - (left_x + right_x) / 2) * math.sin(frac * math.pi)
        off_x = (left_x - right_x) / 2 * math.cos(frac * 2 * math.pi)
        off_y = (left_y - right_y) / 2 * math.cos(frac * 2 * math.pi)
        pts.append((blend_x + off_x, (left_y + right_y) / 2 + (tip_y - (left_y + right_y) / 2) * math.sin(frac * math.pi) + off_y))
    if len(pts) >= 3:
        draw.polygon(pts, fill=color, outline=outline)

# Outer petals (8 petals)
for i in range(8):
    angle = -90 + i * 45
    draw_petal(draw, cx, cy, angle, 140, 38, (240, 180, 100), amber_dark)

# Inner petals (8 petals, rotated 22.5 degrees, shorter)
for i in range(8):
    angle = -90 + 22.5 + i * 45
    draw_petal(draw, cx, cy, angle, 95, 26, (250, 200, 120), amber)

# Center circle of lotus
draw.ellipse([cx - 38, cy - 38, cx + 38, cy + 38],
             fill=(220, 140, 40), outline=amber_dark, width=3)
draw.ellipse([cx - 18, cy - 18, cx + 18, cy + 18],
             fill=(200, 110, 20))

# Subtle horizontal lines in background (bamboo/temple paper texture)
for i in range(12):
    y_line = 80 + i * 75
    draw.line([(60, y_line), (SIZE - 60, y_line)],
              fill=(240, 225, 195), width=1)

# Title: ZEN at bottom
try:
    font_title = ImageFont.truetype("C:/Windows/Fonts/arialbd.ttf", 110)
    font_sub = ImageFont.truetype("C:/Windows/Fonts/arial.ttf", 40)
    title = "ZEN"
    bbox = draw.textbbox((0, 0), title, font=font_title)
    tw = bbox[2] - bbox[0]
    draw.text(((SIZE - tw) // 2, SIZE - 220), title, fill=ink, font=font_title)
    # Decorative dots flanking text
    dot_y = SIZE - 165
    draw.ellipse([SIZE//2 - 140 - 8, dot_y - 8, SIZE//2 - 140 + 8, dot_y + 8], fill=amber_dark)
    draw.ellipse([SIZE//2 + 140 - 8, dot_y - 8, SIZE//2 + 140 + 8, dot_y + 8], fill=amber_dark)
    draw.line([SIZE//2 - 130, dot_y, SIZE//2 + 130, dot_y], fill=amber_dark, width=2)
except:
    pass

out = os.path.join(os.path.dirname(os.path.abspath(__file__)),
    "ZenSutra", "Assets.xcassets", "AppIcon.appiconset", "icon_1024.png")
img.save(out, "PNG")
print(f"Saved: {out}")
img.save(os.path.join(os.path.dirname(os.path.abspath(__file__)), "AppIcon.png"))
print("Done")
