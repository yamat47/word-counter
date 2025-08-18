// Word Counter JavaScript - Progressive Enhancement
(function() {
  'use strict';

  // Debounce function to limit API calls
  function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }

  // Count words in text
  function countWords(text) {
    if (!text || text.trim() === '') return 0;
    return text.trim().split(/\s+/).filter(word => word.length > 0).length;
  }

  // Count characters
  function countCharacters(text) {
    return text ? text.length : 0;
  }

  // Count characters without spaces
  function countCharactersNoSpaces(text) {
    return text ? text.replace(/\s/g, '').length : 0;
  }

  // Update counts in the UI
  function updateCounts(text) {
    const wordCount = countWords(text);
    const charCount = countCharacters(text);
    const charNoSpaceCount = countCharactersNoSpaces(text);

    // Update count displays
    const wordCountEl = document.querySelector('[data-count="words"]');
    const charCountEl = document.querySelector('[data-count="characters"]');
    const charNoSpaceCountEl = document.querySelector('[data-count="characters-no-spaces"]');

    if (wordCountEl) {
      wordCountEl.textContent = wordCount.toLocaleString();
    }
    if (charCountEl) {
      charCountEl.textContent = charCount.toLocaleString();
    }
    if (charNoSpaceCountEl) {
      charNoSpaceCountEl.textContent = charNoSpaceCount.toLocaleString();
    }
  }

  // Submit form via Turbo
  function submitForm(form) {
    // Create a FormData object
    const formData = new FormData(form);
    
    // Submit using fetch with Turbo Stream accept header
    fetch(form.action, {
      method: form.method,
      body: formData,
      headers: {
        'Accept': 'text/vnd.turbo-stream.html, text/html',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      credentials: 'same-origin'
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.text();
    })
    .then(html => {
      // Turbo will handle the stream response automatically
      if (html.includes('turbo-stream')) {
        Turbo.renderStreamMessage(html);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }

  // Initialize when DOM is ready
  document.addEventListener('DOMContentLoaded', function() {
    const textarea = document.querySelector('[data-word-counter="input"]');
    const form = document.querySelector('[data-word-counter="form"]');
    
    if (!textarea) return;

    // Remove the submit button if JavaScript is enabled
    const submitButton = form ? form.querySelector('button[type="submit"]') : null;
    if (submitButton && submitButton.parentElement.tagName === 'NOSCRIPT') {
      // Button is already hidden by noscript tag
    } else if (submitButton) {
      submitButton.style.display = 'none';
    }

    // Initial count on page load
    updateCounts(textarea.value);

    // Create debounced functions
    const debouncedUpdate = debounce(function(text) {
      updateCounts(text);
      
      // Submit form for server-side counting if form exists
      if (form) {
        submitForm(form);
      }
    }, 300);

    // Listen for input events
    textarea.addEventListener('input', function(event) {
      debouncedUpdate(event.target.value);
    });

    // Handle paste events
    textarea.addEventListener('paste', function(event) {
      setTimeout(() => {
        debouncedUpdate(event.target.value);
      }, 10);
    });
  });

  // Also initialize on Turbo load (for navigation)
  document.addEventListener('turbo:load', function() {
    const textarea = document.querySelector('[data-word-counter="input"]');
    if (textarea) {
      updateCounts(textarea.value);
    }
  });
})();