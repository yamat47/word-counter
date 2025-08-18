require 'application_system_test_case'

class WordCountersTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit root_url

    assert_selector 'h1', text: 'Word Counter'
    assert_selector 'textarea[data-word-counter="input"]'
  end

  test 'counting words with JavaScript disabled' do
    visit word_counter_url

    fill_in 'text', with: 'Hello world this is a test'
    
    # In noscript mode, the button should be visible
    within 'noscript' do
      click_button 'Count Words'
    end

    # Check that the counts are updated
    within '.counts-container' do
      assert_text '6' # word count
      assert_text '27' # character count
      assert_text '22' # characters without spaces
    end
  end

  test 'real-time counting with JavaScript enabled' do
    visit word_counter_url

    textarea = find('textarea[data-word-counter="input"]')
    
    # Type text into the textarea
    textarea.fill_in with: 'Hello world'
    
    # Wait for JavaScript to update counts
    within '.counts-container' do
      assert_selector '[data-count="words"]', text: '2'
      assert_selector '[data-count="characters"]', text: '11'
      assert_selector '[data-count="characters-no-spaces"]', text: '10'
    end

    # Add more text
    textarea.fill_in with: 'Hello world this is a test'
    
    within '.counts-container' do
      assert_selector '[data-count="words"]', text: '6'
      assert_selector '[data-count="characters"]', text: '27'
      assert_selector '[data-count="characters-no-spaces"]', text: '22'
    end
  end

  test 'clearing text resets counts' do
    visit word_counter_url

    textarea = find('textarea[data-word-counter="input"]')
    
    # Add text
    textarea.fill_in with: 'Some text here'
    
    # Clear text
    textarea.fill_in with: ''
    
    # Check counts are reset to 0
    within '.counts-container' do
      assert_selector '[data-count="words"]', text: '0'
      assert_selector '[data-count="characters"]', text: '0'
      assert_selector '[data-count="characters-no-spaces"]', text: '0'
    end
  end

  test 'handles paste events' do
    visit word_counter_url

    textarea = find('textarea[data-word-counter="input"]')
    
    # Simulate paste by setting value directly
    long_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ' * 10
    textarea.fill_in with: long_text
    
    # Check that counts are updated
    within '.counts-container' do
      assert_selector '[data-count="words"]'
      assert_selector '[data-count="characters"]'
      assert_selector '[data-count="characters-no-spaces"]'
    end
  end

  test 'responsive design on mobile' do
    # Resize to mobile viewport
    page.driver.browser.manage.window.resize_to(375, 667)
    
    visit word_counter_url

    assert_selector 'h1', text: 'Word Counter'
    assert_selector 'textarea[data-word-counter="input"]'
    assert_selector '.counts-container'
  end
end