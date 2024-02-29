def compile_source_file(file_path):
    solcx.install_solc(version='0.8.9')
    solcx.set_solc_version('0.8.9')
    with open(file_path, 'r') as f:
        source = f.read()
        print(source)
    return solcx.compile_source(source)


