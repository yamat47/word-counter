// @vitest-environment happy-dom
import { beforeEach, describe, expect, it } from 'vitest';
import page from '../index.html?raw';
import { setupCounter } from './app';

function shown(key: string): string | null | undefined {
  return document.querySelector(`[data-count="${key}"]`)?.textContent;
}

function textarea(): HTMLTextAreaElement {
  const element = document.querySelector('textarea');
  if (element === null) throw new Error('Expected a textarea');
  return element;
}

function type(text: string): void {
  textarea().value = text;
  textarea().dispatchEvent(new Event('input'));
}

describe('setupCounter', () => {
  beforeEach(() => {
    // The real page is the fixture, so renaming an id or a data-count value
    // in index.html without updating app.ts fails here.
    document.body.innerHTML = new DOMParser().parseFromString(page, 'text/html').body.innerHTML;
  });

  it('shows all three counts for the text as it is typed', () => {
    setupCounter(document);

    type('Hello world');

    expect(shown('words')).toBe('2');
    expect(shown('characters')).toBe('11');
    expect(shown('charactersWithoutSpaces')).toBe('10');
  });

  it('returns to zero when the text is cleared', () => {
    setupCounter(document);
    type('Some text here');

    type('');

    expect(shown('words')).toBe('0');
    expect(shown('characters')).toBe('0');
    expect(shown('charactersWithoutSpaces')).toBe('0');
  });

  it('counts text the browser restored before setup', () => {
    textarea().value = 'restored after reload';

    setupCounter(document);

    expect(shown('words')).toBe('3');
  });

  it('separates thousands with commas', () => {
    setupCounter(document);

    type('a'.repeat(1234));

    expect(shown('characters')).toBe('1,234');
  });
});
