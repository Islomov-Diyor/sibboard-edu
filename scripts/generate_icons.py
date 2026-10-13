import os
from PIL import Image, ImageDraw

def generate():
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    src_path = os.path.join(project_root, 'assets', 'images', '11_child_on_board.webp')
    
    if not os.path.exists(src_path):
        raise FileNotFoundError(f"Source image not found: {src_path}")
        
    src = Image.open(src_path).convert('RGBA')
    w, h = src.size
    side = min(w, h)
    left = (w - side) // 2
    top = (h - side) // 2
    square_crop = src.crop((left, top, left + side, top + side)).resize((1024, 1024), Image.Resampling.LANCZOS)
    
    # 1. Base Square with rounded corners (for legacy Android / iOS)
    # Master legacy icon with rounded rectangle and warm wood border
    legacy_master = Image.new('RGBA', (1024, 1024), (0, 0, 0, 0))
    mask_legacy = Image.new('L', (1024, 1024), 0)
    draw_mask_leg = ImageDraw.Draw(mask_legacy)
    draw_mask_leg.rounded_rectangle((0, 0, 1024, 1024), radius=220, fill=255)
    legacy_master.paste(square_crop, (0, 0), mask_legacy)
    draw_leg_border = ImageDraw.Draw(legacy_master)
    draw_leg_border.rounded_rectangle((6, 6, 1018, 1018), radius=214, outline=(184, 138, 85, 255), width=12)
    
    # Master round icon with wood border
    round_master = Image.new('RGBA', (1024, 1024), (0, 0, 0, 0))
    mask_round = Image.new('L', (1024, 1024), 0)
    draw_mask_rnd = ImageDraw.Draw(mask_round)
    draw_mask_rnd.ellipse((6, 6, 1018, 1018), fill=255)
    round_master.paste(square_crop, (0, 0), mask_round)
    draw_rnd_border = ImageDraw.Draw(round_master)
    draw_rnd_border.ellipse((10, 10, 1014, 1014), outline=(184, 138, 85, 255), width=12)
    
    # Master Adaptive Foreground (108dp base canvas).
    # Safe zone is central circle of 72dp (diameter 66.6% of canvas).
    # We create a 432x432 master canvas (xxxhdpi), emblem size = 270x270 centered.
    fg_master = Image.new('RGBA', (432, 432), (0, 0, 0, 0))
    emblem_size = 270
    emblem_crop = square_crop.resize((emblem_size, emblem_size), Image.Resampling.LANCZOS)
    emblem_mask = Image.new('L', (emblem_size, emblem_size), 0)
    ImageDraw.Draw(emblem_mask).rounded_rectangle((0, 0, emblem_size, emblem_size), radius=56, fill=255)
    
    emblem = Image.new('RGBA', (emblem_size, emblem_size), (0, 0, 0, 0))
    emblem.paste(emblem_crop, (0, 0), emblem_mask)
    ImageDraw.Draw(emblem).rounded_rectangle((2, 2, emblem_size - 3, emblem_size - 3), radius=54, outline=(184, 138, 85, 255), width=4)
    
    offset = (432 - emblem_size) // 2
    fg_master.paste(emblem, (offset, offset), emblem)
    
    # Android mipmap densities:
    android_res = os.path.join(project_root, 'android', 'app', 'src', 'main', 'res')
    densities = {
        'mipmap-mdpi': (48, 108),
        'mipmap-hdpi': (72, 162),
        'mipmap-xhdpi': (96, 216),
        'mipmap-xxhdpi': (144, 324),
        'mipmap-xxxhdpi': (192, 432),
    }
    
    for folder, (icon_size, fg_size) in densities.items():
        folder_path = os.path.join(android_res, folder)
        os.makedirs(folder_path, exist_ok=True)
        
        # ic_launcher.png
        icon = legacy_master.resize((icon_size, icon_size), Image.Resampling.LANCZOS)
        icon.save(os.path.join(folder_path, 'ic_launcher.png'), 'PNG')
        
        # ic_launcher_round.png
        round_icon = round_master.resize((icon_size, icon_size), Image.Resampling.LANCZOS)
        round_icon.save(os.path.join(folder_path, 'ic_launcher_round.png'), 'PNG')
        
        # ic_launcher_foreground.png
        fg_icon = fg_master.resize((fg_size, fg_size), Image.Resampling.LANCZOS)
        fg_icon.save(os.path.join(folder_path, 'ic_launcher_foreground.png'), 'PNG')
        print(f"Generated icons for {folder}: launcher={icon_size}x{icon_size}, fg={fg_size}x{fg_size}")
        
    # Adaptive icon XMLs
    anydpi_folder = os.path.join(android_res, 'mipmap-anydpi-v26')
    os.makedirs(anydpi_folder, exist_ok=True)
    
    launcher_xml = '''<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background" />
    <foreground android:drawable="@mipmap/ic_launcher_foreground" />
</adaptive-icon>
'''
    with open(os.path.join(anydpi_folder, 'ic_launcher.xml'), 'w', encoding='utf-8') as f:
        f.write(launcher_xml)
        
    with open(os.path.join(anydpi_folder, 'ic_launcher_round.xml'), 'w', encoding='utf-8') as f:
        f.write(launcher_xml)
        
    values_folder = os.path.join(android_res, 'values')
    os.makedirs(values_folder, exist_ok=True)
    bg_xml = '''<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#FBF7F2</color>
</resources>
'''
    with open(os.path.join(values_folder, 'ic_launcher_background.xml'), 'w', encoding='utf-8') as f:
        f.write(bg_xml)
        
    # iOS icons
    ios_icon_dir = os.path.join(project_root, 'ios', 'Runner', 'Assets.xcassets', 'AppIcon.appiconset')
    if os.path.exists(ios_icon_dir):
        ios_sizes = {
            'Icon-App-1024x1024@1x.png': 1024,
            'Icon-App-20x20@1x.png': 20,
            'Icon-App-20x20@2x.png': 40,
            'Icon-App-20x20@3x.png': 60,
            'Icon-App-29x29@1x.png': 29,
            'Icon-App-29x29@2x.png': 58,
            'Icon-App-29x29@3x.png': 87,
            'Icon-App-40x40@1x.png': 40,
            'Icon-App-40x40@2x.png': 80,
            'Icon-App-40x40@3x.png': 120,
            'Icon-App-60x60@2x.png': 120,
            'Icon-App-60x60@3x.png': 180,
            'Icon-App-76x76@1x.png': 76,
            'Icon-App-76x76@2x.png': 152,
            'Icon-App-83.5x83.5@2x.png': 167,
        }
        # iOS prefers full bleed (no alpha corners)
        ios_master = square_crop
        for filename, size in ios_sizes.items():
            img = ios_master.resize((size, size), Image.Resampling.LANCZOS).convert('RGB')
            img.save(os.path.join(ios_icon_dir, filename), 'PNG')
            print(f"Generated iOS icon: {filename} ({size}x{size})")

    print("All app icons successfully generated!")

if __name__ == '__main__':
    generate()
