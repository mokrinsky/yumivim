local language, server, formatter, diagnostics, dap = unpack(require 'yumivim.plugins.lsp.dsl')

return language {
  name = 'xml',

  server.disabled {},

  formatter.null {
    runner = formatter.runner.xmllint,
    config = {
      env = {
        XMLLINT_INDENT = '    ',
      },
    },
  },

  diagnostics.disabled {},

  dap.disabled {},
}
