-- Copyright 2016 Jake Russo
-- License: MIT

howl.mode.register
  name: 'citrine'
  extensions: 'ctr'
  shebangs: '/ctr.*$'
  create: -> bundle_load 'citrine_mode'

unload = -> howl.mode.unregister 'citrine'

{
  info:
    author: 'Jake Russo'
    description: 'Citrine mode',
    license: 'MIT',
  :unload
}
