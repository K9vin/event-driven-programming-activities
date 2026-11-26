# Week 9: Asynchronous Programming in JavaFX

Practical implementation guide and lab solutions for Week 9 of the **Event-Driven Programming (EDP)** curriculum in Java.

---

## Overview

This module covers keeping a JavaFX interface responsive while heavy work happens off the UI thread. Every event handler in JavaFX runs on the **JavaFX Application Thread**, so any long operation placed there freezes the entire window — no repainting, no resizing, no clicks. The activities build from that failure mode to the idiomatic fixes: `Task`, `Service`, and property-based progress reporting.

### Key Concepts

1. **The JavaFX Application Thread:** The single thread that processes input events and renders the scene graph. Blocking it makes the application appear hung.
2. **`Task<V>`:** A one-shot unit of work with `call()` executed on a background thread and built-in `progressProperty()` / `messageProperty()` that are safe to update via `updateProgress()` and `updateMessage()`.
3. **`Service<V>`:** A reusable wrapper around a `Task` that supports `start()`, `restart()`, and `cancel()`, for operations that must run repeatedly (e.g. "Refresh" buttons).
4. **Thread-safe UI updates:** `setOnSucceeded` / `setOnFailed` / `setOnCancelled` handlers run on the FX thread and may touch controls directly; code inside `call()` runs on the background thread and must use `Platform.runLater()` if it needs the UI.

---

## Directory Structure

```text
week09-async-javafx/
├── pom.xml                  # Maven configuration with JavaFX 21 (mainClass is overridable)
├── README.md                # Complete activity documentation and solutions
└── src/
    └── main/
        └── java/
            └── com/
                └── example/
                    ├── FreezeDemo.java    # Activity 1: blocking the UI thread
                    ├── TaskDemo.java      # Activity 2: Task + safe completion handling
                    ├── ProgressDemo.java  # Activity 3: progress bar bound to Task properties
                    └── ServiceDemo.java   # Activity 4: restartable/cancellable Service
```

---

## Activities & Code Walkthrough

### Activity 1: The Freeze (LO1)
- **File:** `FreezeDemo.java` — **Title:** *The Freeze Demo*
- **Description:** `Thread.sleep(5000)` is called directly inside `freezeButton.setOnAction(...)`. Because the handler runs on the FX thread, the window cannot be moved, resized, or repainted for five seconds.
- **What to observe:** click the button, then try dragging the window. It is unresponsive until the label changes to "Done!".

### Activity 2: The Fix (LO2, LO3)
- **File:** `TaskDemo.java` — **Title:** *Task Demo - The Fix*
- **Description:** The sleep is moved into a `Task.call()`, which executes on a new background thread, and `new Thread(task).start()` begins it. The button is disabled while work is in flight, so a second click cannot start a duplicate task.
- **Note on the handout's code:** the printed version calls `startButton.setEnabled(...)`, which does not exist on JavaFX `Button` (that method belongs to Swing). The solution here uses `setDisable(true)` / `setDisable(false)`.
- **Note on `Platform.runLater()`:** the handout wraps the `setOnSucceeded` body in `Platform.runLater()`. That works but is redundant — completion handlers are already invoked on the FX thread. It is only *required* when updating the UI from inside `call()`.

### Activity 3: Live Progress (LO4)
- **File:** `ProgressDemo.java` — **Title:** *Progress Bar Demo*
- **Description:** `Task.updateProgress(i, 100)` and `updateMessage(...)` are called from the background loop, while the bar and label are bound to the task's properties:
  ```java
  progressBar.progressProperty().bind(downloadTask.progressProperty());
  statusLabel.textProperty().bind(downloadTask.messageProperty());
  ```
  On success the label is unbound before setting a final message — setting a bound property throws.
- **Note:** again, `setEnabled` in the handout is replaced with `setDisable`.

### Activity 4: The Service Class (Capstone)
- **File:** `ServiceDemo.java` — **Title:** *Service Demo*
- **Description:** `DataSyncService extends Service<String>` and builds a new `Task` in `createTask()`. The UI can call `restart()` any number of times and `cancel()` mid-flight; the task's loop checks `isCancelled()` and exits promptly. An indeterminate `ProgressIndicator` doubles as a "working" spinner.

---

## Self-Check Questions & Answers

### Activity 1
- **Q1: Why did the window freeze for 5 seconds?**
  - **A:** `Thread.sleep(5000)` ran on the JavaFX Application Thread. That thread processes all input and rendering events, so it could not handle anything — including repainting — until the sleep finished.

### Activity 2
- **Q1: Why did we use `Platform.runLater()` inside `setOnSucceeded`?**
  - **A:** The handout's answer is "because `setOnSucceeded` runs on the background thread". That premise is incorrect — `setOnSucceeded` and the other completion handlers run on the FX thread, so the call is redundant. `Platform.runLater()` is needed only for UI updates made inside `call()`.

### Activity 3
- **Q1: What is the difference between `updateProgress()` and `Platform.runLater()`?**
  - **A:** `updateProgress()` updates the task's built-in property, which JavaFX batches and publishes to the UI thread efficiently. `Platform.runLater()` submits an arbitrary `Runnable` to the FX thread's queue. For progress reporting, `updateProgress()` / `updateMessage()` are preferred.
- **Q2: Why did we call `statusLabel.textProperty().unbind()` at the end?**
  - **A:** The label was bound to the task's message property. Assigning to a bound property throws `A bound value cannot be set`, so the binding must be removed first.

### Activity 4
- **Q1: What is the main difference between `Task` and `Service`?**
  - **A:** A `Task` can only be started once. A `Service` creates a fresh `Task` each time and can be restarted or cancelled repeatedly, which suits reusable operations like "Sync".
- **Q2: How do you check inside `call()` whether the user clicked "Cancel"?**
  - **A:** With `isCancelled()`. The loop breaks when it returns `true`, so the background thread stops working instead of running to completion.

---

## How to Build and Run

### Prerequisites
- JDK 17+ (built and verified with Temurin 21)
- Maven 3.9+

### Compile
```powershell
mvn -B -DskipTests package
```

### Run Activities
The default `javafx.mainClass` is `TaskDemo`. Any activity can be selected on the command line without editing the pom:

```powershell
mvn javafx:run                                                   # TaskDemo (default)
mvn javafx:run -Djavafx.mainClass=com.example.FreezeDemo         # Activity 1
mvn javafx:run -Djavafx.mainClass=com.example.ProgressDemo       # Activity 3
mvn javafx:run -Djavafx.mainClass=com.example.ServiceDemo        # Activity 4
```

---

## Learning Outcomes Checklist

- [x] **Outcome 1:** Identify operations that freeze the UI (`FreezeDemo.java`)
- [x] **Outcome 2:** Implement background work with `Task` and `Service` (`TaskDemo.java`, `ServiceDemo.java`)
- [x] **Outcome 3:** Update the UI safely from background threads (`TaskDemo.java`)
- [x] **Outcome 4:** Provide real-time progress feedback with bound properties (`ProgressDemo.java`)
