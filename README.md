# Localize Sri Lanka

A web app to help tourists to find best places to visit and find best travel guides nearby in Sri Lanka.
Tourists can find travel guides who can assit with vlogging and photography.
An AI powered chatbot is also available to assist with any queries.
Developed by Team `Phantom Orion` for `IDEALIZE - 2024`.
This project won the `Devthon 1.0 - 2024` hackathon.

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Open the file `lib/secrets.dart`
```dart
// lib/secrets.dart
const openaiApiKey = "YOUR_OPENAI_API_KEY";
const systemPrompt = """
You are a friendly, helpful chatbot that is here to assist you with your questions.
""";
```
4. Change the value of `openaiApiKey` to your OpenAI API key.
5. Change the value of `systemPrompt` to your desired system prompt.
6. Change the `chatFeatureEnabled` to `true` in `lib/home.dart` to enable the AI chat feature.
```dart
// lib/home.dart
const chatFeatureEnabled = true;
```
7. Run the app using `flutter run`

## Technologies Used

- Dart/Flutter
- OpenAI API

## Team Phantom Orion

- [Vimosh Vasanthakumar](https://github.com/vimosh0812)
- [birunthabanr](https://github.com/birunthabanr)
- [Kavienan J](https://github.com/kavienanj)
- [Donald Aadithiyan](https://github.com/DonaldAadithiyan)
- [VarunRaj004](https://github.com/VarunRaj004)

# Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature`)
5. Create a new Pull Request
