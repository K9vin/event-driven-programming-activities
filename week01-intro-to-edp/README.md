# Week 1: Introduction to Event-Driven Programming — Self-Paced Practical Guide

This directory contains the completed practical activities for Week 1 of Event-Driven Programming in Java, covering fundamental EDP concepts (Event, Source, Listener, Handler), paradigm comparisons (procedural vs. event-driven), the event loop and Event Dispatch Thread (EDT), code debugging, and event-driven system architecture design.

---

## Directory Structure

```text
week01-intro-to-edp/
├── README.md                           # Master documentation and guide
├── SelfAssessment.md                   # Activity 6: Final self-assessment (15/15, 100%)
├── activity1-scavenger-hunt/           # Activity 1: Spot the Components (Scavenger Hunt)
│   └── README.md                       # 14 real-world systems analyzed & self-check questions
├── activity2-event-loop/               # Activity 2: Build the Event Loop (Physical Simulation)
│   └── README.md                       # Round 3 analysis, blocking hazards, and reflection
├── activity3-calculators/              # Activity 3: Procedural vs. Event-Driven Side-by-Side
│   ├── procedural/
│   │   └── ProceduralCalculator.java   # Step-by-step sequential console calculator
│   ├── eventdriven/
│   │   └── EventDrivenCalculator.java  # Interactive Java Swing event-driven calculator
│   └── Comparison.md                   # Paradigm comparison matrix and reflection
├── activity4-code-repair/              # Activity 4: Debug the Event Handler Challenge
│   ├── Bug1_BlockingEDT.java           # Fixed: Offloaded 5s blocking task to background worker thread
│   ├── Bug2_MissingListener.java       # Fixed: Added registered ActionListener to increment button
│   ├── Bug3_WrongThread.java           # Fixed: Dispatched GUI mutations to EDT via SwingUtilities.invokeLater
│   ├── Bug4_MemoryLeak.java            # Fixed: Cleared strong references in collection on UI component removal
│   └── BugFixes.md                     # Detailed bug fix documentation
├── activity5-system-design/            # Activity 5: Design Your Own Event-Driven System
│   ├── SystemDesign.md                 # Smart Home Controller (IoT Edge Hub) worksheet (Parts 1–5)
│   └── SmartHomePrototype.java         # Full working Java Swing prototype
└── activity6-self-assessment/          # Activity 6: Self-Assessment & Summary
    └── README.md                       # Comprehensive one-page summary & key architectural patterns
```

---

## How to Compile and Run

Make sure your JDK is configured (Java 17+ / OpenJDK 25):

### Activity 3: Side-by-Side Calculators

#### Procedural Calculator:
```powershell
cd activity3-calculators\procedural
javac ProceduralCalculator.java
java ProceduralCalculator
```

#### Event-Driven Calculator:
```powershell
cd activity3-calculators\eventdriven
javac EventDrivenCalculator.java
java EventDrivenCalculator
```

---

### Activity 4: Fixed Bug Challenges

```powershell
cd activity4-code-repair
javac *.java

# Run Bug 1 fix (Non-blocking EDT)
java Bug1_BlockingEDT

# Run Bug 2 fix (Increment listener)
java Bug2_MissingListener

# Run Bug 3 fix (Thread-safe clock)
java Bug3_WrongThread

# Run Bug 4 fix (Memory leak prevention)
java Bug4_MemoryLeak
```

---

### Activity 5: Smart Home Controller Prototype

```powershell
cd activity5-system-design
javac SmartHomePrototype.java
java SmartHomePrototype
```

---

## Deliverables Summary

| Activity | Topic / Task | Deliverable | Status |
|---|---|---|---|
| **Activity 1** | Real-World EDP Scavenger Hunt | [activity1-scavenger-hunt/README.md](activity1-scavenger-hunt/README.md) | Completed |
| **Activity 2** | Event Loop Physical Simulation | [activity2-event-loop/README.md](activity2-event-loop/README.md) | Completed |
| **Activity 3** | Procedural vs Event-Driven Calculators | [activity3-calculators/Comparison.md](activity3-calculators/Comparison.md) | Completed |
| **Activity 4** | Code Repair Challenge (4 Fixed Java files) | [activity4-code-repair/BugFixes.md](activity4-code-repair/BugFixes.md) | Completed |
| **Activity 5** | Smart Home Controller Design & Prototype | [activity5-system-design/SmartHomePrototype.java](activity5-system-design/SmartHomePrototype.java) | Completed |
| **Activity 6** | Self-Assessment & 1-Page Summary | [SelfAssessment.md](SelfAssessment.md) | Completed |
