# flutter_bloc_cubit_clean_arch

### Flutter, BLoC/Cubit, Clean Architecture
  
https://github.com/user-attachments/assets/6c19dda7-ddfd-42b0-a61d-3ddb867dd945  
  
**Застосунок світлофор логіка:**  
   
1. ✅ зроблено  
   Цикл:  
   Червоний → 3 секунди  
   Жовтий → 1 секунда  
   Зелений → 3 секунди  
   Жовтий → 1 секунда   
   Повторення  
  
2. ✅  
   Користувач має кнопку "Старт / Стоп", щоб вмикати/вимикати світлофор.  

3. ✅  
   Усі дані про тривалість сигналів повинні приходити з репозиторію (mock).  

4. ✅  
   Стейт-менеджмент — Bloc / Cubit.  
 
5. ✅  
   Архітектура — Clean Architecture (Domain, Data, Presentation).   
   **Architecting Flutter apps** [https://docs.flutter.dev/app-architecture/guide](https://docs.flutter.dev/app-architecture/guide)  
  
**Вимоги**  
🔹 Шари проєкту - ✅ зроблено  
   
Domain  
✅ Enum: `TrafficLight` { red, yellow, green }  
`lib/domain/traffic_light_domain.dart`

Data  
✅ UseCase: `Duration getLightDuration(TrafficLight color)`  
✅ Repository Interface: `TrafficLightRepository`  
✅ Mock Implementation: `MockTrafficLightRepository` (повертає послідовність і тривалості для кольорів)  
`lib/repository/traffic_light_repository.dart`  
  
Presentation  
✅ Cubit / Bloc: `TrafficLightCubit`  
`lib/state/traffic_light_state.dart`  
✅ State: `TrafficLightState` (поточний колір + статус роботи)  
`lib/state/traffic_light_state.dart`  
✅ UI: `TrafficLightsPage` з 3 кружечками та кнопкою "Старт/Стоп".  
`lib/ui_presentation/traffic_lights_page_details.dart`

🔹 Логіка - ✅ зроблено  
  
- ✅ Цикл перемикання кольорів реалізується в Cubit - використано `Timer` i `Stopwatch` з `dart:async`.  
- ✅ Послідовність (sequence) кольорів/сигналів запитується з репозиторію.Тривалості кольорів запитуються з репозиторію.  
- ✅ Коли користувач натискає "Стоп" → цикл переривається.  
  
🔹 Тести  
  
- ✅ Unit-тести для Cubit (мінімум перевірка зміни станів).  
  `test/traffic_light_bloc_test.dart`  
- ✅ Тест для use case (переконатися, що тривалість дістається з репозиторію).  
  `test/traffic_light_repository_test.dart`  
  
**Додатково (опційно)**  
  
- ✅ Використати freezed для автогенерації коду класу `state management`'a (`TrafficLightState`).  
- ✅ Зробити "режим миготіння жовтого" (окремий use case).  
