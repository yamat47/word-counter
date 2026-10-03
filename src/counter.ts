export type Counts = {
  readonly words: number;
  readonly characters: number;
  readonly charactersWithoutSpaces: number;
};

const graphemes = new Intl.Segmenter(undefined, { granularity: 'grapheme' });

function countWords(text: string): number {
  const trimmed = text.trim();
  return trimmed === '' ? 0 : trimmed.split(/\s+/).length;
}

export function count(text: string): Counts {
  let characters = 0;
  let spaces = 0;
  // A character is what a reader sees as one. `String#length` counts UTF-16
  // code units, which makes one emoji 2 and a family emoji 8.
  for (const { segment } of graphemes.segment(text)) {
    characters += 1;
    if (/^\s+$/.test(segment)) spaces += 1;
  }

  return {
    words: countWords(text),
    characters,
    charactersWithoutSpaces: characters - spaces,
  };
}
