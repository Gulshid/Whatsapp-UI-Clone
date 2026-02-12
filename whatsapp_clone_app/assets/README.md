# Assets Directory

This directory contains all the app assets including images, icons, sounds, and fonts.

## Directory Structure

```
assets/
├── images/          # App images and illustrations
├── icons/           # App icons and graphics
├── sounds/          # Sound effects and notification sounds
└── fonts/           # Custom fonts (if any)
```

## Adding Assets

1. Place your asset files in the appropriate directory
2. Reference them in `pubspec.yaml` under the `flutter:` section
3. Load them in your code using the asset path

## Example Usage

### Images
```dart
Image.asset('assets/images/logo.png')
```

### Icons
```dart
Image.asset('assets/icons/settings.png')
```

### Sounds
```dart
AudioPlayer().play(AssetSource('sounds/notification.mp3'));
```

## Required Assets

For the WhatsApp clone to work properly, you should add the following assets:

### Images
- `whatsapp_logo.png` - App logo for welcome screen
- `default_user.png` - Default user avatar
- `default_group.png` - Default group avatar
- `chat_background.png` - Chat wallpaper (optional)

### Sounds
- `message_sent.mp3` - Sound when sending a message
- `message_received.mp3` - Sound when receiving a message
- `notification.mp3` - General notification sound

### Fonts (Optional)
- Custom fonts for branding

## Image Specifications

- **Logo**: 512x512 px, PNG with transparency
- **Avatars**: 200x200 px, PNG or JPEG
- **Chat Background**: 1080x1920 px, PNG or JPEG

## Sound Specifications

- Format: MP3 or WAV
- Duration: 1-3 seconds for notification sounds
- Sample Rate: 44.1 kHz recommended

---

Note: This is a placeholder directory. Add your actual assets as needed.
