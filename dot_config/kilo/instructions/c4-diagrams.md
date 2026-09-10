For architecture diagrams use C4 models. Do not try to create them yourself, I'll draw them in Gaphor.

- Every box lists **Name**, **Description**, and **Type** (Person, Software system, Deployment node, Container, Component, Supporting software system, etc.).
- Put **technology on the element**

## Arrangement

- State **containment** explicitly: what lives inside what (e.g. *Conda contains Command-Line Interface*).
- Prefer **DeepWiki** container names for conda core: Command-Line Interface, Context System, Package Management, Environment Management, Plugin system, Subprocess handling where relevant.

## Relationships

- Each edge: **Source** → **Relationship name** → **Destination**.
- Use **action-oriented, plain verbs**: *invokes*, *reads … from*, *provides … to*, *applies … to*, *runs … using*.
- Prefer **artifact flow** from producer to consumer: *Transaction Planning* **provides transaction plan to** *Package Linking and Unlinking* (not “consumes plan from” on the executor-only side).
- Avoid vague labels like *mutates prefix under*; use *applies package changes to environment prefix in* (or similar).
