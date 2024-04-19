# localize_sl

An application to help tourists to find best places to visit nearby from their current location.
Tourists can find travel guides who can assit with vlogging and photography.
An AI powered chatbot is also available to assist with any queries.

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Create a new dart file under lib/ directory. Name it `secrets.dart`.
4. Add the following code to `secrets.dart`:
```dart
const openaiApiKey = "YOUR_OPENAI_API_KEY";
const systemPrompt = """
You are a friendly, helpful chatbot that is here to assist you with your questions.
""";
```
5. Change the value of `openaiApiKey` to your OpenAI API key.
6. Change the value of `systemPrompt` to your desired system prompt.
7. Run the app using `flutter run`
