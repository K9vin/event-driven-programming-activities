# Activity 5: Final Self-Assessment & Reflection

## Learning Outcome 1: Design and Implement the Observer Pattern

### 1. Draw the UML diagram of the Observer pattern. Label Subject, Observer, ConcreteSubject, ConcreteObserver.
```
         <<interface>>                                   <<interface>>
          +-----------------------+                       +-------------------+
          |        Subject        |                       |     Observer      |
          +-----------------------+                       +-------------------+
          | + registerObserver(o) |<>-------------------->| + update(...)     |
          | + removeObserver(o)   |        notifies       +-------------------+
          | + notifyObservers()   |                                 ^
          +-----------------------+                                 |
                      ^                                             | implements
                      | implements                                  |
          +-----------------------+                       +-------------------+
          |    ConcreteSubject    |                       | ConcreteObserver  |
          |     (WeatherData)     |                       | (CurrentDisplay)  |
          +-----------------------+                       +-------------------+
          | - observers: List     |                       | + update(...)     |
          | - state               |                       +-------------------+
          +-----------------------+
          | + getState()          |
          | + setState()          |
          +-----------------------+
```

### 2. Write the Java code for a `Subject` interface.
```java
public interface Subject {
    void registerObserver(Observer o);
    void removeObserver(Observer o);
    void notifyObservers();
}
```

### 3. Why does the Subject need a list of observers?
Because the Observer pattern establishes a one-to-many relationship. A single Subject can notify multiple independent observers (zero, one, or many) at runtime. An internal data structure such as `List<Observer>` allows dynamic registration (`registerObserver`) and deregistration (`removeObserver`), and enables iterating through all active subscribers when notifying them.

---

## Learning Outcome 2: Evaluate Legacy `java.util.Observer`

### 4. List three problems with `java.util.Observable`.
1. **Single Inheritance Limitation:** `Observable` is a concrete class, not an interface. A class extending `Observable` cannot extend any other superclass.
2. **Confusing and Error-Prone Flag (`setChanged()`):** Observers will silently fail to receive notifications if `setChanged()` is not called before `notifyObservers()`.
3. **Lack of Type Safety:** The `update(Observable o, Object arg)` method passes `Object`, requiring fragile runtime type casting and instanceof checks.

### 5. Why was this API deprecated?
It was deprecated in Java 9 because it has poor extensibility (class instead of interface), does not support generic typing, does not support serializability or predictable ordering, lacks modern concurrency support, and fails to handle modern reactive event streams cleanly.

### 6. What is the "pull model" and why is it harder to use?
In the pull model, the Subject does not provide updated state values within the notification parameters; it merely informs observers that an update occurred. The observers must then pull the state by calling getter methods on the Subject. This is harder to use because:
- Observers must maintain a reference to the concrete Subject and know its API.
- Observers risk fetching inconsistent or partially updated state in concurrent multi-threaded environments.
- Extra method invocations and boilerplate type casts are required.

---

## Learning Outcome 3: Create a Custom Event Notification System

### 7. What methods must a custom Subject interface provide?
At minimum, three core lifecycle methods:
- `registerObserver(Observer o)` (or `addObserver`): To subscribe a new observer.
- `removeObserver(Observer o)`: To unsubscribe an existing observer.
- `notifyObservers()`: To broadcast changes to all subscribed observers.

### 8. How does the Subject notify all observers?
The Subject iterates over its collection of registered observers (e.g., using an enhanced `for` loop or `forEach`) and invokes each observer's `update()` method, passing either the new state data (push model) or a change event context.

### 9. How do you prevent a memory leak when observers are no longer needed?
By always deregistering observers using `removeObserver(o)` when they are destroyed or disposed of (the "Lapsed Listener Problem"). If observers are not removed, the Subject retains strong references to them in its list, preventing the garbage collector from reclaiming their memory even when the observer UI/components are no longer in use. Alternatively, `WeakReference` collections can be used where applicable.

---

## Learning Outcome 4: Compare Different Mechanisms

### 10. Name four event notification mechanisms in Java.
1. Custom Observer Pattern (Interface-based)
2. Legacy `java.util.Observer` / `java.util.Observable` (Deprecated)
3. JavaBeans `PropertyChangeListener` / `PropertyChangeSupport`
4. JavaFX Properties and Bindings (`ObservableValue`, `ChangeListener`, `binding`)

### 11. Which one is best for JavaFX?
**JavaFX Properties and Bindings** (`javafx.beans.property.*`), as they are native to the JavaFX architecture, support automatic UI synchronization, high-performance invalidation listeners, and bidirectional data binding.

### 12. Which one is deprecated?
**`java.util.Observer` and `java.util.Observable`** (deprecated since Java 9).

---

## Self-Score

- **Total Score:** 12 / 12 (100% — Excellent: Mastered the Observer Pattern)

---

## Final Reflection

The Observer pattern is a foundational behavioral design pattern that defines a one-to-many dependency between objects, ensuring that when one object changes state, all its dependents are automatically notified and updated. It is essential to modern software engineering because it enforces loose coupling: subjects and observers interact through abstract interfaces without knowing each other's concrete implementations or internal representations. In event-driven programming, the Observer pattern forms the architectural bedrock; events act as state change notifications, event sources act as subjects, and event listeners act as concrete observers. 

For modern Java applications, I would choose a custom interface-based Observer pattern for backend business logic because it provides strong typing, zero framework overhead, and complete architectural flexibility. When developing desktop user interfaces, I would leverage JavaFX Properties and Bindings (or `PropertyChangeListener` in Swing) because they provide robust, production-tested infrastructure for thread-safe property synchronization and UI event propagation.
