### Умный помощник для вашей домашней аптечки

![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-blue)
![iOS](https://img.shields.io/badge/iOS-17.0+-lightgrey)

**PharmMemory** — это удобное приложение для управления домашней аптечкой. Следите за сроками годности лекарств, создавайте списки покупок и сканируйте штрих-коды для автоматического добавления препаратов.

---

## 🎯 Для кого это приложение?
PharmMemory создан для **обычных людей**, которые хотят:

✔ **Контролировать** состав домашней аптечки  
✔ **Избегать** покупки дубликатов лекарств  
✔ **Следить** за сроками годности  
✔ **Планировать** покупки в аптеке  

---

## ✨ Возможности
- 📦 **Учет лекарств**
  - Добавление, редактирование и удаление препаратов
  - Автоматическое заполнение данных о лекарстве по штрих-коду
- ⏳ **Контроль сроков годности**
  - Визуальные подсказки (оранжевый/красный индикатор)
  - Уведомления об истекающем сроке
- 🛒 **Список покупок**
  - Легко добавлять препараты в корзину
  - Планирование покупок на основе заканчивающихся лекарств
- 📷 **Сканирование штрих-кодов**
  - Мгновенное распознавание артикулов
  - Автозаполнение данных о лекарствах

---

## 🛠 Технологический стек

### iOS
- **SwiftUI** — современный декларативный фреймворк для UI
- **SwiftData** — мощное и простое решение для локального хранения данных
- **Vision + AVFoundation** — сканирование штрих-кодов через камеру
- **Combine** — реактивное программирование для управления состоянием
- **ServiceLocator** — DI-контейнер для инъекции зависимостей

### Backend
- **Собственный API** для получения данных о лекарствах по артикулу

### Архитектура
- **MVVM (Model-View-ViewModel)**
  - Четкое разделение логики и интерфейса
  - Легкая поддержка и тестируемость
  - Реактивные обновления UI через Combine

---

## 📱 Описание экранов

### 🔔 Начало работы
<img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 18 44" src="https://github.com/user-attachments/assets/a48a548d-a163-43a4-bf75-72a7cf9a0351" />

При первом запуске приложение запрашивает разрешение на отправку уведомлений. Это необходимо для своевременного оповещения об истекающем сроке годности лекарств. Вы всегда можете изменить настройки уведомлений позже в соответствующем разделе.

### 1. Моя аптечка (главный экран)
<img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 35 43" src="https://github.com/user-attachments/assets/c4e19a9b-af62-4794-9415-d3166468107e" /><img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 36 29" src="https://github.com/user-attachments/assets/8348fa10-98d5-4168-9033-adeab7b0d0ed" />


- **Список лекарств** с карточками (название, дозировка, количество, срок годности)
- **Индикаторы срока годности**:
  - 🟠 Оранжевый — осталось меньше 30 дней
  - 🔴 Красный — срок истек
- **Поиск** по названию в верхней части экрана
- **Кнопка "+"** для добавления нового препарата
- **Свайп для удаления** лекарств

### 2. Добавление/редактирование лекарства
<img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 26 22" src="https://github.com/user-attachments/assets/15b0d429-874f-479c-919b-992c91943902" /><img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 29 04" src="https://github.com/user-attachments/assets/d7445a68-3f96-4e51-bfa1-a11674c557fe" /><img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 32 15" src="https://github.com/user-attachments/assets/149f79ef-b1a7-4d49-b5ac-449a82c32867" /><img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 33 16" src="https://github.com/user-attachments/assets/4102db9f-764e-4619-b51a-794be9530d1a" />


- Поля для ввода:
  - Название
  - Дозировка (с выбором единиц измерения)
  - Количество
  - Срок годности
  - Заметки
- **Добавить в список покупок** — удобный чекбокс
- **Кнопка сканирования штрих-кода** → открывает камеру

### 3. Сканирование штрих-кода
<img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 26 22" src="https://github.com/user-attachments/assets/d149bdc9-fcd6-48ea-aec9-309a67aa7aec" /><img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 26 22" src="https://github.com/user-attachments/assets/8df7792d-1f1d-46e0-aac4-16e1857faf2d" /><img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 26 22" src="https://github.com/user-attachments/assets/02bbe3f2-e1f9-4628-97a2-3c8fdcb28c1d" />

- Интерфейс камеры с областью сканирования
- Автоматическое распознавание и возврат данных

### 4. Список покупок
- Перечень препаратов, отмеченных для покупки
- Удобное управление списком

### 5. Настройки
<img width="406" height="1822" alt="Simulator Screenshot - iPhone 16 Pro - 2025-07-28 at 20 37 20" src="https://github.com/user-attachments/assets/ba73ed48-78e3-4358-ba37-973491967635" />

- Управление уведомлениями:
  - Включить/выключить напоминания
  - Настройка периода напоминаний (за сколько дней предупреждать)
- Информация о приложении

---

## 🚀 Планы по развитию
- 📂 **Несколько аптечек** (для дома, дачи, путешествий)
- 🔍 **Дополнительные фильтры и сортировки**
- 🌍 **Локализация** (поддержка новых языков)
- 💊 **База данных лекарств** с подробной информацией

---

## 📲 Как начать пользоваться?
1. Скачайте приложение из App Store (скоро)
2. Добавьте свои лекарства вручную или через сканирование
3. Настройте уведомления в разделе "Настройки"
4. Всегда имейте актуальную информацию о своей аптечке!

---

**PharmMemory — ваш надежный помощник в заботе о здоровье!** 💊❤️
