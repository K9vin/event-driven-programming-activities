# Activity 3: Refactoring Analysis — Tightly Coupled vs Observer Pattern

## 1. Identified Coupling Problems (Step 2)

### Question 1: What happens if we want to add a third display class? Do we have to modify `DataModel`?
**Answer:**  
In the tightly-coupled system, **yes**. `DataModel.setValue()` explicitly instantiates and calls methods on each concrete display class (`new LabelDisplay().showValue(value)` and `new BarChartDisplay().drawBar(value)`). To add a third display (e.g., `TextLogger`), we would have to modify `DataModel.java` directly. This directly violates the **Open-Closed Principle (OCP)** (classes should be open for extension, but closed for modification).

### Question 2: What happens if `LabelDisplay` is deleted or renamed?
**Answer:**  
`DataModel` will fail to compile because it has hard-coded compile-time dependencies on `LabelDisplay` and its specific method `showValue(int)`. Any change, renaming, or refactoring in the presentation tier ripples directly into the domain/data model tier.

### Question 3: Can we easily test `DataModel` in isolation?
**Answer:**  
**No**. Unit testing `DataModel` in isolation is very difficult because it hard-codes calls to concrete UI classes. It cannot be tested with mock objects or test doubles without also running the display logic.

---

## 2. Comparison Table

| Aspect | Tightly Coupled | Observer Pattern |
|---|---|---|
| **Adding a new display** | Modify `DataModel` source code | Just write the class implementing `DataObserver` and register it via `addObserver()` |
| **Testing `DataModel` in isolation** | Hard — requires concrete display classes | Easy — test with mock observers or test assertions directly on `DataSubject` |
| **Removing a display** | Modify `DataModel` source code | Just don't register it, or call `removeObserver()` at runtime |
| **Coupling Level** | Tight (Subject knows concrete observers) | Loose (Subject only knows `DataObserver` interface contract) |
| **Adherence to SOLID** | Violates SRP and OCP | Adheres to Single Responsibility Principle and Open/Closed Principle |
| **Dynamic Configuration** | Static, hardcoded at compile time | Dynamic, observers can register/unregister at runtime |
