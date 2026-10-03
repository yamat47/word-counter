import { count, type Counts } from './counter';

const COUNT_KEYS = [
  'words',
  'characters',
  'charactersWithoutSpaces',
] as const satisfies readonly (keyof Counts)[];

const numberFormat = new Intl.NumberFormat('en-US');

function findRequired<T extends Element>(root: ParentNode, selector: string, type: new () => T): T {
  const element = root.querySelector(selector);
  if (!(element instanceof type)) {
    throw new Error(`Expected a ${type.name} matching ${selector}`);
  }
  return element;
}

export function setupCounter(root: ParentNode): void {
  const textarea = findRequired(root, '#text', HTMLTextAreaElement);
  const outputs = COUNT_KEYS.map(
    (key) => [key, findRequired(root, `[data-count="${key}"]`, HTMLElement)] as const,
  );

  const render = (): void => {
    const counts = count(textarea.value);
    for (const [key, output] of outputs) {
      const formatted = numberFormat.format(counts[key]);
      output.textContent = formatted;
      // The stylesheet shrinks the figure as it gets longer so it stays in its column.
      output.style.setProperty('--figure-length', String(formatted.length));
    }
  };

  textarea.addEventListener('input', render);
  // Browsers restore the textarea's text on reload without firing `input`.
  render();
}
