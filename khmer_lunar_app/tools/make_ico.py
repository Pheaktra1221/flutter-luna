"""Build a proper multi-size .ico from app.ico (source) or any image."""
import struct, io, os
from PIL import Image

def frames_to_ico(frames, out_path):
    """Write multiple RGBA PIL images as a single .ico file."""
    images_data = []
    for img in frames:
        img = img.convert('RGBA')
        buf = io.BytesIO()
        img.save(buf, format='PNG')
        images_data.append(buf.getvalue())

    n = len(images_data)
    # ICO header: reserved(2) type(2) count(2)
    header = struct.pack('<HHH', 0, 1, n)
    # Each directory entry: width(1) height(1) colorCount(1) reserved(1)
    #   planes(2) bitCount(2) sizeInBytes(4) offsetInFile(4)
    dir_size = 16 * n
    offset = 6 + dir_size  # after header + directory

    directory = b''
    for i, (img, data) in enumerate(zip(frames, images_data)):
        w, h = img.size
        w_byte = w if w < 256 else 0
        h_byte = h if h < 256 else 0
        size = len(data)
        directory += struct.pack('<BBBBHHII', w_byte, h_byte, 0, 0, 1, 32, size, offset)
        offset += size

    with open(out_path, 'wb') as f:
        f.write(header + directory)
        for data in images_data:
            f.write(data)

    print(f'Written {out_path}  ({os.path.getsize(out_path)//1024} KB)  frames: {[img.size for img in frames]}')


def main():
    src = r'D:\Calender\app.ico'
    img = Image.open(src)

    # Extract available frames from source ICO
    base = None
    for size in [48, 32, 16]:
        try:
            img.size = (size, size)
            base = img.copy().convert('RGBA')
            break
        except:
            pass

    if base is None:
        base = img.convert('RGBA')
    base = base.resize((256, 256), Image.LANCZOS)

    # Build all required sizes
    sizes = [16, 24, 32, 48, 64, 128, 256]
    frames = [base.resize((s, s), Image.LANCZOS) for s in sizes]

    # Windows app icon
    ico_out = r'D:\Calender\khmer_lunar_app\windows\runner\resources\app_icon.ico'
    frames_to_ico(frames, ico_out)

    # PNG for Flutter in-app header (256px)
    png_out = r'D:\Calender\khmer_lunar_app\assets\images\app_icon.png'
    frames[-1].save(png_out, 'PNG')
    print(f'PNG: {png_out}')

    # macOS iconset
    mac_dir = r'D:\Calender\khmer_lunar_app\macos\Runner\Assets.xcassets\AppIcon.appiconset'
    os.makedirs(mac_dir, exist_ok=True)
    for sz in [16, 32, 64, 128, 256, 512, 1024]:
        base.resize((sz, sz), Image.LANCZOS).save(
            os.path.join(mac_dir, f'app_icon_{sz}.png'), 'PNG')
    print(f'macOS icons → {mac_dir}')


if __name__ == '__main__':
    main()
