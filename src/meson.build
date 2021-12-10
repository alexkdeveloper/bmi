bmi_sources = [
  'main.vala',
  'window.vala',
  ]

bmi_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('granite'),
]

gnome = import('gnome')

bmi_sources += gnome.compile_resources('bmi-resources',
  'bmi.gresource.xml',
  c_name: 'bmi'
)

executable('com.github.alexkdeveloper.bmi', bmi_sources,
  vala_args: '--target-glib=2.50',  dependencies: bmi_deps,
  install: true,
)
