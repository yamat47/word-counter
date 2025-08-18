require 'test_helper'

class WordCountersControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get word_counter_url
    assert_response :success
    assert_select 'h1', 'Word Counter'
    assert_select 'textarea[data-word-counter="input"]'
    assert_select '[data-count="words"]', '0'
    assert_select '[data-count="characters"]', '0'
    assert_select '[data-count="characters-no-spaces"]', '0'
  end

  test 'should get root' do
    get root_url
    assert_response :success
    assert_select 'h1', 'Word Counter'
  end

  test 'should count words on create' do
    post word_counter_url, params: { text: 'Hello world this is a test' }, 
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
    assert_match 'turbo-stream', response.content_type
  end

  test 'should count empty text' do
    post word_counter_url, params: { text: '' },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should count text with only spaces' do
    post word_counter_url, params: { text: '   ' },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should count text with multiple spaces between words' do
    post word_counter_url, params: { text: 'Hello    world' },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should handle Japanese text' do
    post word_counter_url, params: { text: 'こんにちは 世界' },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should handle mixed language text' do
    post word_counter_url, params: { text: 'Hello world こんにちは 世界' },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should handle special characters' do
    post word_counter_url, params: { text: 'Hello! World? Test@example.com' },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should handle line breaks' do
    post word_counter_url, params: { text: "Hello\nWorld\nTest" },
         headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
    assert_response :success
  end

  test 'should render HTML format' do
    post word_counter_url, params: { text: 'Test text' }
    assert_response :success
    assert_select 'h1', 'Word Counter'
  end
end