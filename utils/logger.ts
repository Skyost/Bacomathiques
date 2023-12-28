import { consola } from 'consola'

/**
 * Logs an informational message.
 *
 * @param {string} prefix - Prefix for the log message.
 * @param {*} message - Log message content.
 * @param {any} options - Additional options to include in the log.
 */
export function info (prefix: string, message: any, options: any = null): void {
  consola.info({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}

/**
 * Logs a warning message.
 *
 * @param {string} prefix - Prefix for the log message.
 * @param {*} message - Log message content.
 * @param {any} options - Additional options to include in the log.
 */
export function warn (prefix: string, message: any, options: any = null): void {
  consola.warn({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}

/**
 * Logs a fatal error message.
 *
 * @param {string} prefix - Prefix for the log message.
 * @param {*} message - Log message content.
 * @param {any} options - Additional options to include in the log.
 */
export function fatal (prefix: string, message: any, options: any = null): void {
  consola.fatal({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}

/**
 * Logs a success message.
 *
 * @param {string} prefix - Prefix for the log message.
 * @param {*} message - Log message content.
 * @param {any} options - Additional options to include in the log.
 */
export function success (prefix: string, message: any, options: any = null): void {
  consola.success({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}
