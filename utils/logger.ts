import consola from 'consola'

function info (prefix: string, message: any, options: object = null) {
  consola.info({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}

function warn (prefix: string, message: any, options: object = null) {
  consola.warn({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}

function fatal (prefix: string, message: any, options: object = null) {
  consola.fatal({
    message: `[${prefix}] ${message}`,
    additional: options ? JSON.stringify(options, null, 2) : null
  })
}

export default { info, warn, fatal }
