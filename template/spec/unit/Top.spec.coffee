import { shallowMount } from '@vue/test-utils'
import Top from '@pages/Top.vue'

describe 'Top.vue', =>
  wrapper = shallowMount Top

  it "render a form with class 'top'", =>
    expect(wrapper.is('div')).toBe true
    expect(wrapper.classes()).toContain('top')
