# Limitations of java.util.Observer and java.util.Observable

## Limitation 1: Single Inheritance
**Explain:** Why is it a problem that `Observable` is a CLASS, not an INTERFACE?  
**Your answer:**  
Java supports single class inheritance only. Because `java.util.Observable` is a concrete class rather than an interface, any class that wishes to act as an observable subject must inherit directly from `Observable`. If a subject class already needs to extend another domain class (such as `Thread`, `JPanel`, or an existing business entity class like `Device`), it is impossible to do so. This severely limits architectural reuse and violates good object-oriented design principles (composition and interfaces over inheritance).

## Limitation 2: Cannot Change the Notification Order
**Explain:** In what order are observers notified? Can you control this?  
**Your answer:**  
The legacy `Observable` implementation does not guarantee a predictable notification order. Internally, `Vector` was used, and notifications often iterated in reverse order or arbitrary order. The client code cannot specify, prioritize, or configure the sequence in which registered observers are invoked. In complex event-driven applications where certain observers must process events before others, this lack of control can introduce subtle, hard-to-debug ordering bugs.

## Limitation 3: setChanged() is Confusing
**Explain:** Why must you call `setChanged()` before `notifyObservers()`?  
**Your answer:**  
`Observable` maintains an internal boolean flag (`changed`). `notifyObservers()` checks whether `hasChanged()` is `true`; if it is `false`, `notifyObservers()` silently does nothing and returns without notifying any observers. Therefore, developers are forced to manually invoke `setChanged()` before triggering notifications. This is a common pitfall: forgetting `setChanged()` causes silent failures with no compiler warning or runtime exception. Furthermore, `setChanged()` is protected, making it difficult to trigger notifications via delegation or composition without subclassing.

## Limitation 4: Pull Model by Default
**Explain:** How does the observer get the data? Is this efficient?  
**Your answer:**  
In the default `notifyObservers()` invocation without parameters, the observer's `update(Observable o, Object arg)` method receives `null` for `arg`. Consequently, the observer must:
1. Perform type-checking and type-casting on `o` (e.g., `if (o instanceof LegacyWeatherData) data = (LegacyWeatherData) o;`).
2. Make explicit getter calls to pull each piece of data it needs.

This is less efficient and tightly couples the observer to the subject's concrete getter API. It also risks observing inconsistent state if multiple values are being pulled while other threads mutate the subject.

## Limitation 5: Deprecated Since Java 9
**Explain:** Why did Java deprecate these classes?  
**Your answer:**  
Java 9 officially marked `java.util.Observer` and `java.util.Observable` as `@Deprecated` because:
- The design was flawed (class instead of interface, single inheritance lock-in).
- They lack generic type safety (taking `Object` and requiring runtime casts).
- They provide poor concurrency and lack fine-grained thread safety.
- They fail to meet modern reactive and event-driven architectural needs. Modern alternatives like `java.beans.PropertyChangeListener`, custom interfaces, and reactive streams (e.g., `java.util.concurrent.Flow`) provide vastly superior flexibility and safety.

---

## Self-Check Answers

### 1. Why can't you extend another class if you already extend `Observable`?
Java does not support multiple inheritance of classes. Once a class extends `Observable`, its single inheritance slot is consumed, preventing it from extending any other superclass.

### 2. What is the difference between the push model and the pull model?
- **Push Model:** The Subject bundles the updated state data directly into the notification method arguments (e.g., `update(temperature, humidity, pressure)`). Observers immediately receive what they need without having to ask.
- **Pull Model:** The Subject merely notifies observers that a change took place, passing a reference to itself or minimal context. Observers must query (pull) the required data from the Subject using public getter methods.

### 3. Why did Java deprecate these classes?
They were deprecated in Java 9 because `Observable` is an inflexible class rather than an interface, lacks generics/type safety, enforces an unconfigurable notification order, requires error-prone state flags (`setChanged()`), and is unsuited for modern concurrent and reactive programming.
