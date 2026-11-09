# Week 2: The Observer Pattern — Self-Paced Practical Guide

This directory contains the completed practical activities for Week 2 of Event-Driven Programming in Java, covering the design, implementation, evaluation, and refactoring of the Observer Pattern.

---

## Directory Structure

```
week02-observer-pattern/
├── README.md                           # Master documentation and run guide
├── SelfAssessment.md                   # Activity 5: Final self-assessment and reflection
├── activity1-weather-station/          # Activity 1: Custom Observer Pattern from scratch
│   ├── Observer.java                   # Observer interface (push model)
│   ├── Subject.java                    # Subject interface
│   ├── WeatherData.java                # Concrete subject
│   ├── CurrentConditionsDisplay.java   # Concrete display observer
│   ├── StatisticsDisplay.java          # Concrete statistics observer
│   ├── ForecastDisplay.java            # Concrete forecast observer
│   └── WeatherStationMain.java         # Driver class demonstrating registration and updates
├── activity2-legacy-observer/          # Activity 2: Legacy java.util.Observer (deprecated)
│   ├── LegacyWeatherData.java          # Observable subclass
│   ├── LegacyDisplay.java              # java.util.Observer implementation
│   ├── LegacyMain.java                 # Demonstration of legacy pull model
│   └── LegacyLimitations.md            # Detailed analysis of 5 major limitations & deprecation
├── activity3-custom-observer/          # Activity 3: Refactoring tightly coupled system
│   ├── TightlyCoupledSystem.java       # Initial tightly-coupled implementation (before)
│   ├── DataObserver.java               # Custom observer interface
│   ├── DataSubject.java                # Custom subject interface
│   ├── DataModel.java                  # Loosely coupled model (after)
│   ├── LabelDisplay.java               # Refactored display observer
│   ├── BarChartDisplay.java            # Refactored bar chart observer
│   ├── TextLogger.java                 # New observer proving Open/Closed principle
│   ├── RefactoredMain.java             # Driver class demonstrating refactored system
│   └── RefactoringAnalysis.md          # Architectural comparison and SOLID analysis
└── activity4-comparison/               # Activity 4: Notification mechanisms comparison
    ├── PropertyChangeDemo.java         # java.beans.PropertyChangeListener implementation
    └── Comparison.md                   # Feature comparison table across 4 Java mechanisms
```

---

## How to Compile and Run

Make sure your JDK is configured (Java 17+ / OpenJDK 25):

### Activity 1: Custom Weather Station
```powershell
cd activity1-weather-station
javac *.java
java WeatherStationMain
```

### Activity 2: Legacy Observer & Observable
```powershell
cd ../activity2-legacy-observer
javac *.java
java LegacyMain
```

### Activity 3: Refactored Custom Observer
```powershell
cd ../activity3-custom-observer
javac *.java
# Run original tightly-coupled version:
java TightlyCoupledSystem
# Run decoupled Observer version:
java RefactoredMain
```

### Activity 4: PropertyChangeListener Demo
```powershell
cd ../activity4-comparison
javac PropertyChangeDemo.java
java PropertyChangeDemo
```

---

## Summary of Completed Activities

| Activity | Topic | Key Deliverables | Status |
|---|---|---|---|
| **1. Weather Station** | Design & implement Observer pattern from scratch | 6 Java files + Driver | Completed & Verified |
| **2. Legacy Observer** | Evaluate deprecated `java.util.Observer` | 3 Java files + `LegacyLimitations.md` | Completed & Verified |
| **3. Refactoring Exercise** | Decouple tightly coupled UI & domain model | 8 Java files + `RefactoringAnalysis.md` | Completed & Verified |
| **4. Comparison** | Compare 4 Java notification mechanisms | `PropertyChangeDemo.java` + `Comparison.md` | Completed & Verified |
| **5. Assessment** | Master Observer pattern and event-driven concepts | `SelfAssessment.md` (12/12 score + Reflection) | Completed & Verified |

---

## Key Concepts & Architectural Takeaways

1. **Loose Coupling:** The Subject only knows that its observers implement the `Observer` interface; it does not depend on their concrete classes. New observers can be added without modifying a single line of code in the Subject (Open/Closed Principle).
2. **Push vs. Pull:**
   - **Push Model:** The Subject sends detailed state information in the notification parameter (`update(temp, humidity, pressure)`).
   - **Pull Model:** The Subject sends only itself or a generic notification; the Observer queries the Subject's getters to retrieve the required data.
3. **Avoid Deprecated APIs:** Never use `java.util.Observer` or `java.util.Observable` in modern Java. Prefer custom typed interfaces, `java.beans.PropertyChangeListener`, or JavaFX Properties / Reactive Streams (`java.util.concurrent.Flow`).
4. **Preventing Memory Leaks:** Always deregister listeners (`removeObserver`) when an observer is destroyed to prevent the "Lapsed Listener Problem".
