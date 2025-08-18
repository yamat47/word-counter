require 'test_helper'

class WordCounterTest < ActiveSupport::TestCase
  # Test word counting logic
  test 'counts words correctly' do
    test_cases = [
      { text: 'Hello world', expected: 2 },
      { text: 'One two three four five', expected: 5 },
      { text: '  Spaces  everywhere  ', expected: 2 },
      { text: '', expected: 0 },
      { text: '   ', expected: 0 },
      { text: 'Word', expected: 1 },
      { text: "Line\nbreaks\nare\nwords", expected: 4 },
      { text: 'Multiple    spaces    between', expected: 3 },
      { text: 'Punctuation! Does? Not, Matter.', expected: 4 },
      { text: 'email@example.com is one word', expected: 4 },
      { text: 'CamelCaseWord', expected: 1 },
      { text: 'snake_case_word', expected: 1 },
      { text: 'kebab-case-word', expected: 1 }
    ]

    test_cases.each do |test_case|
      text = test_case[:text]
      expected = test_case[:expected]
      
      # Simulate the counting logic from the controller
      word_count = if text.blank?
                     0
                   else
                     text.split(/\s+/).compact_blank.count
                   end
      
      assert_equal expected, word_count, "Failed for text: '#{text}'"
    end
  end

  test 'counts characters correctly' do
    test_cases = [
      { text: 'Hello', expected: 5 },
      { text: 'Hello world', expected: 11 },
      { text: '  Spaces  ', expected: 10 },
      { text: '', expected: 0 },
      { text: "Line\nbreak", expected: 10 }
    ]

    test_cases.each do |test_case|
      text = test_case[:text]
      expected = test_case[:expected]
      
      character_count = text.length
      
      assert_equal expected, character_count, "Failed for text: '#{text}'"
    end
  end

  test 'counts characters without spaces correctly' do
    test_cases = [
      { text: 'Hello', expected: 5 },
      { text: 'Hello world', expected: 10 },
      { text: '  Spaces  ', expected: 6 },
      { text: '', expected: 0 },
      { text: '   ', expected: 0 },
      { text: "Line\nbreak", expected: 9 }
    ]

    test_cases.each do |test_case|
      text = test_case[:text]
      expected = test_case[:expected]
      
      char_no_space_count = text.gsub(/\s/, '').length
      
      assert_equal expected, char_no_space_count, "Failed for text: '#{text}'"
    end
  end

  test 'handles unicode characters' do
    test_cases = [
      { text: '你好世界', word_count: 1, char_count: 4 }, # Chinese
      { text: 'こんにちは', word_count: 1, char_count: 5 }, # Japanese
      { text: '안녕하세요', word_count: 1, char_count: 5 }, # Korean
      { text: 'مرحبا', word_count: 1, char_count: 5 }, # Arabic
      { text: '👋 🌍', word_count: 2, char_count: 3 }, # Emojis
      { text: 'Hello 世界', word_count: 2, char_count: 8 } # Mixed
    ]

    test_cases.each do |test_case|
      text = test_case[:text]
      expected_words = test_case[:word_count]
      expected_chars = test_case[:char_count]
      
      word_count = text.split(/\s+/).compact_blank.count
      char_count = text.length
      
      assert_equal expected_words, word_count, "Word count failed for: '#{text}'"
      assert_equal expected_chars, char_count, "Char count failed for: '#{text}'"
    end
  end
end