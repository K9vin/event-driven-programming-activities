# Comparison of Event Notification Mechanisms in Java

| Feature | Custom Observer | java.util.Observer | PropertyChangeListener | JavaFX Bindings |
|---------|-----------------|--------------------|-----------------------|-----------------|
| **Push or Pull?** | Both possible (flexible design) | Pull | Push (carries old + new value) | Push (reactive observation) |
| **Is it deprecated?** | No | Yes (deprecated in Java 9+) | No | No |
| **Requires inheritance?** | No (interface-based) | Yes (extends `Observable` class) | No (uses composition via `PropertyChangeSupport`) | No (interface/property wrappers) |
| **Thread-safe?** | Developer controls synchronization | No (not thread-safe) | Yes (`PropertyChangeSupport` is thread-safe) | Yes (bound to JavaFX Application Thread) |
| **Auto-generates boilerplate?** | No (implemented manually) | No | Yes (via `PropertyChangeSupport` helper) | Yes (built-in bindings & expressions) |
| **Best for...** | Domain-specific systems & microservices | Legacy Java code | JavaBeans, Swing, desktop desktop data models | JavaFX desktop & mobile applications |
| **Can have multiple listeners?** | Yes | Yes | Yes | Yes |
| **Can be typed to send any data?** | Yes (custom signatures/generics) | No (untyped `Object`, needs cast) | Yes (`PropertyChangeEvent` carries typed values) | Yes (strongly typed properties: `StringProperty`, `IntegerProperty`, etc.) |
| **Recommended today?** | **Yes** | **No** | Only for Swing / JavaBeans | **Yes** |

---

## Which One Should You Use?

- For a **plain Java project with custom needs** → **Custom Observer** (clean, zero external dependencies, strongly typed)
- For a **JavaFX application** → **JavaFX Bindings / ObservableValue** (modern, declarative, highly optimized)
- For **legacy code using JavaBeans / Swing** → **PropertyChangeListener** (built into `java.beans`, handles old vs new states)
- **Never** → **`java.util.Observer` / `Observable`** (deprecated, rigid single-inheritance class design)

---

## Self-Check Answers

1. **Which mechanism carries both the old and new value of a property?**  
   `PropertyChangeListener` (via `PropertyChangeEvent.getOldValue()` and `PropertyChangeEvent.getNewValue()`).

2. **Which mechanism requires a helper class to manage the listener list?**  
   `PropertyChangeListener` (commonly uses `java.beans.PropertyChangeSupport` to manage thread-safe listener lists and fire events).

3. **Which two mechanisms are recommended for modern Java?**  
   Custom Observer (interface-based) and JavaFX Properties/Bindings (or Reactive Streams via `java.util.concurrent.Flow`).

4. **Which mechanism is deprecated and should be avoided?**  
   `java.util.Observer` and `java.util.Observable` (deprecated since Java 9).
