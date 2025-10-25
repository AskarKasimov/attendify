# Attendify UI Kit

Простой и красивый UI Kit для Flutter приложений.

## Особенности

- 🎨 **Современный дизайн** - Material Design 3
- 📱 **Кроссплатформенность** - iOS и Android  
- 🎯 **Базовые компоненты** - кнопки, поля ввода, диалоги
- 🔧 **Простота** - минимум кода, максимум функций

## Компоненты

### Кнопки

```dart
// Основная кнопка
AppButton.text(
  onPressed: () {},
  text: 'Нажми меня',
)

// Вторичная кнопка
AppButton.text(
  onPressed: () {},
  text: 'Отмена',
  variant: AppButtonVariant.outline,
)

// Кнопка с иконкой
AppIconButton(
  icon: Icons.favorite,
  onPressed: () {},
)
```

### Поля ввода

```dart
// Обычное поле
AppTextField(
  label: 'Имя',
  placeholder: 'Введите имя',
)

// Поиск
AppSearchField(
  placeholder: 'Поиск...',
)
```

### Диалоги

```dart
// Информация
AppDialog.showInfo(
  context: context,
  title: 'Готово',
  message: 'Всё хорошо!',
);

// Загрузка
AppLoadingDialog.show(context: context);
```

## Использование

1. Добавь тему:
```dart
MaterialApp(
  theme: AppTheme.light,
  home: MyPage(),
)
```

2. Используй компоненты:
```dart
AppButton.text(
  onPressed: () {},
  text: 'Готово',
)
```