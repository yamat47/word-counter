# Word Counter - Rails Way Design

## Design Philosophy
"The best code is no code. The second best code is Ruby code." - DHH

## Architecture: The Majestic Simplicity

### 1. Routes - RESTful Even When Simple
```ruby
# config/routes.rb
Rails.application.routes.draw do
  root "word_counter#show"
  
  resource :word_counter, only: [:show, :create]
end
```

Why `resource` (singular)? Because there's only one word counter. It's a singleton resource.

### 2. Controller - Expressive Ruby
```ruby
# app/controllers/word_counter_controller.rb
class WordCounterController < ApplicationController
  def show
    @text = ""
    @character_count = 0
    @word_count = 0
  end
  
  def create
    @text = params[:text] || ""
    @character_count = @text.length
    @word_count = count_words(@text)
    
    respond_to do |format|
      format.html { render :show }
      format.turbo_stream
    end
  end
  
  private
  
  def count_words(text)
    text.blank? ? 0 : text.split.size
  end
end
```

### 3. View - Server-Side Rendering First
```erb
<!-- app/views/word_counter/show.html.erb -->
<div class="word-counter">
  <h1>Word Counter</h1>
  
  <%= form_with url: word_counter_path, local: false do |form| %>
    <div class="text-input">
      <%= form.text_area :text, 
          value: @text,
          placeholder: "Start typing or paste your text here...",
          rows: 10,
          data: { 
            action: "input->word-counter#count",
            word_counter_target: "input" 
          } %>
    </div>
    
    <div class="counts" id="counts">
      <%= render "counts", character_count: @character_count, word_count: @word_count %>
    </div>
    
    <noscript>
      <%= form.submit "Count", class: "count-button" %>
    </noscript>
  <% end %>
</div>
```

### 4. Partial - Reusable Component
```erb
<!-- app/views/word_counter/_counts.html.erb -->
<div class="count-grid">
  <div class="count-card">
    <div class="count-value"><%= number_with_delimiter(character_count) %></div>
    <div class="count-label">Characters</div>
  </div>
  
  <div class="count-card">
    <div class="count-value"><%= number_with_delimiter(word_count) %></div>
    <div class="count-label">Words</div>
  </div>
</div>
```

### 5. Turbo Stream - Progressive Enhancement
```erb
<!-- app/views/word_counter/create.turbo_stream.erb -->
<%= turbo_stream.replace "counts" do %>
  <%= render "counts", character_count: @character_count, word_count: @word_count %>
<% end %>
```

### 6. Stimulus Controller - Minimal JavaScript
```javascript
// app/assets/javascripts/controllers/word_counter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "form"]
  
  count() {
    // Debounce to avoid too many requests
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 300)
  }
}
```

### 7. Styling - Vanilla CSS, Beautiful
```css
/* app/assets/stylesheets/word_counter.css */
.word-counter {
  max-width: 42rem;
  margin: 4rem auto;
  padding: 2rem;
}

.word-counter h1 {
  font-size: 2rem;
  margin-bottom: 2rem;
  color: #333;
}

.text-input textarea {
  width: 100%;
  padding: 1rem;
  font-size: 1rem;
  line-height: 1.5;
  border: 2px solid #ddd;
  border-radius: 0.5rem;
  resize: vertical;
  transition: border-color 0.2s;
}

.text-input textarea:focus {
  outline: none;
  border-color: #0066cc;
}

.count-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
  margin-top: 2rem;
}

.count-card {
  text-align: center;
  padding: 1.5rem;
  background: #f8f8f8;
  border-radius: 0.5rem;
}

.count-value {
  font-size: 3rem;
  font-weight: bold;
  color: #0066cc;
}

.count-label {
  font-size: 1rem;
  color: #666;
  margin-top: 0.5rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
}

/* For browsers without JavaScript */
.count-button {
  display: block;
  margin: 2rem auto 0;
  padding: 0.75rem 2rem;
  font-size: 1rem;
  background: #0066cc;
  color: white;
  border: none;
  border-radius: 0.5rem;
  cursor: pointer;
}

.count-button:hover {
  background: #0052a3;
}
```

## Why This Is "The Rails Way"

### 1. Progressive Enhancement
- Works without JavaScript (form submission)
- Enhances with Turbo (no page refresh)
- Stimulus for fine control (debounced input)

### 2. Server-Side Logic
- Word counting happens in Ruby
- No client-side state management
- Server is the single source of truth

### 3. Rails Conventions
- RESTful routes (even for single resource)
- Form helpers with CSRF protection
- Partials for reusable components
- Turbo Streams for updates

### 4. Simplicity
- No npm packages
- No build process complications
- No JavaScript framework
- Just Rails, as it should be

### 5. Beautiful Code
- Reads naturally
- Each piece has one responsibility
- Convention over configuration
- Minimal but complete

## Database-Free by Design
Following the requirement, no database. But if we wanted persistence later:
- Could add `TextAnalysis` model
- Store results in Rails cache
- Use cookies for user session
- All without changing the core design

## Testing Approach
```ruby
# test/controllers/word_counter_controller_test.rb
class WordCounterControllerTest < ActionDispatch::IntegrationTest
  test "shows empty counter" do
    get word_counter_path
    assert_response :success
    assert_select ".count-value", text: "0", count: 2
  end
  
  test "counts words and characters" do
    post word_counter_path, params: { text: "Hello Rails world" }
    assert_response :success
    assert_select ".count-value", text: "17" # characters
    assert_select ".count-value", text: "3"  # words
  end
end
```

## The DHH Touch
- No unnecessary abstractions
- Code that reads like documentation
- Embraces web fundamentals
- Makes the simple things simple
- Keeps the hard things possible