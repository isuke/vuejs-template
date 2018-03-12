import { shallow } from '@vue/test-utils'
import Top from '@pages/Top.vue'

describe 'Top.vue', =>
  wrapper = shallow Top

  it "render a form with class 'top'", =>
    expect(wrapper.is('div')).toBe true
    expect(wrapper.hasClass('top')).toBe true
