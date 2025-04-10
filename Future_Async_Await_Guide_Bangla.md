
# 📘 Future, async/await, and .then() - Flutter (Bangla Guide)

---

## 🔹 Future কী?
> এমন একটি ফাংশন যা সাথে সাথে কাজ শেষ করে না — **ভবিষ্যতে (Future)** কোনো সময় রেজাল্ট দিবে।

```dart
Future<String> getData() {
  return Future.delayed(Duration(seconds: 2), () => "ডেটা চলে এসেছে ✅");
}
```

---

## 🔹 async কী?
> যখন তোমার ফাংশনের ভিতরে `await` থাকবে, তখন সেই ফাংশনকে `async` বানাতে হবে।

```dart
void main() async {
  print("ডেটা নিচ্ছি...");
  String result = await getData();
  print(result);
}
```

---

## 🔹 await কী?
> `await` দিয়ে তুমি কোনো Future-এর কাজ শেষ না হওয়া পর্যন্ত **অপেক্ষা** করো।

---

## 🔹 .then() কী?
> এটা `callback` ফরম্যাটে Future এর কাজ শেষ হলে response নেয়।

```dart
getData().then((value) {
  print(value);
});
```

---

## 🔁 তুলনা:

| ধরন     | অপেক্ষা করে? | Code readable? | কবে ব্যবহার করবো                  |
|----------|----------------|-----------------|-----------------------------------|
| `await`    | ✅ হ্যাঁ         | ✅ Clean         | ধারাবাহিকভাবে কাজ দরকার হলে        |
| `.then()`  | ❌ না           | ❌ কম clean       | simple chaining callback-এ         |
| No await | ❌ না           | ❌ সমস্যা হতে পারে | যখন শুধু call করে দেখতেই চাও       |

---

## 🔥 উদাহরণ:

```dart
void main() async {
  await Hive.openBox('cartBox'); // ✅ Wait না করলে Crash
  runApp(MyApp());
}
```

---

## 🧠 মনে রাখো:

🔹 **async/await** = clean, readable, sequential  
🔹 **.then()** = callback style  
🔹 **Future only** = handle না করলে app crash করতে পারে
