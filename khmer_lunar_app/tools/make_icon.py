"""
Generate app_icon.ico for the Khmer Lunar Calendar app.
Design: green circle, white crescent moon, Khmer letter ខ in white centre.
Produces sizes: 16, 32, 48, 64, 128, 256 px all inside one .ico file.
"""
import math, struct, zlib, os
from PIL import Image, ImageDraw, ImageFont

# ── Colours ──────────────────────────────────────────────────────────────────
GREEN_DARK   = (27,  94,  32,  255)
GREEN_MID    = (46, 125,  50,  255)
GREEN_LIGHT  = (76, 175,  80,  255)
WHITE        = (255, 255, 255, 255)
GOLD         = (255, 200,  50,  255)
TRANSPARENT  = (0, 0, 0, 0)

def draw_icon(size: int) -> Image.Image:
    img = Image.new("RGBA", (size, size), TRANSPARENT)
    draw = ImageDraw.Draw(img)
    s = size

    # ── Outer green circle ───────────────────────────────────────────────────
    draw.ellipse([0, 0, s-1, s-1], fill=GREEN_MID)

    # ── Subtle gradient ring (darker edge) ──────────────────────────────────
    draw.ellipse([0, 0, s-1, s-1], outline=GREEN_DARK, width=max(1, s//32))

    cx, cy = s / 2, s / 2
    r = s / 2

    # ── White full circle (moon base) ────────────────────────────────────────
    mr = r * 0.62
    mx, my = cx + r * 0.04, cy - r * 0.04
    draw.ellipse([mx-mr, my-mr, mx+mr, my+mr], fill=WHITE)

    # ── Green circle to cut crescent ─────────────────────────────────────────
    cr = r * 0.52
    ox = cx + r * 0.22
    draw.ellipse([ox-cr, my-cr, ox+cr, my+cr], fill=GREEN_MID)

    # ── Gold stars (3 small) ─────────────────────────────────────────────────
    if size >= 32:
        star_r = max(1, s * 0.055)
        positions = [
            (cx - r*0.30, cy - r*0.50),
            (cx + r*0.05, cy - r*0.62),
            (cx + r*0.38, cy - r*0.48),
        ]
        for (sx2, sy2) in positions:
            _star(draw, sx2, sy2, star_r, GOLD)

    # ── Khmer letter "ខ" in white at bottom ──────────────────────────────────
    if size >= 48:
        label_size = max(10, int(s * 0.28))
        try:
            font_path = os.path.join(
                os.path.dirname(__file__), "..", "assets", "fonts", "KhmerOSsiemreap.ttf"
            )
            font = ImageFont.truetype(font_path, label_size)
        except Exception:
            font = ImageFont.load_default()

        text = "ខ"
        # get text bounding box
        bb = draw.textbbox((0, 0), text, font=font)
        tw = bb[2] - bb[0]
        th = bb[3] - bb[1]
        tx = cx - tw / 2 - bb[0]
        ty = cy + r * 0.18 - th / 2 - bb[1]
        # shadow
        draw.text((tx+1, ty+1), text, font=font, fill=(0,0,0,100))
        draw.text((tx, ty), text, font=font, fill=WHITE)

    return img


def _star(draw, cx, cy, r, color):
    """Draw a 5-pointed star."""
    pts = []
    for i in range(10):
        angle = math.radians(i * 36 - 90)
        rr = r if i % 2 == 0 else r * 0.42
        pts.append((cx + rr * math.cos(angle), cy + rr * math.sin(angle)))
    draw.polygon(pts, fill=color)


def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.join(script_dir, "..")

    sizes = [16, 32, 48, 64, 128, 256]
    frames = [draw_icon(s) for s in sizes]

    # ── Write Windows .ico ───────────────────────────────────────────────────
    ico_path = os.path.join(project_root, "windows", "runner", "resources", "app_icon.ico")
    # PIL ICO: save the largest frame, listing all sizes
    frames[-1].save(
        ico_path,
        format="ICO",
        sizes=[(s, s) for s in sizes],
    )
    print(f"✓ {ico_path}  ({os.path.getsize(ico_path)//1024} KB)")

    # ── Write PNG for Flutter assets (used in taskbar / about) ──────────────
    png_dir = os.path.join(project_root, "assets", "images")
    os.makedirs(png_dir, exist_ok=True)
    png_path = os.path.join(png_dir, "app_icon.png")
    frames[-1].save(png_path, "PNG")
    print(f"✓ {png_path}")

    # ── Write macOS iconset PNGs ─────────────────────────────────────────────
    mac_dir = os.path.join(project_root, "macos", "Runner", "Assets.xcassets",
                           "AppIcon.appiconset")
    os.makedirs(mac_dir, exist_ok=True)
    mac_sizes = {
        "app_icon_16.png": 16, "app_icon_32.png": 32,
        "app_icon_64.png": 64, "app_icon_128.png": 128,
        "app_icon_256.png": 256, "app_icon_512.png": 512,
        "app_icon_1024.png": 1024,
    }
    for fname, sz in mac_sizes.items():
        draw_icon(sz).save(os.path.join(mac_dir, fname), "PNG")
    print(f"✓ macOS iconset written to {mac_dir}")


if __name__ == "__main__":
    main()
