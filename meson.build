# Project name, programming language and version
project (
    'com.github.alexkdeveloper.bmi',
    'c', 'vala',
    version: '1.0.1'
)

# Translation module
i18n = import ('i18n')

# Project arguments
add_project_arguments (
    '-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name ()),
    language: 'c'
)

# GNOME module
gnome = import ('gnome')

# Compiling resources
gresource = gnome.compile_resources (
    'gresource',
    join_paths ('data', meson.project_name ()) + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

# Listing dependencies
dependencies = [
    dependency ('gio-2.0'),
    dependency ('gtk+-3.0'),
    dependency ('granite')
]

subdir ('src')

# Defining executable
executable (
    meson.project_name (),
    sources,
    gresource,
    dependencies: dependencies,
    install: true
)

subdir ('data')
subdir ('po')

meson.add_install_script ('meson/post_install.py')
