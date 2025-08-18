# Word Counter Technical Design

## Architecture Overview
Simple Rails MVC architecture with client-side JavaScript for real-time counting. No database interaction required.

## Components

### 1. Controller: `WordCountersController`
**Location**: `app/controllers/word_counters_controller.rb`

**Responsibilities**:
- Single action: `index` to render the word counter page
- No data processing (all counting happens client-side)

### 2. View: Word Counter Interface
**Location**: `app/views/word_counters/index.html.erb`

**Structure**:
```html
<div class="word-counter-container">
  <h1>Word Counter</h1>
  
  <div class="input-section">
    <textarea id="text-input" placeholder="Enter or paste your text here..."></textarea>
  </div>
  
  <div class="stats-section">
    <div class="stat-card">
      <span class="stat-label">Characters</span>
      <span id="char-count" class="stat-value">0</span>
    </div>
    
    <div class="stat-card">
      <span class="stat-label">Words</span>
      <span id="word-count" class="stat-value">0</span>
    </div>
  </div>
</div>
```

### 3. JavaScript: Counting Logic
**Location**: `app/assets/stylesheets/word_counter.js` (using Stimulus controller)

**Core Functions**:
```javascript
// Character counting
countCharacters(text) {
  return text.length;
}

// Word counting
countWords(text) {
  const trimmed = text.trim();
  if (trimmed === '') return 0;
  return trimmed.split(/\s+/).length;
}

// Update display
updateCounts() {
  const text = textarea.value;
  charCountElement.textContent = countCharacters(text);
  wordCountElement.textContent = countWords(text);
}
```

### 4. Styling
**Location**: `app/assets/stylesheets/word_counter.css`

**Design Principles**:
- Mobile-first responsive design
- Clean, minimal interface
- Large, readable text area
- Prominent count displays

## Routing
```ruby
# config/routes.rb
Rails.application.routes.draw do
  root "word_counters#index"
  get "word_counter", to: "word_counters#index"
end
```

## Implementation Approach

### Rails Integration
Since Rails 8 uses Propshaft and doesn't have Webpacker by default, we'll use:
1. Stimulus for JavaScript organization (if already available)
2. Or vanilla JavaScript with data attributes for simplicity

### JavaScript Strategy
- Use event listeners on the textarea (`input` event)
- Update counts on every keystroke
- No debouncing needed for simple counting
- Use `textContent` for secure DOM updates

### CSS Organization
- Use CSS custom properties for theming
- Flexbox for layout
- CSS Grid for stats display
- Media queries for responsive design

## Performance Considerations
- Pure JavaScript counting (no external libraries)
- Minimal DOM manipulation
- Single event listener
- Efficient regex for word splitting

## Testing Strategy
1. **Controller Test**: Verify route renders correctly
2. **System Test**: End-to-end testing with Capybara
3. **JavaScript Testing**: Manual testing for real-time updates

## Security Considerations
- No data persistence (no injection risks)
- Use `textContent` instead of `innerHTML`
- No user input reflected in HTML
- CSP headers already configured by Rails

## Future Enhancements (Not in current scope)
- Character count without spaces option
- Sentence and paragraph counting
- Reading time estimation
- Copy counts to clipboard
- Clear button
- Character/word limits with visual indicators