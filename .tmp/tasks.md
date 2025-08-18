# Word Counter Implementation Tasks

## Phase 1: Backend Setup (30 minutes)

### Task 1.1: Create Controller
- [ ] Generate `WordCountersController`
- [ ] Add `index` action
- [ ] Create basic controller test

### Task 1.2: Configure Routes
- [ ] Add root route to `word_counters#index`
- [ ] Add named route `/word_counter`
- [ ] Verify routes with `rails routes`

## Phase 2: Frontend Structure (45 minutes)

### Task 2.1: Create View Template
- [ ] Create `app/views/word_counters/index.html.erb`
- [ ] Add HTML structure for text input area
- [ ] Add counter display elements
- [ ] Add semantic HTML and accessibility attributes

### Task 2.2: Create Stylesheet
- [ ] Create `app/assets/stylesheets/word_counter.css`
- [ ] Add base styles for container
- [ ] Style textarea (responsive, readable)
- [ ] Style counter displays
- [ ] Add responsive breakpoints

## Phase 3: JavaScript Implementation (45 minutes)

### Task 3.1: Create JavaScript File
- [ ] Create word counter JavaScript file
- [ ] Set up event listeners for textarea
- [ ] Implement character counting function
- [ ] Implement word counting function

### Task 3.2: Connect JavaScript to View
- [ ] Link JavaScript to the view
- [ ] Test real-time updating
- [ ] Ensure counts update on paste events
- [ ] Handle edge cases (empty text, only spaces)

## Phase 4: Polish & Testing (30 minutes)

### Task 4.1: UI Polish
- [ ] Add placeholder text
- [ ] Improve visual hierarchy
- [ ] Add hover states
- [ ] Ensure mobile responsiveness

### Task 4.2: Testing
- [ ] Manual testing with various text inputs
- [ ] Test with large text blocks
- [ ] Test on mobile viewport
- [ ] Cross-browser testing

### Task 4.3: Final Adjustments
- [ ] Code cleanup
- [ ] Remove any debug statements
- [ ] Optimize CSS
- [ ] Add comments where necessary

## Implementation Order

1. **Start with Backend** (Tasks 1.1-1.2)
   - Get the route and controller working first
   - Verify the page loads

2. **Build the UI** (Tasks 2.1-2.2)
   - Create the HTML structure
   - Apply basic styling
   - Ensure responsive layout

3. **Add Functionality** (Tasks 3.1-3.2)
   - Implement counting logic
   - Connect to UI elements
   - Test real-time updates

4. **Polish and Test** (Tasks 4.1-4.3)
   - Refine the user experience
   - Ensure quality and reliability

## Estimated Total Time: 2.5 hours

## Files to Create/Modify

### New Files:
- `app/controllers/word_counters_controller.rb`
- `app/views/word_counters/index.html.erb`
- `app/assets/stylesheets/word_counter.css`
- JavaScript file for word counting logic

### Modified Files:
- `config/routes.rb`

## Testing Checklist

- [ ] Empty text shows 0 characters, 0 words
- [ ] Single character shows 1 character, 0 words
- [ ] Single word shows correct character count, 1 word
- [ ] Multiple words with various spacing work correctly
- [ ] Line breaks are handled properly
- [ ] Special characters are counted correctly
- [ ] Large text (10,000+ characters) performs well
- [ ] Copy/paste works and updates counts
- [ ] Works on mobile devices
- [ ] Works on major browsers

## Definition of Done

- [ ] Route configured and working
- [ ] Controller responds with the view
- [ ] UI is clean and responsive
- [ ] Character counting works in real-time
- [ ] Word counting works in real-time
- [ ] No console errors
- [ ] Code is clean and documented
- [ ] Manual testing completed