# Word Counter - Rails Way Implementation Tasks

## 実装の心得
"Write code that reads like well-written prose" - DHH

## Phase 1: The Foundation (15 minutes)

### Task 1.1: Routes - RESTful Simplicity
```bash
# No generator needed, just edit:
# config/routes.rb
```
- [ ] Define root route to `word_counter#show`
- [ ] Add singleton resource `:word_counter`
- [ ] Only `:show` and `:create` actions

### Task 1.2: Controller - Pure Ruby Expression
```bash
# Create controller manually for full control:
touch app/controllers/word_counter_controller.rb
```
- [ ] Create `WordCounterController`
- [ ] Implement `show` action (empty state)
- [ ] Implement `create` action (counting logic)
- [ ] Add private `count_words` method

## Phase 2: The View Layer (20 minutes)

### Task 2.1: Main View - Server-Side First
```bash
mkdir -p app/views/word_counter
touch app/views/word_counter/show.html.erb
```
- [ ] Create form with `form_with`
- [ ] Add textarea with proper data attributes
- [ ] Include `<noscript>` submit button
- [ ] Structure with semantic HTML

### Task 2.2: Counts Partial - Reusable Component
```bash
touch app/views/word_counter/_counts.html.erb
```
- [ ] Create counts display partial
- [ ] Use `number_with_delimiter` helper
- [ ] Clean, semantic markup

### Task 2.3: Turbo Stream - Progressive Enhancement
```bash
touch app/views/word_counter/create.turbo_stream.erb
```
- [ ] Create Turbo Stream response
- [ ] Replace counts section smoothly

## Phase 3: Styling - Vanilla CSS Beauty (15 minutes)

### Task 3.1: Create Stylesheet
```bash
touch app/assets/stylesheets/word_counter.css
```
- [ ] Mobile-first responsive design
- [ ] Focus on typography and spacing
- [ ] Subtle interactions (focus states)
- [ ] No frameworks, just CSS

## Phase 4: Optional JavaScript Enhancement (10 minutes)

### Task 4.1: Stimulus Setup (If Not Present)
```bash
# Check if Stimulus is available
# If not, we can add inline JavaScript
```
- [ ] Check for Stimulus availability
- [ ] Alternative: Simple inline JavaScript
- [ ] Debounced form submission

### Task 4.2: Add Stimulus Controller (Optional)
```bash
# If Stimulus is available:
touch app/assets/javascripts/controllers/word_counter_controller.js
```
- [ ] Create minimal Stimulus controller
- [ ] Debounce input events
- [ ] Auto-submit form

## Phase 5: Testing & Polish (10 minutes)

### Task 5.1: Controller Tests
```bash
touch test/controllers/word_counter_controller_test.rb
```
- [ ] Test empty state
- [ ] Test word counting
- [ ] Test character counting
- [ ] Test Turbo Stream response

### Task 5.2: System Tests (Optional)
```bash
touch test/system/word_counter_test.rb
```
- [ ] Test without JavaScript
- [ ] Test with JavaScript enabled
- [ ] Test real-time updates

## Implementation Commands

```bash
# Start development server
bin/rails server

# Run tests
bin/rails test

# Check routes
bin/rails routes | grep word_counter
```

## File Structure (Rails Way)

```
app/
├── controllers/
│   └── word_counter_controller.rb      # Single controller
├── views/
│   └── word_counter/
│       ├── show.html.erb               # Main view
│       ├── _counts.html.erb            # Partial
│       └── create.turbo_stream.erb     # Turbo response
└── assets/
    └── stylesheets/
        └── word_counter.css             # Vanilla CSS

config/
└── routes.rb                            # RESTful routes
```

## The Rails Way Checklist

### Simplicity
- [ ] No unnecessary files
- [ ] No npm dependencies
- [ ] No build complexity
- [ ] Works without JavaScript

### Convention
- [ ] RESTful routes
- [ ] Rails naming conventions
- [ ] Standard Rails helpers
- [ ] Semantic HTML

### Progressive Enhancement
- [ ] Base functionality without JS
- [ ] Enhanced with Turbo
- [ ] Optional Stimulus controller
- [ ] Graceful degradation

### Beautiful Code
- [ ] Reads like prose
- [ ] Self-documenting
- [ ] Minimal but complete
- [ ] DRY without premature abstraction

## Definition of Done

- [ ] Works with JavaScript disabled
- [ ] Instant updates with Turbo
- [ ] Clean, semantic HTML
- [ ] Vanilla CSS styling
- [ ] Tests passing
- [ ] Code that makes you smile

## Total Time: ~1 hour

Simple. Beautiful. Rails.

## Next Step

Ready to implement with Rails elegance. The code will:
- Embrace server-side rendering
- Use progressive enhancement
- Follow Rails conventions
- Read like poetry

**実装を開始しますか？**