# Week 10 Final Project: University Management System

Capstone implementation for the **Event-Driven Programming (EDP)** curriculum in Java. This is the end-to-end project that combines every technique from Weeks 1-8 into a database-driven JavaFX application.

---

## Learning Outcomes

| Outcome | Where it lives |
|---|---|
| **LO1: EDA Principles (Separation)** | `DatabaseUtil` + `LoadStudentsTask` own all SQL; the UI and controllers never open a JDBC connection on the FX thread. |
| **LO2: Producer-Consumer (Background Tasks)** | `LoadStudentsTask` and the save task in `StudentController` extend `javafx.concurrent.Task`; results return to the UI through `setOnSucceeded` / `setOnFailed`. |
| **LO3: Scheduled Tasks (Auto-Refresh)** | `App` runs a `ScheduledExecutorService` heartbeat every 5 seconds and shuts it down when the window closes. |
| **LO4: Event Communication (Decoupling)** | FXML `onAction` handlers, `ObservableList` + `TableView` cell value factories, and `disableProperty().bind(...)` validation. |

---

## Directory Structure

```text
week10-final-project-university-system/
├── pom.xml                                  # JavaFX 21, FXML, MySQL Connector/J
├── README.md
├── database/
│   └── schema.sql                           # university_db tables + sample rows
└── src/
    └── main/
        ├── java/com/university/
        │   ├── App.java                     # Application + 5-second scheduler (LO3)
        │   ├── DatabaseUtil.java            # JDBC connection factory (LO1)
        │   ├── Student.java                 # Observable data model (Week 8)
        │   ├── LoadStudentsTask.java        # Background SELECT task (LO2)
        │   ├── MainController.java          # Sidebar navigation
        │   └── StudentController.java       # Save/load events + validation bindings
        └── resources/com/university/
            ├── MainView.fxml                # BorderPane shell with sidebar
            └── StudentView.fxml             # Form + TableView + status label
```

---

## Phase Map (handout → code)

| Handout phase | File |
|---|---|
| 1. Database | `database/schema.sql` |
| 2. Project setup | `pom.xml` |
| 3. Database connection | `DatabaseUtil.java` |
| 4. Data model | `Student.java` |
| 5. Background task | `LoadStudentsTask.java` |
| 6. Student UI | `StudentView.fxml` |
| 7. Controller | `StudentController.java` |
| 8. Main application | `App.java` |
| 9. Navigation | `MainView.fxml`, `MainController.java` |
| 10. Run and test | see below |

---

## Setup

### 1. Create the database

Open **MySQL Workbench** and run [`database/schema.sql`](database/schema.sql). It creates `university_db`, the `programs` and `students` tables, and two sample students.

### 2. Set your password

Edit [`src/main/java/com/university/DatabaseUtil.java`](src/main/java/com/university/DatabaseUtil.java) and replace `your_password` with your local MySQL root password.

### 3. Build and run

With Maven installed:

```powershell
cd week10-final-project-university-system
mvn clean javafx:run
```

Without Maven (PowerShell + JDK 17+), compile against the JavaFX and MySQL jars already in your local repository:

```powershell
$jfxMods = (Get-ChildItem -Path "$HOME\.m2\repository\org\openjfx" -Filter "*-win.jar" -Recurse | Select-Object -ExpandProperty FullName) -join ";"
$mysqlJar = "$HOME\.m2\repository\com\mysql\mysql-connector-j\8.3.0\mysql-connector-j-8.3.0.jar"

New-Item -ItemType Directory -Force target\classes | Out-Null
Copy-Item src\main\resources\com target\classes -Recurse -Force

javac --module-path $jfxMods --add-modules javafx.controls,javafx.fxml `
      -cp $mysqlJar -d target\classes `
      (Get-ChildItem src\main\java\com\university\*.java | Select-Object -ExpandProperty FullName)

java --module-path $jfxMods --add-modules javafx.controls,javafx.fxml `
     -cp "target\classes;$mysqlJar" com.university.App
```

If the MySQL connector is not in your local repository, download `mysql-connector-j-8.3.0.jar` from Maven Central or let Maven resolve it.

---

## Testing Checklist (Handout Phase 10)

- [ ] App opens with the dark sidebar on the left.
- [ ] Clicking **Students** loads `StudentView` in the centre pane.
- [ ] The table shows any rows already in `students`.
- [ ] **Save Student** stays disabled until reg number, first name, and last name are all filled (Week 8 binding).
- [ ] Saving inserts the row, shows "Student saved successfully!", clears the fields, and refreshes the table without freezing the UI.
- [ ] The console prints `System Heartbeat: Checking for updates at ...` every 5 seconds.
- [ ] Closing the window stops the scheduler, so the JVM exits instead of printing heartbeats forever.

---

## Fixes Applied to the Handout Code

1. **FXML layout import:** `StudentView.fxml` uses `<HBox>` but the handout only imported `javafx.scene.layout.VBox`. The views here import `javafx.scene.layout.*`, so the loader does not fail with `ClassNotFoundException: javafx.scene.layout.HBox`.
2. **Scheduler shutdown:** the handout notes that the non-daemon scheduler thread keeps the JVM alive after the window closes. `App` calls `scheduler.shutdownNow()` from `setOnCloseRequest`.
3. **Background task failures:** both the load and save tasks register `setOnFailed`, so a missing database, wrong password, or duplicate registration number is reported in the status label instead of failing silently on a background thread.
4. **Field hygiene:** inputs are trimmed before insert, and the generated email uses the trimmed registration number so `reg + "@university.edu"` stays consistent with the `UNIQUE` constraints.
