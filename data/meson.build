# Install icon
install_data(
    join_paths ('icons', meson.project_name () + '.svg'),
    install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'scalable', 'apps')
)

# Translate and install our .desktop file so the Applications Menu will see it
i18n.merge_file (
    input: meson.project_name () + '.desktop.in',
    output: meson.project_name () + '.desktop',
    po_dir: join_paths (meson.source_root (), 'po', 'extra'),
    type: 'desktop',
    install: true,
    install_dir: join_paths (get_option ('datadir'), 'applications')
)

# Translate and install our .appdata.xml file so AppCenter will see it
i18n.merge_file (
    input: meson.project_name () + '.appdata.xml.in',
    output: meson.project_name () + '.appdata.xml',
    po_dir: join_paths (meson.source_root (), 'po', 'extra'),
    install: true,
    install_dir: join_paths (get_option ('datadir'), 'metainfo')
)

# Install gschema
install_data (
    meson.project_name () + '.gschema.xml',
    install_dir: join_paths (get_option ('datadir'), 'glib-2.0', 'schemas')
)
