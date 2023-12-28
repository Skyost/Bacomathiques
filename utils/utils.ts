import path from 'path'
import crypto from 'crypto'

/**
 * Extracts the filename from a given file path.
 *
 * @param {string} file - File path.
 * @returns {string} - Filename.
 */
export const getFileName = (file: string): string => path.parse(file).name

/**
 * Generates an MD5 checksum for a given string.
 *
 * @param {string} string - Input string.
 * @returns {string} - MD5 checksum.
 */
export const generateChecksum = (string: string): string => crypto
  .createHash('md5')
  .update(string, 'utf8')
  .digest('hex')

/**
 * Sleeps for a given time.
 *
 * @param {number} ms - The time to sleep.
 */
export const sleeper = (ms: number): Promise<void> => new Promise(resolve => setTimeout(resolve, ms))

/**
 * Normalizes a string by removing diacritics and converting to lowercase.
 *
 * @param {string} string - Input string.
 * @returns {string} - Normalized string.
 */
export const normalizeString = (string: string): string => string.normalize('NFD').replace(/\p{Diacritic}/gu, '').toLowerCase()

/**
 * Replaces all line breaks from a string.
 *
 * @param {string} string - Input string.
 * @param {string} by - The replacement string.
 * @returns {string} - The string without line breaks.
 */
export const replaceLineBreaks = (string: string, by: string = ' '): string => string.replace(/\r?\n|\r/gm, by)

/**
 * Romanizes a given number.
 *
 * @param {number} num - The number.
 */
export const romanize = (num: number) : string => {
  if (isNaN(num)) {
    return ''
  }
  const digits = String(+num).split('')
  const key = ['', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM',
    '', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC',
    '', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX']
  let roman = ''
  let i = 3
  while (i--) {
    roman = (key[+digits.pop()! + (i * 10)] || '') + roman
  }
  return Array(+digits.join('') + 1).join('M') + roman
}
