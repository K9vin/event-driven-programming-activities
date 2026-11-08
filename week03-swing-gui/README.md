# Week 3: Building GUI Applications with Swing

This directory contains the completed activities for Week 3 of Event-Driven Programming in Java.

---

## Directory Structure

```
week03-swing-gui/
├── activity1-first-window/
│   └── FirstWindow.java          # Basic JFrame window on EDT
├── activity2-basic-components/
│   └── ComponentShowcase.java    # Tour of major Swing components
├── activity3-layout-managers/
│   ├── FlowLayoutDemo.java       # FlowLayout demonstration
│   ├── BorderLayoutDemo.java     # BorderLayout (5 regions)
│   ├── GridLayoutDemo.java       # GridLayout (Calculator 4x4 keypad)
│   └── CombinedLayoutDemo.java   # Real-world nested layout app shell
├── activity4-edt-rule/
│   ├── FreezeDemo.java           # Bad practice: blocking EDT freezes UI
│   └── FixedDemo.java            # Good practice: background thread + invokeLater
└── activity5-complete-mockup/
    └── StudentPortal.java        # Polished Student Portal Dashboard mockup
```

---

## How to Compile and Run

Make sure your JDK is configured (Java 17+ or Temurin 25):

### Activity 1: First Window
```powershell
cd activity1-first-window
javac FirstWindow.java
java FirstWindow
```

### Activity 2: Component Showcase
```powershell
cd ../activity2-basic-components
javac ComponentShowcase.java
java ComponentShowcase
```

### Activity 3: Layout Managers
```powershell
cd ../activity3-layout-managers
javac FlowLayoutDemo.java && java FlowLayoutDemo
javac BorderLayoutDemo.java && java BorderLayoutDemo
javac GridLayoutDemo.java && java GridLayoutDemo
javac CombinedLayoutDemo.java && java CombinedLayoutDemo
```

### Activity 4: EDT Rule Demonstration
```powershell
cd ../activity4-edt-rule
javac FreezeDemo.java && java FreezeDemo
javac FixedDemo.java && java FixedDemo
```

### Activity 5: Complete Student Portal Mockup
```powershell
cd ../activity5-complete-mockup
javac StudentPortal.java
java StudentPortal
```

---

## Key Concepts & EDT Golden Rules

1. **Rule 1:** All Swing GUI creation and updates must happen on the Event Dispatch Thread (EDT) using `SwingUtilities.invokeLater()`.
2. **Rule 2:** Never execute long-running or blocking operations (`Thread.sleep()`, file I/O, network requests) on the EDT. Run them in a background worker thread and post UI updates back to the EDT via `SwingUtilities.invokeLater()`.
