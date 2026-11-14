# Sol Invictus

**Build a state. Shape a society. Explore the consequences.**

Sol Invictus is a political, economic, and historical simulation game in early development. Its ambition is to let players experiment with different ways of organizing a society—and explore how political institutions, economic decisions, and population dynamics interact over time.

Our starting point is **Mesopotamia, around 2350 BCE**: the setting for a first prototype that will establish the foundations of a much larger, evolving simulation.

## Create Your Own Policies

Our central ambition is to let players write the policies that govern their nations. Instead of choosing only from predefined options with fixed effects, players will draft their own decrees, laws, policies, and reforms. The planned system will combine AI interpretation with mathematical simulation to evaluate these proposals in the context of the world—letting their consequences emerge from the interaction between each policy and the society it affects.

## A society worth understanding

The vision behind Sol Invictus goes beyond expanding borders. We want the organization of society itself to become part of the game: how a state governs its territories, sustains its population, manages resources, and responds to the consequences of its decisions.

Political and economic systems are intended to interact, giving players room to explore different approaches to government rather than follow a single prescribed path.

This is a long-term project. We will build it incrementally, starting with a small, understandable foundation and expanding its depth as the underlying systems mature.

## The world we are building

### A historical starting point

The initial scenario focuses on Mesopotamia around 2350 BCE. The first map will use **simplified real-world geography**, with room for more detailed geographical data in later versions.

### A world in three dimensions

A 3D map will provide the foundation for exploring the landscape and interacting with territories. Development begins with terrain and a working camera, followed by rivers and selectable regions.

### Territories that can evolve

The initial territorial model will use large regions. Dynamic subdivisions are a longer-term goal, allowing the territorial system to become more detailed as the project develops.

### Politics, economics, and population

The planned simulation brings together institutions, territorial administration, population, and economic activity. These systems will be developed in stages, with an emphasis on making their relationships understandable and their consequences meaningful.

### AI grounded in simulation

Our long-term direction combines **mathematical models and AI**. Mathematical systems will provide the simulation's foundation, while AI may support features such as interpreting player-written policies and decrees.

AI integration is planned for a later stage, after a basic political simulation is working. Its precise role and implementation remain open.

## First milestone

Our first development milestone is deliberately focused:

- Establish the Godot project and repository structure.
- Create a simple 3D terrain with a functional camera.
- Represent the region's major rivers and initial territories.
- Add region selection and a foundation for displaying territorial information.
- Keep geographical data separate from political and simulation logic.

This milestone establishes the map and interaction layer on which later systems can be built. It is not intended to deliver the full political or economic simulation.

## Built to grow

Sol Invictus is being designed around modular systems so that geography, presentation, and simulation can evolve independently.

| Technology             | Intended role                                                    |
|------------------------|------------------------------------------------------------------|
| **Godot 4 / GDScript** | 3D map, camera, interface, interaction, and early prototypes     |
| **C++**                | Computationally demanding simulation systems, when justified     |
| **Python**             | AI experimentation, integration, and analysis tools, when needed |

The current project is configured for **Godot 4.5 with the Forward+ renderer**. C++ and Python are planned tools, not existing integrations.

We will introduce additional technologies when they solve a demonstrated problem and their benefits justify the integration and maintenance costs. Simulation updates will be designed independently of rendering frames.

## Current status

**Initial setup / pre-prototype.**

The repository currently contains the initial Godot project. The playable map, political systems, economic simulation, and AI features described above are planned work, not implemented features.

There is no playable release or announced release date yet. Scope and implementation details may change as prototypes reveal what works.

## Follow the journey

Development is intended to be documented over time, sharing both the game as it takes shape and the technical decisions behind it.

The long-term ambition includes learning from player feedback and exploring opportunities for collaboration. Decisions about public code contributions, licensing, and commercial distribution remain open; this README does not announce an open-source license or a free-to-play model.

Follow the project here: **[Project Sol Invictus](https://github.com/TiagoS4/Project-Sol-Invictus)**.

---

*An ancient setting. An open question: how would you organize a society?*

