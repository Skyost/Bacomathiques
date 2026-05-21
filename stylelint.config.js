export default {
  extends: [
    'stylelint-config-standard-scss',
    'stylelint-config-recommended-vue'
  ],
  rules: {
    'at-rule-no-unknown': null,
    'alpha-value-notation': null,
    'color-function-alias-notation': null,
    'color-function-notation': null,
    'declaration-empty-line-before': null,
    'declaration-property-value-keyword-no-deprecated': null,
    'declaration-property-value-no-unknown': null,
    'font-family-name-quotes': null,
    'function-no-unknown': [
      true,
      {
        ignoreFunctions: ['lighten', 'darken']
      }
    ],
    'no-descending-specificity': null,
    'property-no-deprecated': null,
    'selector-class-pattern': null,
    'selector-pseudo-element-colon-notation': null,
    'scss/at-mixin-argumentless-call-parentheses': null,
    'scss/at-rule-no-unknown': true,
    'scss/dollar-variable-pattern': null,
    'scss/double-slash-comment-empty-line-before': null,
    'scss/load-partial-extension': null,
    'scss/no-global-function-names': null,
    'shorthand-property-no-redundant-values': null
  }
}
