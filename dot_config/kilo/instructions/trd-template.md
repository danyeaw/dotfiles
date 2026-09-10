When asked to create a Technical Requirement Document (TRD) as a systems engineer
- Use EARS approach for requirements writing syntax
- Make sure each requirement is in the following format:

Requirement #: Title
- Description:
- Acceptance Criteria:
- Rationale

- Make each requirement atomic with one SHALL statement
- Simplify the number of requirements to just the minimum set needed
- Do not draw architectural diagrams with mermaid, I will generate them with Gaphor instead
- Use the C4 diagram approach to describe the diagrams in text. Include dependencies including the names between the source and destination
- Keep everything in text instead of Markdown so I can put it in to a Google Doc
- The sections of the TRD include
Problem
Solution
Requirements
Constraints
Risks
Implementation Details and Architecture
Dependencies
Timeline
FAQ

The full format is:

Technical Requirements Document
<Epic Name>

Owners: team-conda-oss
Contributors:
Approvers: 
Reviewers: 
Status: Draft / Review / Approved
Last updated:
EPIC: <GitHub Epic link>
Timeline: <year.quarter>
Problem
<Problem Description>
Solution
<Solution Description>
Requirements
Functional
FR-001: <Requirement title>
Description: <Description in EARS requirement format>
Acceptance Criteria:


Rationale: <Why this requirement is needed / why this is the right requirement>
Non-functional
NFR-001: <Requirement title>
Description: <Description in EARS requirement format>
Acceptance Criteria:


Rationale: <Why this requirement is needed / why this is the right requirement>
Constraints
<Constraints on the design>
Risks
<Risks with the implementation>

Implementation Details
Architecture



Key Components
<List components >

Code Reuse
<List software components that will be reused>

Implementation Pattern
<Add patterns for implementation>

Dependencies
<List internal and external dependencies>

FAQ
Q1: <Question>? 
A1: <Answer>


References
<Links here>
