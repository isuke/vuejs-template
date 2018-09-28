module.exports = {
  prompts: {
    name: {
      type: 'string',
      required: true,
      label: 'Project name',
    },
    description: {
      type: 'string',
      required: true,
      label: 'Project description',
      default: 'A Vue.js project',
    },
    author: {
      type: 'string',
      label: 'Author',
    },
    license: {
      type: 'string',
      label: 'License',
      default: 'MIT',
    },
    postCss: {
      type: 'checkbox',
      label: 'Select which postCss libraries',
      choices: ['autoprefixer', 'flexbugs-fixes'],
      default: ['autoprefixer', 'flexbugs-fixes'],
    },
    altCss: {
      type: 'list',
      label: 'Use alt css',
      default: 'scss',
      choices: [
        { value: 'scss'  , name: 'scss' },
        { value: 'stylus', name: 'stylus (Not recommended. It has not been maintained yet.)' },
      ],
    },
    unitTest: {
      type: 'confirm',
      default: true,
      label: 'Setup unit test?',
    },
  },
  helpers: {
    if_or: function(val1, val2, opts) {
      if (val1 || val2) {
        return opts.fn(this)
      }
    },
    if_and: function(val1, val2, opts) {
      if (val1 && val2) {
        return opts.fn(this)
      }
    },
    includes: function(list, val, opts) {
      if (list[val]) {
        return opts.fn(this)
      }
    },
  },
  filters: {
    'src/styles/**/*.scss': 'altCss == "scss"',
    'src/styles/**/*.styl': 'altCss == "stylus"',
    'spec/unit/**/*': 'unitTest',
  },
  completeMessage:
    '{{#inPlace}}To get started:\n\n  yarn install\n  yarn run dev.{{else}}To get started:\n\n  cd {{destDirName}}\n  yarn install\n  yarn run dev{{/inPlace}}',
}
