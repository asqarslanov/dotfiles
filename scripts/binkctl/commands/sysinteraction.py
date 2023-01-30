import os
import shutil
import subprocess
import sys
import typing

username = os.getlogin()
hypr_directory = f'/home/{username}/.config/hypr'

commands_directory = os.path.dirname(__file__)
base_directory = os.path.dirname(commands_directory)
vars_directory = os.path.join(base_directory, 'vars')


def convert_to_json(object: typing.Any) -> str:
    match object:
        case True:
            return 'true'
        case False:
            return 'false'
        case None:
            return 'null'

    if isinstance(object, str):
        return object

    return str(object)


def convert_to_python(
        object: str
) -> typing.Union[bool, float, int, str, None]:
    match object:
        case 'true':
            return True
        case 'false':
            return False
        case 'null':
            return None

    try:
        return int(object)
    except ValueError:
        pass

    try:
        return float(object)
    except ValueError:
        pass

    return object


def execute(command: str, silent: bool = True) -> None:
    arguments = command.split()

    if silent:
        subprocess.run(arguments, stdout=subprocess.DEVNULL)
    else:
        subprocess.run(arguments)


def exit_with_error(reloading: bool = False) -> None:
    if reloading:
        print(
            "Invalid arguments! Reloading…\n"
            ""
        )
    else:
        print(
            "Invalid arguments!\n"
            ""
        )

    INVALID_ARGUMENT_CODE = 22
    sys.exit(INVALID_ARGUMENT_CODE)


def get_command_output(command: str) -> str:
    arguments = command.split()
    process = subprocess.run(arguments, capture_output=True, text=True)

    result: str = process.stdout

    return result


def read_variable(name: str, convert: bool = True) -> typing.Any:
    variable_file_path = os.path.join(vars_directory, name)

    if not os.path.isfile(variable_file_path):
        if convert:
            return None
        else:
            return convert_to_json(None)

    with open(variable_file_path) as variable_file:
        value = variable_file.read()

    value = value.removesuffix('\n')

    if convert:
        value = convert_to_python(value)

    return value


def reload_system(exit: bool = True) -> None:
    command = 'hyprctl reload'
    execute(command)

    if exit:
        exit_with_error(True)


def set_keyword(key: str, value) -> None:
    command = f'hyprctl keyword {key} {value}'
    execute(command)


def source_config(path: str) -> None:
    set_keyword('source', path)


def print_success_message() -> None:
    print(
        "Success!\n"
        ""
    )


def update_directory(path: str) -> None:
    if os.path.isfile(path):
        os.remove(path)

    elif os.path.isdir(path):
        shutil.rmtree(path)

    os.mkdir(path)


def write_variable(name: str, value: typing.Any, convert: bool = True) -> None:
    if convert:
        value = convert_to_json(value)

    variable_file_path = os.path.join(vars_directory, name)

    with open(variable_file_path, 'w') as variable_file:
        print(value, file=variable_file)
