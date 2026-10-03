import { describe, expect, it } from 'vitest';
import { count } from './counter';

describe('words', () => {
  it.each([
    ['Hello world', 2],
    ['One two three four five', 5],
    ['  Spaces  everywhere  ', 2],
    ['', 0],
    ['   ', 0],
    ['Word', 1],
    ['Line\nbreaks\nare\nwords', 4],
    ['Multiple    spaces    between', 3],
    ['Punctuation! Does? Not, Matter.', 4],
    ['email@example.com is one word', 4],
    ['kebab-case-word', 1],
    ['全角　スペース', 2],
  ])('splits %j on whitespace into %i', (text, expected) => {
    expect(count(text).words).toBe(expected);
  });

  it.each([
    ['こんにちは世界', 1],
    ['Hello 世界', 2],
  ])('counts %j, written without spaces between words, as %i', (text, expected) => {
    expect(count(text).words).toBe(expected);
  });
});

describe('characters', () => {
  it.each([
    ['Hello world', 11],
    ['  Spaces  ', 10],
    ['', 0],
    ['Line\nbreak', 10],
    ['こんにちは', 5],
    ['مرحبا', 5],
  ])('counts %j as %i, spaces and line breaks included', (text, expected) => {
    expect(count(text).characters).toBe(expected);
  });

  it.each([
    ['👋', 1],
    ['👋 🌍', 3],
    ['👨‍👩‍👧', 1],
    ['🇯🇵', 1],
    ['é', 1],
  ])('counts %j as %i because each visible character is one', (text, expected) => {
    expect(count(text).characters).toBe(expected);
  });
});

describe('characters without spaces', () => {
  it.each([
    ['Hello', 5],
    ['Hello world', 10],
    ['  Spaces  ', 6],
    ['', 0],
    ['   ', 0],
    ['Line\nbreak', 9],
    ['tab\tand　wide', 10],
    ['👋 🌍', 2],
  ])('counts %j as %i', (text, expected) => {
    expect(count(text).charactersWithoutSpaces).toBe(expected);
  });
});
