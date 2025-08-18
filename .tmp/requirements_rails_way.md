# Word Counter - Rails Way Requirements

## Philosophy
Following DHH's approach: "Clarity over cleverness, convention over configuration, and expressiveness over terseness."

## Core Principle
Build a word counter that exemplifies Rails' beauty through:
- Server-side rendering with Turbo enhancements
- Progressive enhancement, not JavaScript dependency
- Embracing Rails conventions
- Minimal, purposeful code

## Functional Requirements

### The Majestic Monolith Approach
1. **Single Resource**
   - One controller action that handles everything
   - Works without JavaScript (form submission)
   - Enhanced with Turbo for seamless experience

2. **Text Analysis**
   - Character counting (server-side)
   - Word counting (server-side)
   - Optional: Live updates via Turbo Frames

3. **User Experience**
   - Works perfectly without JavaScript
   - Progressive enhancement with Turbo
   - No build step, no npm, no webpack
   - Vanilla CSS, no frameworks

## Rails-Specific Requirements

### Convention Over Configuration
- Use Rails form helpers
- Leverage Rails' built-in CSRF protection
- Utilize Rails layouts and partials
- Embrace RESTful design even for simple features

### Progressive Enhancement
- Base functionality works with form POST
- Turbo Stream for live updates (optional)
- Stimulus for keyboard shortcuts (if needed)
- No React, no Vue, just Rails

### Simplicity
- No database needed, but could use Rails cache
- Single route, single action
- Minimal JavaScript, maximum Ruby
- Let Rails do the heavy lifting

## What Makes This "Rails Way"

1. **Server-Centric**
   - Logic lives in Ruby, not JavaScript
   - Server renders the truth
   - Client enhances, doesn't control

2. **Conceptual Compression**
   - One file per concept
   - Clear naming following Rails conventions
   - No abstraction without repetition

3. **Beautiful Code**
   - Reads like poetry
   - Expressive method names
   - Ruby's elegance shines through

## Success Criteria
- Works with JavaScript disabled
- Feels magical with Turbo enabled
- Code that makes DHH smile
- New developers understand it immediately