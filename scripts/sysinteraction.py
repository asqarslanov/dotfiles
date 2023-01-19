import os
import shutil
import subprocess
import typing

username = os.getlogin()
variable_directory = f'/home/{username}/.local/vars'


def execute(command: str) -> None:
    arguments = command.split()
    subprocess.run(arguments)


def get_command_output(command: str) -> str:
    arguments = command.split()
    process = subprocess.run(arguments, capture_output=True, text=True)

    result: str = process.stdout

    return result


def read_variable(name: str) -> typing.Any:
    with open(f'{variable_directory}/{name}') as variable_file:
        value = variable_file.read()

    if value[-1] == '\n':
        value = value[:-1]

    match value:
        case 'true':
            return True
        case 'false':
            return False
        case 'null':
            return None

    try:
        return int(value)
    except ValueError:
        pass

    try:
        return float(value)
    except ValueError:
        pass

    return value


def write_variable(name: str, value: typing.Any) -> None:
    match value:
        case True:
            value = 'true'
        case False:
            value = 'false'
        case None:
            value = 'null'

    with open(f'{variable_directory}/{name}', 'w') as variable_file:
        print(value, file=variable_file)


def update_directory(path: str) -> None:
    if os.path.isfile(path):
        os.remove(path)

    elif os.path.isdir(path):
        shutil.rmtree(path)

    os.mkdir(path)
